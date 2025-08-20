#include <stdio.h>

enum tEstado {
    INICIADO,
    EN_PROCESO,
    COMPLETADO
};

struct Tramite {
    int numero;
    char codigo;
    char nombre[100];
    char apellido[100];
    tEstado estado;
};

void mostrarResumenTramite(Tramite tramite) {
    printf("Resumen del tramite:\n");
    printf("Numero de tramite: %d\n", tramite.numero);
    printf("Codigo de tramite: %c\n", tramite.codigo);
    printf("Nombre: %s\n", tramite.nombre);
    printf("Apellido: %s\n", tramite.apellido);
    printf("Estado: ");
    switch (tramite.estado) {
        case INICIADO:
            printf("INICIADO\n");
            break;
        case EN_PROCESO:
            printf("EN PROCESO\n");
            break;
        case COMPLETADO:
            printf("COMPLETADO\n");
            break;
    }
    printf("\n");
}

int main() {
    Tramite tramite;
    char continuar;

    do {
        printf("Ingrese el numero de tramite: ");
        scanf("%d", &tramite.numero);

        printf("Ingrese el codigo de tramite (N-DNI, D-Nuevo ejemplar de DNI, M-Acta de matrimonio): ");
        scanf(" %c", &tramite.codigo);

        printf("Ingrese el nombre: ");
        scanf("%s", tramite.nombre);

        printf("Ingrese el apellido: ");
        scanf("%s", tramite.apellido);

        tramite.estado = INICIADO;

        mostrarResumenTramite(tramite);

        printf("¿Desea cargar mas tramites? (S/N): ");
        scanf(" %c", &continuar);
    } while (continuar == 'S' || continuar == 's');

    return 0;
}

