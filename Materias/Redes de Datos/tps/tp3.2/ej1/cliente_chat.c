/*
 * cliente_chat.c  -  TP 3.2 Redes de Datos (UNNE FaCENA) - Ejercicio 1
 *
 * Cliente de chat por consola sobre TCP. Usa dos hilos:
 *   - hilo principal: lee lo que escribe el usuario y lo envía al servidor
 *   - hilo receptor : recibe los mensajes del servidor y los muestra en tiempo
 *                     real (la recepción no se bloquea mientras se escribe)
 *
 * Compilar:  gcc -Wall -Wextra -pthread -o cliente_chat cliente_chat.c
 * Ejecutar:  ./cliente_chat [host] [puerto]   (si faltan, se piden por teclado)
 *
 * Comandos: /listar  /quitar  /ayuda    (Ctrl+C o Ctrl+D también salen con /quitar)
 */
#define _GNU_SOURCE
#include <arpa/inet.h>      /* inet_ntop(), ntohs()                          */
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>          /* fcntl(): socket no bloqueante para el timeout */
#include <netdb.h>          /* getaddrinfo(): resolver nombre/IP del servidor */
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <sys/select.h>
#include <sys/socket.h>     /* socket(), connect(), send(), recv()           */
#include <time.h>
#include <unistd.h>

#define HOST_DEFECTO      "127.0.0.1"
#define PUERTO_DEFECTO    "5000"
#define MAX_LINEA         512
#define MAX_MENSAJE       400
#define TIMEOUT_CONEXION  5        /* segundos */

#define RESET    "\033[0m"
#define NEGRITA  "\033[1m"
#define CIAN     "\033[36m"
#define AMARILLO "\033[33m"
#define ROJO     "\033[31m"
#define VERDE    "\033[32m"
#define GRIS     "\033[90m"
#define COL(c)   (interactivo ? (c) : "")

typedef struct {
    char   datos[MAX_LINEA * 2];
    size_t len;
} lector_t;

static int      fd_srv = -1;
static lector_t lector;
static char     mi_nombre[32] = "";
static int      interactivo = 0;
static volatile sig_atomic_t saliendo = 0;
static pthread_mutex_t mutex_pantalla = PTHREAD_MUTEX_INITIALIZER;

/* ------------------------------------------------------------------ */

static int enviar_todo(int fd, const char *buf, size_t len)
{
    while (len > 0) {
        ssize_t n = send(fd, buf, len, MSG_NOSIGNAL);            /* send() */
        if (n < 0) {
            if (errno == EINTR) continue;
            return -1;
        }
        buf += n;
        len -= (size_t)n;
    }
    return 0;
}

static int enviar_linea(int fd, const char *texto)
{
    char buf[MAX_LINEA + 2];
    int n = snprintf(buf, sizeof buf, "%s\n", texto);
    if (n < 0 || (size_t)n >= sizeof buf) return -1;
    return enviar_todo(fd, buf, (size_t)n);
}

/* Igual que en el servidor: junta bytes hasta encontrar '\n'.
 * 1 = línea, 0 = servidor cerró, -1 = error */
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

static void recortar(char *s)
{
    size_t i = 0, n = strlen(s);
    while (i < n && isspace((unsigned char)s[i])) i++;
    while (n > i && isspace((unsigned char)s[n - 1])) n--;
    memmove(s, s + i, n - i);
    s[n - i] = '\0';
}

/* Pide un dato por teclado; si se deja vacío usa 'defecto' (si no es NULL). */
static void pedir(const char *mensaje, char *dst, size_t tam, const char *defecto)
{
    printf("%s", mensaje);
    fflush(stdout);
    if (!fgets(dst, (int)tam, stdin)) {
        printf("\n");
        exit(0);
    }
    dst[strcspn(dst, "\r\n")] = '\0';
    recortar(dst);
    if (dst[0] == '\0' && defecto) snprintf(dst, tam, "%s", defecto);
}

/* Debe llamarse con mutex_pantalla tomado */
static void mostrar_prompt(void)
{
    if (!interactivo) return;
    printf("%s%s>%s ", COL(NEGRITA), mi_nombre, COL(RESET));
    fflush(stdout);
}

static void hora_actual(char *dst, size_t tam)
{
    time_t t = time(NULL);
    struct tm tm;
    localtime_r(&t, &tm);
    strftime(dst, tam, "%H:%M", &tm);
}

/* Muestra una línea recibida del servidor con un color según su etiqueta */
static void mostrar_del_servidor(const char *linea)
{
    char h[8];
    hora_actual(h, sizeof h);
    pthread_mutex_lock(&mutex_pantalla);
    if (interactivo) printf("\r\033[K");      /* borra el prompt de la línea actual */

    if (strncmp(linea, "MSG ", 4) == 0) {
        const char *txt = linea + 4;
        const char *sep = strstr(txt, ": ");
        if (sep)
            printf("%s[%s]%s %s%.*s%s: %s\n", COL(GRIS), h, COL(RESET),
                   COL(NEGRITA CIAN), (int)(sep - txt), txt, COL(RESET), sep + 2);
        else
            printf("[%s] %s\n", h, txt);
    } else if (strncmp(linea, "SYS ", 4) == 0) {
        printf("%s[%s] * %s%s\n", COL(AMARILLO), h, linea + 4, COL(RESET));
    } else if (strncmp(linea, "LST ", 4) == 0) {
        printf("%s[%s] %s%s\n", COL(VERDE), h, linea + 4, COL(RESET));
    } else if (strncmp(linea, "ERR ", 4) == 0) {
        printf("%s[%s] ! %s%s\n", COL(ROJO), h, linea + 4, COL(RESET));
    } else if (strncmp(linea, "OK ", 3) != 0) {
        printf("%s\n", linea);
    }
    mostrar_prompt();
    pthread_mutex_unlock(&mutex_pantalla);
}

/* Hilo receptor: muestra en tiempo real todo lo que llega del servidor */
static void *recibir(void *arg)
{
    (void)arg;
    char linea[MAX_LINEA + 64];
    int r;
    while ((r = leer_linea(fd_srv, &lector, linea, sizeof linea)) == 1)
        mostrar_del_servidor(linea);

    pthread_mutex_lock(&mutex_pantalla);
    if (interactivo) printf("\r\033[K");
    if (saliendo) {
        printf("Desconectado del servidor.\n");
        fflush(stdout);
        close(fd_srv);                                                /* close() */
        exit(0);
    }
    printf("%s! Se perdió la conexión con el servidor (%s).%s\n", COL(ROJO),
           r == 0 ? "el servidor cerró la conexión" : strerror(errno), COL(RESET));
    fflush(stdout);
    close(fd_srv);
    exit(1);
}

/* Ctrl+C: avisa al servidor con /quitar en lugar de cortar de golpe.
 * send() es seguro de usar dentro de un manejador de señales. */
static void al_interrumpir(int sig)
{
    (void)sig;
    saliendo = 1;
    if (fd_srv >= 0) send(fd_srv, "/quitar\n", 8, MSG_NOSIGNAL);
}

/* Resuelve el host y se conecta con un tiempo máximo de espera.
 * Devuelve el descriptor del socket conectado o -1. */
static int conectar(const char *host, const char *puerto)
{
    struct addrinfo pistas, *res, *p;
    memset(&pistas, 0, sizeof pistas);
    pistas.ai_family   = AF_INET;          /* IPv4 */
    pistas.ai_socktype = SOCK_STREAM;      /* TCP  */

    int e = getaddrinfo(host, puerto, &pistas, &res);
    if (e != 0) {
        fprintf(stderr, "No se pudo resolver '%s': %s\n", host, gai_strerror(e));
        return -1;
    }

    int fd = -1, err = 0;
    for (p = res; p; p = p->ai_next) {
        /* (1) socket(): crea el socket TCP del cliente */
        fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
        if (fd < 0) {
            err = errno;
            continue;
        }

        /* (2) connect(): inicia el three-way handshake (SYN, SYN-ACK, ACK).
         * Se hace no bloqueante para poder limitar la espera con select(). */
        int flags = fcntl(fd, F_GETFL, 0);
        fcntl(fd, F_SETFL, flags | O_NONBLOCK);
        int r = connect(fd, p->ai_addr, p->ai_addrlen);
        if (r < 0 && errno == EINPROGRESS) {
            fd_set escritura;
            FD_ZERO(&escritura);
            FD_SET(fd, &escritura);
            struct timeval tv = { .tv_sec = TIMEOUT_CONEXION, .tv_usec = 0 };
            r = select(fd + 1, NULL, &escritura, NULL, &tv);
            if (r == 0) {
                err = ETIMEDOUT;
                r = -1;
            } else if (r > 0) {
                socklen_t l = sizeof err;
                getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &l);
                r = err ? -1 : 0;
            } else {
                err = errno;
            }
        } else if (r < 0) {
            err = errno;
        }

        if (r == 0) {
            fcntl(fd, F_SETFL, flags);      /* volver a modo bloqueante */
            break;
        }
        close(fd);
        fd = -1;
    }
    freeaddrinfo(res);

    if (fd < 0) {
        if (err == ECONNREFUSED)
            fprintf(stderr, "Conexión rechazada: no hay ningún servidor escuchando en %s:%s\n", host, puerto);
        else if (err == ETIMEDOUT)
            fprintf(stderr, "Tiempo de espera agotado (%d s): el host %s no responde. "
                            "¿La IP es correcta? ¿Hay un firewall?\n", TIMEOUT_CONEXION, host);
        else if (err == EHOSTUNREACH || err == ENETUNREACH)
            fprintf(stderr, "Host o red inalcanzable: %s\n", host);
        else
            fprintf(stderr, "No se pudo conectar: %s\n", strerror(err));
    }
    return fd;
}

int main(int argc, char *argv[])
{
    char host[256], puerto[16];
    interactivo = isatty(STDIN_FILENO) && isatty(STDOUT_FILENO);
    signal(SIGPIPE, SIG_IGN);

    printf("=== Cliente de chat TCP - Redes de Datos (UNNE) ===\n");
    if (argc >= 2) snprintf(host, sizeof host, "%s", argv[1]);
    else pedir("IP o nombre del servidor [" HOST_DEFECTO "]: ", host, sizeof host, HOST_DEFECTO);
    if (argc >= 3) snprintf(puerto, sizeof puerto, "%s", argv[2]);
    else pedir("Puerto del servidor [" PUERTO_DEFECTO "]: ", puerto, sizeof puerto, PUERTO_DEFECTO);

    char *fin;
    long p = strtol(puerto, &fin, 10);
    if (*fin != '\0' || p < 1 || p > 65535) {
        fprintf(stderr, "Puerto inválido: '%s' (debe ser un número entre 1 y 65535)\n", puerto);
        return 1;
    }

    printf("Conectando a %s:%s ...\n", host, puerto);
    fd_srv = conectar(host, puerto);
    if (fd_srv < 0) return 1;

    /* Mostrar la tupla de la conexión (útil para comparar con Wireshark) */
    struct sockaddr_in loc, rem;
    socklen_t l1 = sizeof loc, l2 = sizeof rem;
    getsockname(fd_srv, (struct sockaddr *)&loc, &l1);
    getpeername(fd_srv, (struct sockaddr *)&rem, &l2);
    char ip_loc[INET_ADDRSTRLEN], ip_rem[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &loc.sin_addr, ip_loc, sizeof ip_loc);
    inet_ntop(AF_INET, &rem.sin_addr, ip_rem, sizeof ip_rem);
    printf("%sConexión exitosa%s: %s:%d (cliente) -> %s:%d (servidor)\n",
           COL(VERDE NEGRITA), COL(RESET), ip_loc, ntohs(loc.sin_port), ip_rem, ntohs(rem.sin_port));

    /* Bienvenida y registro del nombre de usuario */
    char linea[MAX_LINEA + 64];
    if (leer_linea(fd_srv, &lector, linea, sizeof linea) <= 0) {
        fprintf(stderr, "El servidor cerró la conexión.\n");
        return 1;
    }
    if (strncmp(linea, "SYS ", 4) == 0 || strncmp(linea, "ERR ", 4) == 0)
        printf("%s\n", linea + 4);

    for (;;) {
        char nombre[64];
        pedir("Nombre de usuario: ", nombre, sizeof nombre, NULL);
        if (nombre[0] == '\0') continue;
        if (enviar_linea(fd_srv, nombre) < 0) {
            fprintf(stderr, "Error al enviar el nombre: %s\n", strerror(errno));
            return 1;
        }
        int r = leer_linea(fd_srv, &lector, linea, sizeof linea);
        if (r <= 0) {
            fprintf(stderr, "El servidor cerró la conexión.\n");
            return 1;
        }
        if (strncmp(linea, "OK ", 3) == 0) {
            snprintf(mi_nombre, sizeof mi_nombre, "%.31s", linea + 3);   /* el servidor limita a 20 */
            break;
        }
        printf("%s! %s%s\n", COL(ROJO), strncmp(linea, "ERR ", 4) == 0 ? linea + 4 : linea, COL(RESET));
    }

    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_handler = al_interrumpir;        /* sin SA_RESTART: fgets() se interrumpe */
    sigemptyset(&sa.sa_mask);
    sigaction(SIGINT, &sa, NULL);

    pthread_t hilo;
    if (pthread_create(&hilo, NULL, recibir, NULL) != 0) {
        fprintf(stderr, "No se pudo crear el hilo receptor\n");
        return 1;
    }

    /* Hilo principal: leer teclado y enviar */
    char entrada[2048];
    pthread_mutex_lock(&mutex_pantalla);
    mostrar_prompt();
    pthread_mutex_unlock(&mutex_pantalla);

    while (!saliendo && fgets(entrada, sizeof entrada, stdin)) {
        size_t n = strlen(entrada);
        int demasiado_larga = 0;
        if (n > 0 && entrada[n - 1] != '\n' && !feof(stdin)) {
            int ch;
            while ((ch = getchar()) != '\n' && ch != EOF) {}
            demasiado_larga = 1;
        }
        entrada[strcspn(entrada, "\r\n")] = '\0';
        recortar(entrada);

        if (entrada[0] == '\0' || demasiado_larga || strlen(entrada) > MAX_MENSAJE) {
            pthread_mutex_lock(&mutex_pantalla);
            if (entrada[0] != '\0')
                printf("%s! Mensaje demasiado largo (máximo %d caracteres)%s\n",
                       COL(ROJO), MAX_MENSAJE, COL(RESET));
            mostrar_prompt();
            pthread_mutex_unlock(&mutex_pantalla);
            continue;
        }

        if (strcasecmp(entrada, "/quitar") == 0) saliendo = 1;
        if (enviar_linea(fd_srv, entrada) < 0) {
            fprintf(stderr, "Error al enviar: se perdió la conexión con el servidor\n");
            return 1;
        }
        if (saliendo) break;

        pthread_mutex_lock(&mutex_pantalla);
        mostrar_prompt();
        pthread_mutex_unlock(&mutex_pantalla);
    }

    if (!saliendo) {                       /* Ctrl+D (fin de entrada) */
        saliendo = 1;
        enviar_linea(fd_srv, "/quitar");
    }
    pthread_join(hilo, NULL);              /* el receptor termina cuando el servidor cierra */
    return 0;
}
