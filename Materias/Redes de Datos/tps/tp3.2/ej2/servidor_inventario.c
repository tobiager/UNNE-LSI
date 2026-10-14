/*
 * servidor_inventario.c  -  TP 3.2 Redes de Datos (UNNE FaCENA) - Ejercicio 2, escenario 2
 *
 * Servidor de consultas de características HW/SW para inventario.
 * Los equipos a inventariar ejecutan "agente_inventario" y se conectan a este
 * servidor. Desde el menú del servidor se elige un equipo y se le envían
 * consultas (CPU, RAM, disco, filesystem, loadavg, particiones, SO, red,
 * procesos); el agente las responde leyendo /proc y comandos del sistema.
 *
 * Compilar:  gcc -Wall -Wextra -pthread -o servidor_inventario servidor_inventario.c
 * Ejecutar:  ./servidor_inventario [puerto]         (por defecto 6000)
 *
 * Protocolo de aplicación (sobre TCP):
 *   Agente -> Servidor : HOLA <hostname>\n           (al conectarse)
 *   Servidor -> Agente : OK <id>\n
 *   Servidor -> Agente : CONSULTA <tipo>\n
 *   Agente -> Servidor : RESP <n>\n<n bytes de texto>   o   ERR <n>\n<n bytes>
 *   Servidor -> Agente : FIN\n                       (al cerrar el servidor)
 * La respuesta lleva su longitud en bytes porque puede tener muchas líneas:
 * así el servidor sabe exactamente cuántos bytes leer del flujo TCP.
 */
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <ctype.h>
#include <errno.h>
#include <ifaddrs.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#define PUERTO_DEFECTO     6000
#define MAX_EQUIPOS        32
#define MAX_LINEA          512
#define MAX_RESPUESTA      (8 * 1024 * 1024)
#define TIMEOUT_SALUDO     5     /* segundos para recibir HOLA */
#define TIMEOUT_RESPUESTA  15    /* segundos para recibir cada respuesta */

typedef struct {
    char   datos[MAX_LINEA * 2];
    size_t len;
} lector_t;

typedef struct {
    int      fd, id, puerto;
    char     host[64];
    char     ip[INET_ADDRSTRLEN];
    time_t   desde;
    lector_t lr;
} equipo_t;

static const struct {
    const char *clave;
    const char *descripcion;
} CONSULTAS[] = {
    { "cpu",         "Características del procesador" },
    { "ram",         "Memoria RAM y swap" },
    { "disco",       "Estado de los discos (uso y espacio libre)" },
    { "fs",          "Sistemas de archivos montados" },
    { "loadavg",     "Promedio de carga (loadavg) y uptime" },
    { "particiones", "Particiones" },
    { "so",          "Versión del sistema operativo y hostname" },
    { "red",         "Interfaces de red" },
    { "procesos",    "Procesos en ejecución" },
};
#define N_CONSULTAS ((int)(sizeof CONSULTAS / sizeof CONSULTAS[0]))

static equipo_t *equipos[MAX_EQUIPOS];
static int proximo_id = 1;
static int fd_escucha = -1;
static pthread_mutex_t mutex_equipos  = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t mutex_pantalla = PTHREAD_MUTEX_INITIALIZER;

/* ------------------------------------------------------------------ */
/* Utilidades de sockets                                               */
/* ------------------------------------------------------------------ */

static int enviar_todo(int fd, const char *buf, size_t len)
{
    while (len > 0) {
        ssize_t n = send(fd, buf, len, MSG_NOSIGNAL);             /* send() */
        if (n < 0) {
            if (errno == EINTR) continue;
            return -1;
        }
        buf += n;
        len -= (size_t)n;
    }
    return 0;
}

static int enviar_fmt(int fd, const char *fmt, ...)
{
    char buf[MAX_LINEA + 2];
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(buf, sizeof buf - 1, fmt, ap);
    va_end(ap);
    if (n < 0) return -1;
    if ((size_t)n > sizeof buf - 2) n = (int)(sizeof buf - 2);
    buf[n++] = '\n';
    return enviar_todo(fd, buf, (size_t)n);
}

/* 1 = línea, 0 = el agente cerró, -1 = error o tiempo agotado */
static int leer_linea(int fd, lector_t *lr, char *linea, size_t tam)
{
    for (;;) {
        char  *nl = memchr(lr->datos, '\n', lr->len);
        size_t n;
        if (nl)
            n = (size_t)(nl - lr->datos);
        else if (lr->len == sizeof lr->datos)
            n = lr->len;
        else {
            ssize_t r = recv(fd, lr->datos + lr->len,                  /* recv() */
                             sizeof lr->datos - lr->len, 0);
            if (r == 0) return 0;
            if (r < 0) {
                if (errno == EINTR) continue;
                return -1;
            }
            lr->len += (size_t)r;
            continue;
        }
        size_t copiar = n < tam - 1 ? n : tam - 1;
        memcpy(linea, lr->datos, copiar);
        linea[copiar] = '\0';
        size_t consumir = nl ? n + 1 : n;
        memmove(lr->datos, lr->datos + consumir, lr->len - consumir);
        lr->len -= consumir;
        if (copiar > 0 && linea[copiar - 1] == '\r') linea[copiar - 1] = '\0';
        return 1;
    }
}

/* Lee exactamente n bytes (primero lo que quedó en el buffer, luego recv) */
static int leer_bloque(int fd, lector_t *lr, char *dst, size_t n)
{
    size_t del_buffer = lr->len < n ? lr->len : n;
    memcpy(dst, lr->datos, del_buffer);
    memmove(lr->datos, lr->datos + del_buffer, lr->len - del_buffer);
    lr->len -= del_buffer;

    size_t hecho = del_buffer;
    while (hecho < n) {
        ssize_t r = recv(fd, dst + hecho, n - hecho, 0);              /* recv() */
        if (r == 0) return 0;
        if (r < 0) {
            if (errno == EINTR) continue;
            return -1;
        }
        hecho += (size_t)r;
    }
    return 1;
}

static void avisar(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    pthread_mutex_lock(&mutex_pantalla);
    printf("\n");
    vprintf(fmt, ap);
    printf("\n");
    fflush(stdout);
    pthread_mutex_unlock(&mutex_pantalla);
    va_end(ap);
}

/* ------------------------------------------------------------------ */
/* Gestión de equipos conectados                                       */
/* ------------------------------------------------------------------ */

static void desconectar_equipo(equipo_t *e, const char *motivo)
{
    pthread_mutex_lock(&mutex_equipos);
    for (int i = 0; i < MAX_EQUIPOS; i++)
        if (equipos[i] == e) equipos[i] = NULL;
    pthread_mutex_unlock(&mutex_equipos);
    avisar("[-] Equipo #%d %s (%s:%d) desconectado: %s", e->id, e->host, e->ip, e->puerto, motivo);
    close(e->fd);                                                     /* close() */
    free(e);
}

/* Detecta agentes que se cayeron mientras estaban inactivos:
 * recv con MSG_PEEK no consume datos; si devuelve 0 el otro extremo cerró. */
static void verificar_conexiones(void)
{
    equipo_t *caidos[MAX_EQUIPOS];
    int n = 0;
    pthread_mutex_lock(&mutex_equipos);
    for (int i = 0; i < MAX_EQUIPOS; i++) {
        if (!equipos[i]) continue;
        char c;
        ssize_t r = recv(equipos[i]->fd, &c, 1, MSG_PEEK | MSG_DONTWAIT);
        if (r == 0 || (r < 0 && errno != EAGAIN && errno != EWOULDBLOCK))
            caidos[n++] = equipos[i];
    }
    pthread_mutex_unlock(&mutex_equipos);
    for (int i = 0; i < n; i++)
        desconectar_equipo(caidos[i], "la conexión se cerró");
}

static equipo_t *buscar_equipo(int id)
{
    equipo_t *e = NULL;
    pthread_mutex_lock(&mutex_equipos);
    for (int i = 0; i < MAX_EQUIPOS; i++)
        if (equipos[i] && equipos[i]->id == id) e = equipos[i];
    pthread_mutex_unlock(&mutex_equipos);
    return e;
}

/* Envía una consulta y recibe la respuesta completa.
 * 0 = ok, 1 = el agente respondió con error, -1 = conexión perdida */
static int consultar(equipo_t *e, const char *tipo, char **respuesta)
{
    char linea[MAX_LINEA];
    *respuesta = NULL;

    if (enviar_fmt(e->fd, "CONSULTA %s", tipo) < 0) return -1;

    int r = leer_linea(e->fd, &e->lr, linea, sizeof linea);
    if (r <= 0) return -1;

    int es_error = 0;
    long n;
    if (strncmp(linea, "RESP ", 5) == 0) {
        n = strtol(linea + 5, NULL, 10);
    } else if (strncmp(linea, "ERR ", 4) == 0) {
        es_error = 1;
        n = strtol(linea + 4, NULL, 10);
    } else {
        return -1;                                     /* respuesta inválida */
    }
    if (n < 0 || n > MAX_RESPUESTA) return -1;

    *respuesta = malloc((size_t)n + 1);
    if (!*respuesta) return -1;
    if (leer_bloque(e->fd, &e->lr, *respuesta, (size_t)n) <= 0) {
        free(*respuesta);
        *respuesta = NULL;
        return -1;
    }
    (*respuesta)[n] = '\0';
    return es_error;
}

/* Hilo que acepta agentes en segundo plano mientras el menú sigue activo */
static void *aceptar_equipos(void *arg)
{
    (void)arg;
    for (;;) {
        struct sockaddr_in cli;
        socklen_t lc = sizeof cli;
        /* (4) accept(): espera y acepta la conexión de un agente */
        int fd = accept(fd_escucha, (struct sockaddr *)&cli, &lc);
        if (fd < 0) {
            if (errno == EINTR || errno == ECONNABORTED) continue;
            if (errno == EBADF || errno == EINVAL) break;  /* socket cerrado */
            avisar("[!] accept falló: %s", strerror(errno));
            sleep(1);
            continue;
        }

        equipo_t *e = calloc(1, sizeof *e);
        if (!e) {
            close(fd);
            continue;
        }
        e->fd = fd;
        e->desde = time(NULL);
        inet_ntop(AF_INET, &cli.sin_addr, e->ip, sizeof e->ip);
        e->puerto = ntohs(cli.sin_port);

        /* Tiempo máximo de espera para el saludo y luego para cada respuesta */
        struct timeval tv = { .tv_sec = TIMEOUT_SALUDO, .tv_usec = 0 };
        setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);
        setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv);

        char linea[MAX_LINEA];
        int r = leer_linea(fd, &e->lr, linea, sizeof linea);
        if (r <= 0 || strncmp(linea, "HOLA ", 5) != 0) {
            enviar_fmt(fd, "ERR Protocolo inválido: se esperaba 'HOLA <hostname>'");
            avisar("[!] Conexión de %s:%d rechazada: no es un agente de inventario", e->ip, e->puerto);
            close(fd);
            free(e);
            continue;
        }
        /* Copiar el hostname aceptando solo caracteres seguros */
        size_t j = 0;
        for (const char *s = linea + 5; *s && j < sizeof e->host - 1; s++)
            if (isalnum((unsigned char)*s) || *s == '-' || *s == '_' || *s == '.')
                e->host[j++] = *s;
        e->host[j] = '\0';
        if (j == 0) snprintf(e->host, sizeof e->host, "desconocido");

        int lugar = -1;
        pthread_mutex_lock(&mutex_equipos);
        for (int i = 0; i < MAX_EQUIPOS && lugar < 0; i++)
            if (!equipos[i]) lugar = i;
        if (lugar >= 0) {
            e->id = proximo_id++;
            equipos[lugar] = e;
        }
        pthread_mutex_unlock(&mutex_equipos);

        if (lugar < 0) {
            enviar_fmt(fd, "ERR Servidor lleno (máximo %d equipos)", MAX_EQUIPOS);
            avisar("[!] %s rechazado: servidor lleno", e->host);
            close(fd);
            free(e);
            continue;
        }

        tv.tv_sec = TIMEOUT_RESPUESTA;
        setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);
        enviar_fmt(fd, "OK %d", e->id);
        avisar("[+] Equipo #%d conectado: %s (%s:%d)", e->id, e->host, e->ip, e->puerto);
    }
    return NULL;
}

/* ------------------------------------------------------------------ */
/* Menú                                                                */
/* ------------------------------------------------------------------ */

static void apagar(void)
{
    pthread_mutex_lock(&mutex_equipos);
    for (int i = 0; i < MAX_EQUIPOS; i++) {
        if (!equipos[i]) continue;
        enviar_fmt(equipos[i]->fd, "FIN");
        close(equipos[i]->fd);
    }
    pthread_mutex_unlock(&mutex_equipos);
    shutdown(fd_escucha, SHUT_RDWR);
    close(fd_escucha);
    printf("Servidor detenido.\n");
    exit(0);
}

/* Lee un entero del teclado. Devuelve -1 si la entrada no es un número. */
static int leer_entero(const char *mensaje)
{
    char buf[64];
    pthread_mutex_lock(&mutex_pantalla);
    printf("%s", mensaje);
    fflush(stdout);
    pthread_mutex_unlock(&mutex_pantalla);
    if (!fgets(buf, sizeof buf, stdin)) apagar();     /* Ctrl+D */
    char *fin;
    long v = strtol(buf, &fin, 10);
    while (*fin == ' ' || *fin == '\n' || *fin == '\r') fin++;
    if (fin == buf || *fin != '\0') return -1;
    return (int)v;
}

static int listar_equipos(void)
{
    verificar_conexiones();
    int n = 0;
    time_t ahora = time(NULL);
    pthread_mutex_lock(&mutex_equipos);
    pthread_mutex_lock(&mutex_pantalla);
    printf("\n  %-4s %-22s %-22s %s\n", "ID", "Hostname", "IP:puerto (agente)", "Conectado hace");
    for (int i = 0; i < MAX_EQUIPOS; i++) {
        equipo_t *e = equipos[i];
        if (!e) continue;
        char dir[40];
        snprintf(dir, sizeof dir, "%s:%d", e->ip, e->puerto);
        long s = (long)(ahora - e->desde);
        printf("  #%-3d %-22s %-22s %ldm %02lds\n", e->id, e->host, dir, s / 60, s % 60);
        n++;
    }
    if (n == 0) printf("  (no hay equipos conectados: ejecute agente_inventario en los clientes)\n");
    pthread_mutex_unlock(&mutex_pantalla);
    pthread_mutex_unlock(&mutex_equipos);
    return n;
}

static equipo_t *elegir_equipo(void)
{
    if (listar_equipos() == 0) return NULL;
    int id = leer_entero("ID del equipo: ");
    equipo_t *e = buscar_equipo(id);
    if (!e) printf("No existe un equipo con ese ID.\n");
    return e;
}

static int elegir_consulta(void)
{
    printf("\n");
    for (int i = 0; i < N_CONSULTAS; i++)
        printf("  %d) %-12s %s\n", i + 1, CONSULTAS[i].clave, CONSULTAS[i].descripcion);
    int op = leer_entero("Consulta: ");
    if (op < 1 || op > N_CONSULTAS) {
        printf("Opción inválida.\n");
        return -1;
    }
    return op - 1;
}

static void imprimir_resultado(FILE *f, const equipo_t *e, int c, const char *texto, int es_error)
{
    fprintf(f, "\n========== %s @ %s (%s) ==========\n", CONSULTAS[c].descripcion, e->host, e->ip);
    fprintf(f, "%s%s", es_error ? "ERROR: " : "", texto);
    if (texto[0] && texto[strlen(texto) - 1] != '\n') fprintf(f, "\n");
}

/* Ejecuta una consulta y muestra el resultado. Devuelve -1 si se perdió el equipo. */
static int ejecutar_consulta(equipo_t *e, int c, FILE *copia)
{
    char *resp;
    int r = consultar(e, CONSULTAS[c].clave, &resp);
    if (r < 0) {
        desconectar_equipo(e, errno == EAGAIN || errno == EWOULDBLOCK
                                  ? "no respondió a tiempo" : "se perdió la conexión");
        return -1;
    }
    pthread_mutex_lock(&mutex_pantalla);
    imprimir_resultado(stdout, e, c, resp, r);
    pthread_mutex_unlock(&mutex_pantalla);
    if (copia) imprimir_resultado(copia, e, c, resp, r);
    free(resp);
    return 0;
}

static void inventario_completo(equipo_t *e)
{
    char nombre[128], fecha[32];
    time_t t = time(NULL);
    struct tm tm;
    localtime_r(&t, &tm);
    strftime(fecha, sizeof fecha, "%Y%m%d_%H%M%S", &tm);
    snprintf(nombre, sizeof nombre, "inventario_%s_%s.txt", e->host, fecha);

    FILE *f = fopen(nombre, "w");
    if (f) {
        strftime(fecha, sizeof fecha, "%d/%m/%Y %H:%M:%S", &tm);
        fprintf(f, "INVENTARIO HW/SW - equipo %s (%s) - %s\n", e->host, e->ip, fecha);
    }
    for (int c = 0; c < N_CONSULTAS; c++)
        if (ejecutar_consulta(e, c, f) < 0) break;
    if (f) {
        fclose(f);
        printf("\nInventario guardado en: %s\n", nombre);
    }
}

static void consultar_todos(void)
{
    if (listar_equipos() == 0) return;
    int c = elegir_consulta();
    if (c < 0) return;
    int ids[MAX_EQUIPOS], n = 0;
    pthread_mutex_lock(&mutex_equipos);
    for (int i = 0; i < MAX_EQUIPOS; i++)
        if (equipos[i]) ids[n++] = equipos[i]->id;
    pthread_mutex_unlock(&mutex_equipos);
    for (int i = 0; i < n; i++) {
        equipo_t *e = buscar_equipo(ids[i]);
        if (e) ejecutar_consulta(e, c, NULL);
    }
}

static void mostrar_direcciones(int puerto)
{
    struct ifaddrs *ifs, *i;
    printf("Servidor de inventario escuchando en el puerto TCP %d. Direcciones de este equipo:\n", puerto);
    if (getifaddrs(&ifs) == 0) {
        for (i = ifs; i; i = i->ifa_next) {
            if (!i->ifa_addr || i->ifa_addr->sa_family != AF_INET) continue;
            char ip[INET_ADDRSTRLEN];
            inet_ntop(AF_INET, &((struct sockaddr_in *)i->ifa_addr)->sin_addr, ip, sizeof ip);
            printf("   %-10s %s:%d\n", i->ifa_name, ip, puerto);
        }
        freeifaddrs(ifs);
    }
}

int main(int argc, char *argv[])
{
    int puerto = PUERTO_DEFECTO;
    if (argc > 1) {
        char *fin;
        long p = strtol(argv[1], &fin, 10);
        if (*fin != '\0' || p < 1 || p > 65535) {
            fprintf(stderr, "Puerto inválido: '%s'. Uso: %s [puerto 1-65535]\n", argv[1], argv[0]);
            return 1;
        }
        puerto = (int)p;
    }
    signal(SIGPIPE, SIG_IGN);

    /* (1) socket() TCP/IPv4 */
    fd_escucha = socket(AF_INET, SOCK_STREAM, 0);
    if (fd_escucha < 0) {
        perror("socket");
        return 1;
    }
    int si = 1;
    setsockopt(fd_escucha, SOL_SOCKET, SO_REUSEADDR, &si, sizeof si);

    /* (2) bind() a 0.0.0.0:puerto */
    struct sockaddr_in dir;
    memset(&dir, 0, sizeof dir);
    dir.sin_family      = AF_INET;
    dir.sin_addr.s_addr = htonl(INADDR_ANY);
    dir.sin_port        = htons((uint16_t)puerto);
    if (bind(fd_escucha, (struct sockaddr *)&dir, sizeof dir) < 0) {
        if (errno == EADDRINUSE)
            fprintf(stderr, "Error: el puerto %d ya está en uso. Pruebe con: %s %d\n",
                    puerto, argv[0], puerto + 1);
        else
            perror("bind");
        return 1;
    }

    /* (3) listen() */
    if (listen(fd_escucha, 10) < 0) {
        perror("listen");
        return 1;
    }
    mostrar_direcciones(puerto);

    pthread_t hilo;
    if (pthread_create(&hilo, NULL, aceptar_equipos, NULL) != 0) {
        fprintf(stderr, "No se pudo crear el hilo aceptador\n");
        return 1;
    }
    pthread_detach(hilo);

    for (;;) {
        pthread_mutex_lock(&mutex_pantalla);
        printf("\n===== SERVIDOR DE INVENTARIO HW/SW =====\n"
               "  1) Listar equipos conectados\n"
               "  2) Consultar un equipo\n"
               "  3) Inventario completo de un equipo (y guardar en archivo)\n"
               "  4) Hacer una consulta a todos los equipos\n"
               "  0) Salir\n");
        pthread_mutex_unlock(&mutex_pantalla);
        int op = leer_entero("Opción: ");
        equipo_t *e;
        int c;
        switch (op) {
        case 1:
            listar_equipos();
            break;
        case 2:
            if ((e = elegir_equipo()) && (c = elegir_consulta()) >= 0)
                ejecutar_consulta(e, c, NULL);
            break;
        case 3:
            if ((e = elegir_equipo())) inventario_completo(e);
            break;
        case 4:
            consultar_todos();
            break;
        case 0:
            apagar();
            break;
        default:
            printf("Opción inválida.\n");
        }
    }
}
