#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>  // Agregamos esta librería para usar la función time()
#define MAX 5

/* Declaración de tipos de datos personalizados */
typedef float tVectorFloat[MAX];

/* Declaración de prototipos */
void cargarVectorOrdenado(tVectorFloat);
void cargarVectorDesordenadoRandom(tVectorFloat);
void mostrarElementos(tVectorFloat);

bool busquedaSecuencial(tVectorFloat, float);
bool busquedaSecuencialOrdenada(tVectorFloat, float);
bool busquedaBinaria(tVectorFloat, float);

float mayorElemento(tVectorFloat);
float menorElemento(tVectorFloat);

/* Declaración de tipos de variables */
tVectorFloat v1, v2;

// Función para obtener la entrada de un número flotante del usuario
float obtenerNumero() {
    float num;
    printf("Ingrese un número: ");
    scanf("%f", &num);
    return num;
}

int main() {
    bool existeElem1, existeElem2, existeElem3;
    int opcion;

    // Agregamos esta parte para generar números aleatorios
    srand(time(NULL));

    printf("------------------------------------------------------\n");
    printf(" *** MENU DE OPERACIONES *** \n");
    printf("------------------------------------------------------\n");

    do {
        printf("1. Cargar vector ordenado\n");
        printf("2. Cargar vector desordenado\n");
        printf("3. Mostrar elementos\n");
        printf("4. Busqueda Secuencial\n");
        printf("5. Busqueda Secuencial Ordenada\n");
        printf("6. Busqueda Binaria\n");
        printf("7. Mayor Elemento\n");
        printf("8. Menor Elemento\n");
        printf("0. Salir\n");

        printf("Ingrese una opción: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1:
                cargarVectorOrdenado(v2);
                break;

            case 2:
                cargarVectorDesordenadoRandom(v1);
                break;

            case 3:
                printf("Vector 1:\n");
                mostrarElementos(v1);
                printf("Vector 2:\n");
                mostrarElementos(v2);
                break;

            case 4:
                existeElem1 = busquedaSecuencial(v1, obtenerNumero());
                printf("Resultado: %s\n", existeElem1 ? "si" : "no");
                break;

            case 5:
                existeElem2 = busquedaSecuencialOrdenada(v2, obtenerNumero());
                printf("Resultado: %s\n", existeElem2 ? "si" : "no");
                break;

            case 6:
                existeElem3 = busquedaBinaria(v2, obtenerNumero());
                printf("Resultado: %s\n", existeElem3 ? "si" : "no");
                break;

            case 7:
                printf("Mayor elemento del vector 1: %.2f\n", mayorElemento(v1));
                break;

            case 8:
                printf("Menor elemento del vector 1: %.2f\n", menorElemento(v1));
                break;

            case 0:
                printf("Saliendo del programa.\n");
                break;

            default:
                printf("Opción no válida. Inténtelo de nuevo.\n");
                break;
        }
    } while (opcion != 0);

    return 0;
}





