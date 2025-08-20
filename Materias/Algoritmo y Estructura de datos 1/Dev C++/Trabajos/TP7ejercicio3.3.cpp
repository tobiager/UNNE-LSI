#include <stdio.h>
#include <string.h>

#define MAX_CONTENEDORES 8
#define TAM_IDENTIFICACION 20

struct Contenedor {
    char identificacion[TAM_IDENTIFICACION];
};

void ingresarContenedor(Contenedor contenedores[], int& numContenedores) {
    if (numContenedores < MAX_CONTENEDORES) {
        Contenedor nuevoContenedor;
        printf("Ingrese el numero de identificacion del contenedor: ");
        scanf("%s", nuevoContenedor.identificacion);
        contenedores[numContenedores] = nuevoContenedor;
        numContenedores++;
        printf("Contenedor ingresado exitosamente.\n");
    } else {
        printf("No se pueden ingresar mas contenedores. El puerto esta lleno.\n");
    }
}

void mostrarContenedores(Contenedor contenedores[], int numContenedores) {
    printf("Contenedores en el puerto:\n");
    for (int i = 0; i < numContenedores; i++) {
        printf("%d. %s\n", i + 1, contenedores[i].identificacion);
    }
    printf("\n");
}

void sacarContenedor(Contenedor contenedores[], int& numContenedores) {
    if (numContenedores > 0) {
        printf("Ingrese el numero de identificacion del contenedor a retirar: ");
        char identificacion[TAM_IDENTIFICACION];
        scanf("%s", identificacion);

        bool encontrado = false;
        for (int i = 0; i < numContenedores; i++) {
            if (strcmp(identificacion, contenedores[i].identificacion) == 0) {
                // Encontrado, lo eliminamos moviendo los contenedores restantes
                for (int j = i; j < numContenedores - 1; j++) {
                    contenedores[j] = contenedores[j + 1];
                }
                numContenedores--;
                encontrado = true;
                printf("Contenedor retirado exitosamente.\n");
                break;
            }
        }

        if (!encontrado) {
            printf("No se encontro el contenedor con el numero de identificacion ingresado.\n");
        }
    } else {
        printf("No hay contenedores en el puerto.\n");
    }
}

int main() {
    Contenedor contenedores[MAX_CONTENEDORES];
    int numContenedores = 0;

    int opcion;
    do {
        printf("Seleccione una opcion:\n");
        printf("1. Ingresar contenedor\n");
        printf("2. Sacar contenedor\n");
        printf("3. Mostrar contenedores en el puerto\n");
        printf("4. Salir\n");
        printf("Opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1:
                ingresarContenedor(contenedores, numContenedores);
                break;
            case 2:
                sacarContenedor(contenedores, numContenedores);
                break;
            case 3:
                mostrarContenedores(contenedores, numContenedores);
                break;
            case 4:
                printf("Saliendo del programa.\n");
                break;
            default:
                printf("Opcion inválida. Por favor, seleccione una opción valida.\n");
                break;
        }
    } while (opcion != 4);

    return 0;
}

