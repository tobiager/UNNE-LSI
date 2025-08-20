#include <stdio.h>
#include <string.h>

#define MAX_PILAS 20
#define MAX_PULGADAS 100

struct Televisor {
    int pulgadas;
    char marca[50];
};

struct Pila {
    Televisor televisores[MAX_PULGADAS];
    int top;
};

void inicializarPila(Pila& pila) {
    pila.top = -1;
}

bool pilaVacia(const Pila& pila) {
    return (pila.top == -1);
}

bool pilaLlena(const Pila& pila) {
    return (pila.top == MAX_PULGADAS - 1);
}

void apilarTelevisor(Pila& pila, const Televisor& televisor) {
    if (pilaLlena(pila)) {
        printf("No se puede apilar mas cajas.\n");
    } else {
        pila.top++;
        pila.televisores[pila.top] = televisor;
    }
}

void desapilarTelevisor(Pila& pila) {
    if (pilaVacia(pila)) {
        printf("No hay cajas apiladas.\n");
    } else {
        pila.top--;
    }
}

void listarTelevisores(const Pila& pila) {
    printf("Listado de televisores apilados:\n");
    if (pilaVacia(pila)) {
        printf("No hay televisores apilados.\n");
    } else {
        for (int i = pila.top; i >= 0; i--) {
            printf("Televisor %d: %d pulgadas, marca: %s\n", i + 1, pila.televisores[i].pulgadas, pila.televisores[i].marca);
        }
    }
}

int contarTelevisoresMayores(const Pila& pila, int pulgadas) {
    int contador = 0;
    for (int i = pila.top; i >= 0; i--) {
        if (pila.televisores[i].pulgadas > pulgadas) {
            contador++;
        }
    }
    return contador;
}

void obtenerTope(const Pila& pila) {
    if (pilaVacia(pila)) {
        printf("No hay televisores apilados.\n");
    } else {
        printf("Televisor en el tope: %d pulgadas, marca: %s\n", pila.televisores[pila.top].pulgadas, pila.televisores[pila.top].marca);
    }
}

int main() {
    Pila pila;
    inicializarPila(pila);

    int opcion;
    do {
        printf("\n");
        printf("1. Apilar televisor\n");
        printf("2. Desapilar televisor\n");
        printf("3. Listar televisores apilados\n");
        printf("4. Contar televisores con mas de x pulgadas\n");
        printf("5. Obtener televisor en el tope\n");
        printf("0. Salir\n");
        printf("Ingrese una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Televisor televisor;
                printf("Ingrese las pulgadas del televisor: ");
                scanf("%d", &televisor.pulgadas);
                printf("Ingrese la marca del televisor: ");
                scanf("%s", televisor.marca);
                apilarTelevisor(pila, televisor);
                break;
            }
            case 2: {
                desapilarTelevisor(pila);
                break;
            }
            case 3: {
                listarTelevisores(pila);
                break;
            }
            case 4: {
                int pulgadas;
                printf("Ingrese el valor de pulgadas: ");
                scanf("%d", &pulgadas);
                int cantidad = contarTelevisoresMayores(pila, pulgadas);
                printf("Cantidad de televisores con más de %d pulgadas: %d\n", pulgadas, cantidad);
                break;
            }
            case 5: {
                obtenerTope(pila);
                break;
            }
            case 0: {
                printf("Saliendo del programa.\n");
                break;
            }
            default: {
                printf("Opción inválida. Por favor, intente nuevamente.\n");
                break;
            }
        }
    } while (opcion != 0);

    return 0;
}

