/*
 * agente_inventario.c  -  TP 3.2 Redes de Datos (UNNE FaCENA) - Ejercicio 2, escenario 2
 *
 * Cliente (agente) que se instala en el equipo a inventariar. Se conecta al
 * servidor de inventario, queda esperando consultas y responde cada una con
 * datos de hardware y software leídos de /proc, /sys, /etc y comandos del
 * sistema (df, lsblk, free, ps, hostnamectl).
 *
 * Seguridad: el agente SOLO responde a la lista fija de consultas definida
 * abajo. Nunca ejecuta comandos arbitrarios enviados por la red (eso lo
 * convertiría en una puerta trasera / shell remota).
 *
 * Compilar:  gcc -Wall -Wextra -o agente_inventario agente_inventario.c
 * Ejecutar:  ./agente_inventario [host] [puerto]   (si faltan, se piden por teclado)
 */
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <ctype.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <ifaddrs.h>
#include <netdb.h>
#include <net/if.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/statvfs.h>
#include <sys/utsname.h>
#include <time.h>
#include <unistd.h>

#define HOST_DEFECTO      "127.0.0.1"
#define PUERTO_DEFECTO    "6000"
#define MAX_LINEA         512
#define TIMEOUT_CONEXION  5

typedef struct {
    char   datos[MAX_LINEA * 2];
    size_t len;
} lector_t;

/* Buffer de texto dinámico donde se arma cada respuesta */
typedef struct {
    char  *d;
    size_t len, cap;
} buf_t;

/* ------------------------------------------------------------------ */
/* Buffer de texto                                                     */
/* ------------------------------------------------------------------ */

static void b_reservar(buf_t *b, size_t extra)
{
    if (b->len + extra + 1 <= b->cap) return;
    size_t nueva = b->cap ? b->cap : 4096;
    while (nueva < b->len + extra + 1) nueva *= 2;
    char *p = realloc(b->d, nueva);
    if (!p) {
        perror("realloc");
        exit(1);
    }
    b->d = p;
    b->cap = nueva;
}

static void b_printf(buf_t *b, const char *fmt, ...)
{
    va_list ap, ap2;
    va_start(ap, fmt);
    va_copy(ap2, ap);
    int n = vsnprintf(NULL, 0, fmt, ap);
    va_end(ap);
    if (n > 0) {
        b_reservar(b, (size_t)n);
        vsnprintf(b->d + b->len, (size_t)n + 1, fmt, ap2);
        b->len += (size_t)n;
    }
    va_end(ap2);
}

static void b_agregar_flujo(buf_t *b, FILE *f)
{
    char tmp[4096];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) {
        b_reservar(b, n);
        memcpy(b->d + b->len, tmp, n);
        b->len += n;
        b->d[b->len] = '\0';
    }
}

/* Agrega el contenido completo de un archivo (ej.: /proc/partitions) */
static void b_archivo(buf_t *b, const char *ruta)
{
    FILE *f = fopen(ruta, "r");
    if (!f) {
        b_printf(b, "(no se pudo leer %s: %s)\n", ruta, strerror(errno));
        return;
    }
    b_agregar_flujo(b, f);
    fclose(f);
}

/* Agrega la salida de un comando FIJO del sistema (nunca uno recibido por red) */
static void b_comando(buf_t *b, const char *titulo, const char *cmd)
{
    b_printf(b, "\n$ %s\n", titulo);
    FILE *p = popen(cmd, "r");
    if (!p) {
        b_printf(b, "(no se pudo ejecutar)\n");
        return;
    }
    size_t antes = b->len;
    b_agregar_flujo(b, p);
    pclose(p);
    if (b->len == antes) b_printf(b, "(comando no disponible en este sistema)\n");
}

/* Escribe "  etiqueta" rellenada a 'ancho' caracteres visibles (printf rellena por
 * bytes y las letras con tilde ocupan 2 bytes en UTF-8, lo que desalinea) */
static void b_etiqueta(buf_t *b, const char *et, int ancho)
{
    int visibles = 0;
    for (const char *p = et; *p; p++)
        if (((unsigned char)*p & 0xC0) != 0x80) visibles++;
    b_printf(b, "  %s%*s ", et, ancho > visibles ? ancho - visibles : 0, "");
}

/* Busca "clave : valor" en un archivo tipo /proc/cpuinfo o /proc/meminfo */
static int buscar_campo(const char *ruta, const char *clave, char *valor, size_t tam)
{
    FILE *f = fopen(ruta, "r");
    if (!f) return 0;
    char linea[1024];
    size_t lc = strlen(clave);
    int hallado = 0;
    while (fgets(linea, sizeof linea, f)) {
        if (strncmp(linea, clave, lc) != 0) continue;
        char *p = linea + lc;
        if (*p != ' ' && *p != '\t' && *p != ':') continue;
        p = strchr(p, ':');
        if (!p) continue;
        p++;
        while (*p == ' ' || *p == '\t') p++;
        p[strcspn(p, "\n")] = '\0';
        snprintf(valor, tam, "%s", p);
        hallado = 1;
        break;
    }
    fclose(f);
    return hallado;
}

static long meminfo_kb(const char *clave)
{
    char v[64];
    if (!buscar_campo("/proc/meminfo", clave, v, sizeof v)) return -1;
    return strtol(v, NULL, 10);
}

/* ------------------------------------------------------------------ */
/* Consultas                                                           */
/* ------------------------------------------------------------------ */

static void q_cpu(buf_t *b)
{
    const char *campos[][2] = {
        { "model name", "Modelo" },          { "vendor_id", "Fabricante" },
        { "cpu MHz", "Frecuencia (MHz)" },   { "cache size", "Caché" },
        { "cpu cores", "Núcleos físicos" },  { "siblings", "Hilos por socket" },
        { "Hardware", "Hardware (ARM)" },    { "Model", "Modelo (ARM)" },
    };
    char v[512];
    b_printf(b, "Fuente: /proc/cpuinfo\n");
    for (size_t i = 0; i < sizeof campos / sizeof campos[0]; i++)
        if (buscar_campo("/proc/cpuinfo", campos[i][0], v, sizeof v)) {
            b_etiqueta(b, campos[i][1], 20);
            b_printf(b, "%s\n", v);
        }

    int logicos = 0;
    FILE *f = fopen("/proc/cpuinfo", "r");
    if (f) {
        char l[1024];
        while (fgets(l, sizeof l, f))
            if (strncmp(l, "processor", 9) == 0) logicos++;
        fclose(f);
    }
    b_etiqueta(b, "CPUs lógicas", 20); b_printf(b, "%d\n", logicos);
    b_etiqueta(b, "CPUs en línea", 20); b_printf(b, "%ld\n", sysconf(_SC_NPROCESSORS_ONLN));
    struct utsname u;
    if (uname(&u) == 0) { b_etiqueta(b, "Arquitectura", 20); b_printf(b, "%s\n", u.machine); }
}

static void q_ram(buf_t *b)
{
    long total = meminfo_kb("MemTotal"), libre = meminfo_kb("MemFree");
    long disp = meminfo_kb("MemAvailable"), buffers = meminfo_kb("Buffers");
    long cache = meminfo_kb("Cached"), sw_t = meminfo_kb("SwapTotal"), sw_l = meminfo_kb("SwapFree");
    b_printf(b, "Fuente: /proc/meminfo\n");
    b_etiqueta(b, "Memoria total", 22); b_printf(b, "%8.1f MB\n", total / 1024.0);
    b_etiqueta(b, "Memoria libre", 22); b_printf(b, "%8.1f MB\n", libre / 1024.0);
    b_etiqueta(b, "Memoria disponible", 22); b_printf(b, "%8.1f MB\n", disp / 1024.0);
    b_etiqueta(b, "Buffers + caché", 22); b_printf(b, "%8.1f MB\n", (buffers + cache) / 1024.0);
    if (total > 0 && disp >= 0) {
        b_etiqueta(b, "Uso real", 22);
        b_printf(b, "%8.1f %%\n", 100.0 * (double)(total - disp) / (double)total);
    }
    b_etiqueta(b, "Swap total", 22); b_printf(b, "%8.1f MB (libre %.1f MB)\n", sw_t / 1024.0, sw_l / 1024.0);
    b_comando(b, "free -h", "free -h 2>/dev/null");
}

static void q_disco(buf_t *b)
{
    struct statvfs s;
    if (statvfs("/", &s) == 0) {
        double tam   = (double)s.f_blocks * s.f_frsize / 1e9;
        double libre = (double)s.f_bavail * s.f_frsize / 1e9;
        b_printf(b, "Partición raíz (/): %.1f GB totales, %.1f GB libres (%.1f %% usado)\n",
                 tam, libre, tam > 0 ? 100.0 * (tam - libre) / tam : 0.0);
    }
    b_comando(b, "lsblk -d -o NAME,SIZE,ROTA,TYPE,MODEL  (ROTA=1 disco rígido, 0 SSD)",
              "lsblk -d -o NAME,SIZE,ROTA,TYPE,MODEL 2>/dev/null");
    b_comando(b, "df -h (sin sistemas de archivos virtuales)",
              "df -h -x tmpfs -x devtmpfs -x squashfs -x overlay 2>/dev/null || df -h 2>/dev/null");
}

static void q_fs(buf_t *b)
{
    FILE *f = fopen("/proc/mounts", "r");
    b_printf(b, "Fuente: /proc/mounts (solo dispositivos /dev/*)\n");
    b_printf(b, "  %-24s %-22s %-8s %s\n", "Dispositivo", "Punto de montaje", "Tipo", "Modo");
    if (!f) {
        b_printf(b, "(no se pudo leer /proc/mounts)\n");
        return;
    }
    char dev[256], punto[256], tipo[64], opc[512];
    int n = 0;
    while (fscanf(f, "%255s %255s %63s %511s %*d %*d", dev, punto, tipo, opc) == 4) {
        if (strncmp(dev, "/dev/", 5) != 0) continue;
        b_printf(b, "  %-24s %-22s %-8s %s\n", dev, punto, tipo,
                 strncmp(opc, "ro", 2) == 0 && (opc[2] == ',' || opc[2] == '\0') ? "solo lectura" : "lectura/escritura");
        n++;
    }
    fclose(f);
    if (n == 0) b_printf(b, "  (no hay dispositivos /dev montados: ¿contenedor?)\n");
    b_comando(b, "df -hT", "df -hT -x tmpfs -x devtmpfs -x squashfs 2>/dev/null");
}

static void q_loadavg(buf_t *b)
{
    double c1, c5, c15;
    char procs[32];
    long ultimo;
    FILE *f = fopen("/proc/loadavg", "r");
    if (!f || fscanf(f, "%lf %lf %lf %31s %ld", &c1, &c5, &c15, procs, &ultimo) != 5) {
        b_printf(b, "(no se pudo leer /proc/loadavg)\n");
        if (f) fclose(f);
        return;
    }
    fclose(f);
    long cpus = sysconf(_SC_NPROCESSORS_ONLN);
    b_printf(b, "Fuente: /proc/loadavg\n");
    b_printf(b, "  Carga promedio:  1 min = %.2f | 5 min = %.2f | 15 min = %.2f\n", c1, c5, c15);
    b_printf(b, "  Procesos (ejecutándose/total): %s   Último PID: %ld\n", procs, ultimo);
    b_printf(b, "  CPUs: %ld  ->  carga por CPU (1 min): %.2f  (%s)\n", cpus, c1 / (double)cpus,
             c1 / (double)cpus < 0.7 ? "holgado" : c1 / (double)cpus <= 1.0 ? "cerca del límite" : "sobrecargado");

    double up;
    f = fopen("/proc/uptime", "r");
    if (f && fscanf(f, "%lf", &up) == 1) {
        long s = (long)up;
        b_printf(b, "  Encendido hace: %ld días, %02ld:%02ld hs\n", s / 86400, (s % 86400) / 3600, (s % 3600) / 60);
    }
    if (f) fclose(f);
}

static void q_particiones(buf_t *b)
{
    b_printf(b, "Fuente: /proc/partitions (bloques de 1 KB)\n");
    b_archivo(b, "/proc/partitions");
    b_comando(b, "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT",
              "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT 2>/dev/null");
}

static void q_so(buf_t *b)
{
    char host[256] = "";
    gethostname(host, sizeof host);
    b_etiqueta(b, "Hostname", 18); b_printf(b, "%s\n", host);
    /* /etc/os-release tiene el formato CLAVE="valor" */
    FILE *f = fopen("/etc/os-release", "r");
    if (f) {
        char l[512];
        while (fgets(l, sizeof l, f))
            if (strncmp(l, "PRETTY_NAME=", 12) == 0) {
                char *v = l + 12;
                v[strcspn(v, "\n")] = '\0';
                if (*v == '"') {
                    v++;
                    v[strcspn(v, "\"")] = '\0';
                }
                b_etiqueta(b, "Distribución", 18); b_printf(b, "%s\n", v);
            }
        fclose(f);
    }
    struct utsname u;
    if (uname(&u) == 0) {
        b_etiqueta(b, "Kernel", 18); b_printf(b, "%s %s\n", u.sysname, u.release);
        b_etiqueta(b, "Compilación", 18); b_printf(b, "%s\n", u.version);
        b_etiqueta(b, "Arquitectura", 18); b_printf(b, "%s\n", u.machine);
    }
    b_comando(b, "hostnamectl", "hostnamectl 2>/dev/null");
}

static int prefijo_mascara(const struct sockaddr *m)
{
    int bits = 0;
    if (!m) return 0;
    const unsigned char *p;
    size_t n;
    if (m->sa_family == AF_INET) {
        p = (const unsigned char *)&((const struct sockaddr_in *)m)->sin_addr;
        n = 4;
    } else {
        p = (const unsigned char *)&((const struct sockaddr_in6 *)m)->sin6_addr;
        n = 16;
    }
    for (size_t i = 0; i < n; i++)
        for (int k = 7; k >= 0; k--)
            if (p[i] & (1 << k)) bits++;
    return bits;
}

static void leer_sys(const char *ifname, const char *archivo, char *dst, size_t tam)
{
    char ruta[256];
    snprintf(ruta, sizeof ruta, "/sys/class/net/%s/%s", ifname, archivo);
    dst[0] = '\0';
    FILE *f = fopen(ruta, "r");
    if (!f) return;
    if (fgets(dst, (int)tam, f)) dst[strcspn(dst, "\n")] = '\0';
    fclose(f);
}

static void q_red(buf_t *b)
{
    struct ifaddrs *ifs, *i;
    if (getifaddrs(&ifs) != 0) {
        b_printf(b, "(getifaddrs falló: %s)\n", strerror(errno));
        return;
    }
    b_printf(b, "Fuente: getifaddrs() + /sys/class/net\n");
    /* Recorrer interfaces sin repetir nombres */
    char vistos[64][IF_NAMESIZE];
    int nv = 0;
    for (i = ifs; i; i = i->ifa_next) {
        int repetido = 0;
        for (int k = 0; k < nv; k++)
            if (strcmp(vistos[k], i->ifa_name) == 0) repetido = 1;
        if (repetido || nv >= 64) continue;
        snprintf(vistos[nv++], IF_NAMESIZE, "%s", i->ifa_name);

        char mac[32], estado[32], mtu[16];
        leer_sys(i->ifa_name, "address", mac, sizeof mac);
        leer_sys(i->ifa_name, "operstate", estado, sizeof estado);
        leer_sys(i->ifa_name, "mtu", mtu, sizeof mtu);
        b_printf(b, "\n  %s  estado=%s  MAC=%s  MTU=%s\n", i->ifa_name,
                 estado[0] ? estado : "?", mac[0] ? mac : "-", mtu[0] ? mtu : "?");

        for (struct ifaddrs *j = ifs; j; j = j->ifa_next) {
            if (strcmp(j->ifa_name, i->ifa_name) != 0 || !j->ifa_addr) continue;
            int fam = j->ifa_addr->sa_family;
            if (fam != AF_INET && fam != AF_INET6) continue;
            char ip[INET6_ADDRSTRLEN];
            const void *a = fam == AF_INET ? (const void *)&((struct sockaddr_in *)j->ifa_addr)->sin_addr
                                           : (const void *)&((struct sockaddr_in6 *)j->ifa_addr)->sin6_addr;
            inet_ntop(fam, a, ip, sizeof ip);
            b_printf(b, "      %s  %s/%d\n", fam == AF_INET ? "IPv4" : "IPv6", ip, prefijo_mascara(j->ifa_netmask));
        }
    }
    freeifaddrs(ifs);
}

static void q_procesos(buf_t *b)
{
    int total = 0;
    DIR *d = opendir("/proc");
    if (d) {
        struct dirent *e;
        while ((e = readdir(d)))
            if (isdigit((unsigned char)e->d_name[0])) total++;
        closedir(d);
    }
    b_printf(b, "Procesos en ejecución (directorios numéricos en /proc): %d\n", total);
    b_comando(b, "ps -eo pid,user,%cpu,%mem,stat,comm --sort=-%cpu  (top 20 por CPU)",
              "ps -eo pid,user,%cpu,%mem,stat,comm --sort=-%cpu 2>/dev/null | head -n 21");
}

/* Lista blanca de consultas permitidas */
static const struct {
    const char *clave;
    void (*funcion)(buf_t *);
} CONSULTAS[] = {
    { "cpu", q_cpu },         { "ram", q_ram },         { "disco", q_disco },
    { "fs", q_fs },           { "loadavg", q_loadavg }, { "particiones", q_particiones },
    { "so", q_so },           { "red", q_red },         { "procesos", q_procesos },
};

/* ------------------------------------------------------------------ */
/* Sockets                                                             */
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

/* Envía "RESP <n>\n" (o "ERR <n>\n") seguido de los n bytes de la respuesta */
static int enviar_respuesta(int fd, int es_error, const char *texto, size_t n)
{
    char cab[64];
    int l = snprintf(cab, sizeof cab, "%s %zu\n", es_error ? "ERR" : "RESP", n);
    if (enviar_todo(fd, cab, (size_t)l) < 0) return -1;
    return enviar_todo(fd, texto, n);
}

static int conectar(const char *host, const char *puerto)
{
    struct addrinfo pistas, *res, *p;
    memset(&pistas, 0, sizeof pistas);
    pistas.ai_family   = AF_INET;
    pistas.ai_socktype = SOCK_STREAM;
    int e = getaddrinfo(host, puerto, &pistas, &res);
    if (e != 0) {
        fprintf(stderr, "No se pudo resolver '%s': %s\n", host, gai_strerror(e));
        return -1;
    }
    int fd = -1, err = 0;
    for (p = res; p; p = p->ai_next) {
        fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);   /* (1) socket() */
        if (fd < 0) {
            err = errno;
            continue;
        }
        int flags = fcntl(fd, F_GETFL, 0);
        fcntl(fd, F_SETFL, flags | O_NONBLOCK);
        int r = connect(fd, p->ai_addr, p->ai_addrlen);              /* (2) connect() */
        if (r < 0 && errno == EINPROGRESS) {
            fd_set w;
            FD_ZERO(&w);
            FD_SET(fd, &w);
            struct timeval tv = { .tv_sec = TIMEOUT_CONEXION, .tv_usec = 0 };
            r = select(fd + 1, NULL, &w, NULL, &tv);
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
            fcntl(fd, F_SETFL, flags);
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
            fprintf(stderr, "Tiempo de espera agotado: el host %s no responde\n", host);
        else
            fprintf(stderr, "No se pudo conectar: %s\n", strerror(err));
    }
    return fd;
}

static void pedir(const char *mensaje, char *dst, size_t tam, const char *defecto)
{
    printf("%s", mensaje);
    fflush(stdout);
    if (!fgets(dst, (int)tam, stdin)) dst[0] = '\0';
    dst[strcspn(dst, "\r\n")] = '\0';
    if (dst[0] == '\0') snprintf(dst, tam, "%s", defecto);
}

static void log_agente(const char *fmt, ...)
{
    char h[16];
    time_t t = time(NULL);
    struct tm tm;
    localtime_r(&t, &tm);
    strftime(h, sizeof h, "%H:%M:%S", &tm);
    printf("[%s] ", h);
    va_list ap;
    va_start(ap, fmt);
    vprintf(fmt, ap);
    va_end(ap);
    printf("\n");
    fflush(stdout);
}

int main(int argc, char *argv[])
{
    char host[256], puerto[16];
    signal(SIGPIPE, SIG_IGN);

    printf("=== Agente de inventario HW/SW - Redes de Datos (UNNE) ===\n");
    if (argc >= 2) snprintf(host, sizeof host, "%s", argv[1]);
    else pedir("IP del servidor de inventario [" HOST_DEFECTO "]: ", host, sizeof host, HOST_DEFECTO);
    if (argc >= 3) snprintf(puerto, sizeof puerto, "%s", argv[2]);
    else pedir("Puerto [" PUERTO_DEFECTO "]: ", puerto, sizeof puerto, PUERTO_DEFECTO);

    char *fin;
    long pn = strtol(puerto, &fin, 10);
    if (*fin != '\0' || pn < 1 || pn > 65535) {
        fprintf(stderr, "Puerto inválido: '%s'\n", puerto);
        return 1;
    }

    printf("Conectando a %s:%s ...\n", host, puerto);
    int fd = conectar(host, puerto);
    if (fd < 0) return 1;

    struct sockaddr_in loc;
    socklen_t ll = sizeof loc;
    getsockname(fd, (struct sockaddr *)&loc, &ll);
    char ip_loc[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &loc.sin_addr, ip_loc, sizeof ip_loc);
    printf("Conexión exitosa: %s:%d (agente) -> %s:%s (servidor)\n", ip_loc, ntohs(loc.sin_port), host, puerto);

    /* Saludo: HOLA <hostname> */
    char nombre[256] = "desconocido", saludo[300];
    gethostname(nombre, sizeof nombre);
    int l = snprintf(saludo, sizeof saludo, "HOLA %s\n", nombre);
    if (enviar_todo(fd, saludo, (size_t)l) < 0) {
        perror("send");
        return 1;
    }

    lector_t lr = { .len = 0 };
    char linea[MAX_LINEA];
    if (leer_linea(fd, &lr, linea, sizeof linea) <= 0 || strncmp(linea, "OK ", 3) != 0) {
        fprintf(stderr, "El servidor rechazó la conexión: %s\n", linea);
        return 1;
    }
    log_agente("Registrado como equipo #%s (%s). Esperando consultas... (Ctrl+C para salir)", linea + 3, nombre);

    int r;
    while ((r = leer_linea(fd, &lr, linea, sizeof linea)) == 1) {
        if (strcmp(linea, "FIN") == 0) {
            log_agente("El servidor finalizó la sesión.");
            close(fd);
            return 0;
        }
        if (strncmp(linea, "CONSULTA ", 9) != 0) {
            const char *msg = "Mensaje no reconocido por el agente\n";
            enviar_respuesta(fd, 1, msg, strlen(msg));
            continue;
        }
        const char *tipo = linea + 9;
        void (*funcion)(buf_t *) = NULL;
        for (size_t i = 0; i < sizeof CONSULTAS / sizeof CONSULTAS[0]; i++)
            if (strcmp(tipo, CONSULTAS[i].clave) == 0) funcion = CONSULTAS[i].funcion;

        buf_t b = { 0 };
        int es_error = 0;
        if (funcion) {
            funcion(&b);
        } else {
            b_printf(&b, "Consulta desconocida: '%s'\n", tipo);
            es_error = 1;
        }
        if (enviar_respuesta(fd, es_error, b.d ? b.d : "", b.len) < 0) {
            free(b.d);
            break;
        }
        log_agente("Consulta '%s' respondida (%zu bytes)", tipo, b.len);
        free(b.d);
    }

    fprintf(stderr, "Se perdió la conexión con el servidor (%s).\n",
            r == 0 ? "el servidor cerró la conexión" : strerror(errno));
    close(fd);
    return 1;
}
