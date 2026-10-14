/*
 * servidor_chat.c  -  TP 3.2 Redes de Datos (UNNE FaCENA) - Ejercicio 1
 *
 * Servidor central de chat sobre TCP. Acepta varios clientes en forma
 * concurrente (un hilo POSIX por cliente) y retransmite cada mensaje a
 * todos los demás clientes conectados.
 *
 * Compilar:  gcc -Wall -Wextra -pthread -o servidor_chat servidor_chat.c
 * Ejecutar:  ./servidor_chat [puerto]          (por defecto 5000)
 *
 * Protocolo de aplicación (texto plano, un mensaje por línea terminada en '\n'):
 *   Cliente -> Servidor
 *     1ra línea ........ nombre de usuario
 *     luego ............ texto libre, o los comandos /listar, /quitar, /ayuda
 *   Servidor -> Cliente (cada línea empieza con una etiqueta de 3 letras)
 *     OK  <nombre> ............ nombre aceptado
 *     MSG <usuario>: <texto> .. mensaje de otro usuario
 *     SYS <texto> ............. aviso del sistema (ingresos, salidas...)
 *     LST <texto> ............. respuesta a /listar
 *     ERR <texto> ............. error (nombre inválido, comando desconocido...)
 */
#define _GNU_SOURCE
#include <arpa/inet.h>      /* inet_ntop(), htons(), htonl()                */
#include <ctype.h>
#include <errno.h>
#include <ifaddrs.h>        /* getifaddrs(): listar IPs locales             */
#include <netinet/in.h>     /* struct sockaddr_in, INADDR_ANY               */
#include <pthread.h>        /* hilos: un hilo por cliente                   */
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <sys/socket.h>     /* socket(), bind(), listen(), accept(), send(), recv() */
#include <sys/time.h>
#include <time.h>
#include <unistd.h>         /* close()                                      */

#define PUERTO_DEFECTO   5000
#define MAX_CLIENTES     50
#define MAX_NOMBRE       20
#define MAX_LINEA        512
#define BACKLOG          10     /* conexiones pendientes en la cola de listen() */
#define INTENTOS_NOMBRE  3

typedef struct {
    char   datos[MAX_LINEA * 2];
    size_t len;
} lector_t;

typedef struct {
    int  fd;                         /* descriptor del socket conectado */
    char nombre[MAX_NOMBRE + 1];
    char ip[INET_ADDRSTRLEN];
    int  puerto;
} cliente_t;

static cliente_t *clientes[MAX_CLIENTES];          /* NULL = lugar libre */
static pthread_mutex_t mutex_clientes = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t mutex_log      = PTHREAD_MUTEX_INITIALIZER;
static volatile sig_atomic_t apagando = 0;
static int fd_escucha = -1;

/* ------------------------------------------------------------------ */
/* Utilidades                                                          */
/* ------------------------------------------------------------------ */

static void log_srv(const char *fmt, ...)
{
    char hora[16];
    time_t t = time(NULL);
    struct tm tm;
    localtime_r(&t, &tm);
    strftime(hora, sizeof hora, "%H:%M:%S", &tm);

    va_list ap;
    va_start(ap, fmt);
    pthread_mutex_lock(&mutex_log);
    printf("[%s] ", hora);
    vprintf(fmt, ap);
    printf("\n");
    fflush(stdout);
    pthread_mutex_unlock(&mutex_log);
    va_end(ap);
}

/* send() puede enviar menos bytes de los pedidos: se repite hasta enviar todo.
 * MSG_NOSIGNAL evita que el proceso muera con SIGPIPE si el cliente ya cerró. */
static int enviar_todo(int fd, const char *buf, size_t len)
{
    while (len > 0) {
        ssize_t n = send(fd, buf, len, MSG_NOSIGNAL);           /* send() */
        if (n < 0) {
            if (errno == EINTR) continue;
            return -1;
        }
        buf += n;
        len -= (size_t)n;
    }
    return 0;
}

/* Envía una línea con formato printf y agrega el '\n' del protocolo. */
static int enviar_fmt(int fd, const char *fmt, ...)
{
    char buf[MAX_LINEA + 64];
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(buf, sizeof buf - 1, fmt, ap);
    va_end(ap);
    if (n < 0) return -1;
    if ((size_t)n > sizeof buf - 2) n = (int)(sizeof buf - 2);
    buf[n++] = '\n';
    return enviar_todo(fd, buf, (size_t)n);
}

/* TCP es un flujo de bytes, no de mensajes: un recv() puede traer media línea
 * o varias juntas. Esta función acumula lo recibido hasta encontrar '\n'.
 * Retorna 1 = línea leída, 0 = el otro extremo cerró, -1 = error. */
static int leer_linea(int fd, lector_t *lr, char *linea, size_t tam)
{
    for (;;) {
        char  *nl = memchr(lr->datos, '\n', lr->len);
        size_t n;

        if (nl)
            n = (size_t)(nl - lr->datos);
        else if (lr->len == sizeof lr->datos)
            n = lr->len;                         /* línea demasiado larga: se corta */
        else {
            ssize_t r = recv(fd, lr->datos + lr->len,                 /* recv() */
                             sizeof lr->datos - lr->len, 0);
            if (r == 0) return 0;                /* el cliente cerró la conexión */
            if (r < 0) {
                if (errno == EINTR) continue;
                return -1;                       /* ej.: ECONNRESET (corte abrupto) */
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
        if (copiar > 0 && linea[copiar - 1] == '\r')   /* clientes Windows/telnet */
            linea[copiar - 1] = '\0';
        return 1;
    }
}

/* Reemplaza caracteres de control (datos inválidos) por espacios. */
static void sanear(char *s)
{
    for (; *s; s++)
        if ((unsigned char)*s < 32 || *s == 127) *s = ' ';
}

static void recortar(char *s)
{
    size_t i = 0, n = strlen(s);
    while (i < n && isspace((unsigned char)s[i])) i++;
    while (n > i && isspace((unsigned char)s[n - 1])) n--;
    memmove(s, s + i, n - i);
    s[n - i] = '\0';
}

static const char *validar_nombre(const char *n)
{
    size_t len = strlen(n);
    if (len == 0) return "El nombre no puede estar vacío";
    if (len > MAX_NOMBRE) return "El nombre es demasiado largo (máximo 20 caracteres)";
    if (n[0] == '/') return "El nombre no puede empezar con '/'";
    for (size_t i = 0; i < len; i++) {
        unsigned char c = (unsigned char)n[i];
        if (!isalnum(c) && c != '_' && c != '-' && c != '.')
            return "Use solo letras, números, '_', '-' o '.' (sin espacios ni tildes)";
    }
    return NULL;
}

/* ------------------------------------------------------------------ */
/* Lista de clientes conectados (protegida con mutex)                  */
/* ------------------------------------------------------------------ */

/* 0 = registrado, -1 = nombre en uso, -2 = servidor lleno */
static int registrar(cliente_t *c, const char *nombre)
{
    int libre = -1, res = 0;
    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++) {
        if (clientes[i] == NULL) {
            if (libre < 0) libre = i;
        } else if (strcasecmp(clientes[i]->nombre, nombre) == 0) {
            res = -1;
        }
    }
    if (res == 0 && libre < 0) res = -2;
    if (res == 0) {
        snprintf(c->nombre, sizeof c->nombre, "%s", nombre);
        clientes[libre] = c;
    }
    pthread_mutex_unlock(&mutex_clientes);
    return res;
}

static void quitar(cliente_t *c)
{
    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++)
        if (clientes[i] == c) clientes[i] = NULL;
    pthread_mutex_unlock(&mutex_clientes);
}

static int cantidad_conectados(void)
{
    int n = 0;
    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++)
        if (clientes[i]) n++;
    pthread_mutex_unlock(&mutex_clientes);
    return n;
}

/* Retransmite una línea a todos los clientes conectados excepto 'origen'. */
static void difundir(const cliente_t *origen, const char *fmt, ...)
{
    char buf[MAX_LINEA + 64];
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(buf, sizeof buf - 1, fmt, ap);
    va_end(ap);
    if (n < 0) return;
    if ((size_t)n > sizeof buf - 2) n = (int)(sizeof buf - 2);
    buf[n++] = '\n';

    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++)
        if (clientes[i] && clientes[i] != origen)
            enviar_todo(clientes[i]->fd, buf, (size_t)n);   /* si falla, el hilo de
                                                               ese cliente lo detecta */
    pthread_mutex_unlock(&mutex_clientes);
}

static void enviar_lista(const cliente_t *c)
{
    char lista[MAX_LINEA];
    size_t usado = 0;
    int n = 0;
    lista[0] = '\0';
    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++) {
        if (!clientes[i]) continue;
        int w = snprintf(lista + usado, sizeof lista - usado, "%s%s%s",
                         n ? ", " : "", clientes[i]->nombre,
                         clientes[i] == c ? " (vos)" : "");
        if (w > 0 && (size_t)w < sizeof lista - usado) usado += (size_t)w;
        n++;
    }
    pthread_mutex_unlock(&mutex_clientes);
    enviar_fmt(c->fd, "LST Usuarios conectados (%d): %s", n, lista);
}

/* ------------------------------------------------------------------ */
/* Hilo que atiende a un cliente                                       */
/* ------------------------------------------------------------------ */

static void *atender_cliente(void *arg)
{
    cliente_t *c = arg;
    lector_t   lr = { .len = 0 };
    char       linea[MAX_LINEA];
    int        r, registrado = 0;

    /* 1) Pedir y validar el nombre de usuario */
    enviar_fmt(c->fd, "SYS Bienvenido al chat de Redes de Datos. Ingrese su nombre de usuario:");
    for (int intento = 1; intento <= INTENTOS_NOMBRE && !registrado; intento++) {
        r = leer_linea(c->fd, &lr, linea, sizeof linea);
        if (r <= 0) {
            log_srv("%s:%d se desconectó antes de elegir un nombre", c->ip, c->puerto);
            goto fin;
        }
        sanear(linea);
        recortar(linea);
        const char *error = validar_nombre(linea);
        if (error) {
            enviar_fmt(c->fd, "ERR %s", error);
            continue;
        }
        int res = registrar(c, linea);
        if (res == -1) {
            enviar_fmt(c->fd, "ERR El nombre '%s' ya está en uso, elija otro", linea);
        } else if (res == -2) {
            enviar_fmt(c->fd, "ERR Servidor lleno (máximo %d usuarios). Intente más tarde", MAX_CLIENTES);
            log_srv("%s:%d rechazado: servidor lleno", c->ip, c->puerto);
            goto fin;
        } else {
            registrado = 1;
        }
    }
    if (!registrado) {
        enviar_fmt(c->fd, "ERR Demasiados intentos fallidos. Conexión cerrada");
        log_srv("%s:%d rechazado: nombre inválido %d veces", c->ip, c->puerto, INTENTOS_NOMBRE);
        goto fin;
    }

    enviar_fmt(c->fd, "OK %s", c->nombre);
    enviar_fmt(c->fd, "SYS Hola %s! Hay %d usuario(s) conectado(s). Escribí /ayuda para ver los comandos",
               c->nombre, cantidad_conectados());
    log_srv("%s:%d se registró como '%s' (conectados: %d)",
            c->ip, c->puerto, c->nombre, cantidad_conectados());
    difundir(c, "SYS %s se unió al chat", c->nombre);

    /* 2) Bucle principal: recibir líneas y retransmitirlas */
    int salida_normal = 0;
    while ((r = leer_linea(c->fd, &lr, linea, sizeof linea)) == 1) {
        sanear(linea);
        recortar(linea);
        if (linea[0] == '\0') continue;                 /* ignorar líneas vacías */

        if (linea[0] == '/') {                          /* comandos especiales */
            if (strcasecmp(linea, "/listar") == 0) {
                enviar_lista(c);
            } else if (strcasecmp(linea, "/quitar") == 0) {
                enviar_fmt(c->fd, "SYS Hasta luego, %s!", c->nombre);
                salida_normal = 1;
                break;
            } else if (strcasecmp(linea, "/ayuda") == 0) {
                enviar_fmt(c->fd, "SYS Comandos: /listar (usuarios conectados), /quitar (salir del chat), /ayuda");
            } else {
                enviar_fmt(c->fd, "ERR Comando desconocido: %s (escribí /ayuda)", linea);
            }
            continue;
        }

        log_srv("%s: %s", c->nombre, linea);
        difundir(c, "MSG %s: %s", c->nombre, linea);    /* a todos menos al emisor */
    }

    /* 3) Desconexión: normal (/quitar) o abrupta (cierre sin /quitar, RST...) */
    quitar(c);
    if (apagando) {
        /* el servidor se está apagando: no avisar uno por uno */
    } else if (salida_normal) {
        log_srv("'%s' (%s:%d) salió con /quitar", c->nombre, c->ip, c->puerto);
        difundir(NULL, "SYS %s salió del chat", c->nombre);
    } else {
        log_srv("'%s' (%s:%d) se desconectó abruptamente (%s)", c->nombre, c->ip, c->puerto,
                r == 0 ? "cerró sin /quitar" : strerror(errno));
        difundir(NULL, "SYS %s se desconectó inesperadamente", c->nombre);
    }

fin:
    close(c->fd);                                                     /* close() */
    free(c);
    return NULL;
}

/* ------------------------------------------------------------------ */

static void al_recibir_senal(int sig)
{
    (void)sig;
    apagando = 1;
    if (fd_escucha >= 0)
        shutdown(fd_escucha, SHUT_RDWR);   /* despierta al accept() bloqueado */
}

static void mostrar_direcciones(int puerto)
{
    struct ifaddrs *ifs, *i;
    log_srv("Servidor escuchando en el puerto TCP %d. Direcciones de este equipo:", puerto);
    if (getifaddrs(&ifs) == 0) {
        for (i = ifs; i; i = i->ifa_next) {
            if (!i->ifa_addr || i->ifa_addr->sa_family != AF_INET) continue;
            char ip[INET_ADDRSTRLEN];
            inet_ntop(AF_INET, &((struct sockaddr_in *)i->ifa_addr)->sin_addr, ip, sizeof ip);
            log_srv("   %-10s %s:%d", i->ifa_name, ip, puerto);
        }
        freeifaddrs(ifs);
    }
    log_srv("Ctrl+C para apagar el servidor.");
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

    signal(SIGPIPE, SIG_IGN);                 /* no morir si un cliente se cae */
    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_handler = al_recibir_senal;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);

    /* (1) socket(): socket IPv4 (AF_INET) de tipo flujo (SOCK_STREAM) = TCP */
    fd_escucha = socket(AF_INET, SOCK_STREAM, 0);
    if (fd_escucha < 0) {
        perror("socket");
        return 1;
    }

    /* Permite reutilizar el puerto enseguida tras reiniciar el servidor
     * (evita "Address already in use" por conexiones en TIME_WAIT). */
    int si = 1;
    setsockopt(fd_escucha, SOL_SOCKET, SO_REUSEADDR, &si, sizeof si);

    /* (2) bind(): asocia el socket a todas las interfaces y al puerto elegido */
    struct sockaddr_in dir;
    memset(&dir, 0, sizeof dir);
    dir.sin_family      = AF_INET;
    dir.sin_addr.s_addr = htonl(INADDR_ANY);  /* 0.0.0.0: cualquier IP local */
    dir.sin_port        = htons((uint16_t)puerto);  /* orden de red (big endian) */
    if (bind(fd_escucha, (struct sockaddr *)&dir, sizeof dir) < 0) {
        if (errno == EADDRINUSE)
            fprintf(stderr, "Error: el puerto %d ya está en uso (¿otro servidor abierto?).\n"
                            "Cierre el otro proceso o use otro puerto, por ejemplo: %s %d\n",
                    puerto, argv[0], puerto + 1);
        else if (errno == EACCES)
            fprintf(stderr, "Error: los puertos menores a 1024 requieren permisos de root.\n");
        else
            perror("bind");
        close(fd_escucha);
        return 1;
    }

    /* (3) listen(): el socket pasa a modo pasivo y espera conexiones */
    if (listen(fd_escucha, BACKLOG) < 0) {
        perror("listen");
        close(fd_escucha);
        return 1;
    }
    mostrar_direcciones(puerto);

    /* (4) accept(): bucle que acepta clientes y crea un hilo para cada uno */
    while (!apagando) {
        struct sockaddr_in cli;
        socklen_t lc = sizeof cli;
        int fd = accept(fd_escucha, (struct sockaddr *)&cli, &lc);
        if (fd < 0) {
            if (apagando) break;
            if (errno == EINTR || errno == ECONNABORTED) continue;
            log_srv("accept falló: %s (el servidor sigue funcionando)", strerror(errno));
            sleep(1);
            continue;
        }

        /* Si un cliente deja de leer, send() no bloquea al servidor más de 3 s */
        struct timeval tv = { .tv_sec = 3, .tv_usec = 0 };
        setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv);

        cliente_t *c = calloc(1, sizeof *c);
        if (!c) {
            close(fd);
            continue;
        }
        c->fd = fd;
        inet_ntop(AF_INET, &cli.sin_addr, c->ip, sizeof c->ip);
        c->puerto = ntohs(cli.sin_port);
        log_srv("Nueva conexión desde %s:%d", c->ip, c->puerto);

        pthread_t hilo;
        if (pthread_create(&hilo, NULL, atender_cliente, c) != 0) {
            enviar_fmt(fd, "ERR El servidor no puede atender más conexiones");
            close(fd);
            free(c);
            continue;
        }
        pthread_detach(hilo);
    }

    /* Apagado ordenado: avisar a los clientes y cerrar sus conexiones */
    log_srv("Apagando el servidor...");
    pthread_mutex_lock(&mutex_clientes);
    for (int i = 0; i < MAX_CLIENTES; i++) {
        if (!clientes[i]) continue;
        enviar_fmt(clientes[i]->fd, "SYS El servidor se está apagando. Hasta pronto");
        shutdown(clientes[i]->fd, SHUT_RDWR);
    }
    pthread_mutex_unlock(&mutex_clientes);
    close(fd_escucha);
    usleep(300000);          /* dar tiempo a los hilos a cerrar sus sockets */
    log_srv("Servidor detenido.");
    return 0;
}
