#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Estructura para representar a los inscriptos
typedef struct {
    int dni;
    char nombreApellido[100];
    char email[100];
    char categoria[3]; // Código de Categoría
    float montoAbonado;
} Inscripto;

// Estructura para representar un nodo de la pila
typedef struct Nodo {
    Inscripto inscripto;
    struct Nodo* siguiente;
} Nodo;

// Función para crear un nuevo nodo
Nodo* crearNodo(Inscripto inscripto) {
    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    nuevoNodo->inscripto = inscripto;
    nuevoNodo->siguiente = NULL;
    return nuevoNodo;
}

// Función para insertar un inscripto en la pila
void push(Nodo** pila, Inscripto inscripto) {
    Nodo* nuevoNodo = crearNodo(inscripto);
    nuevoNodo->siguiente = *pila;
    *pila = nuevoNodo;
}

// Función para eliminar un inscripto de la pila
bool pop(Nodo** pila) {
    if (*pila == NULL) {
        return false; // La pila está vacía
    } else {
        Nodo* temp = *pila;
        *pila = (*pila)->siguiente;
        free(temp);
        return true;
    }
}

int main() {
    Nodo* pila = NULL;
    int opcion;
    int cantidadProfesionales = 0;
    float montoEstudiantes = 0;
    float montoTotal = 0;

    do {
        printf("=== Menú de Operaciones ===\n");
        printf("1. Registrar inscripto\n");
        printf("2. Calcular cantidad de profesionales y porcentaje\n");
        printf("3. Calcular monto recaudado de estudiantes\n");
        printf("4. Calcular monto total recaudado\n");
        printf("5. Salir\n");
        printf("===========================\n");
        printf("Seleccione una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Inscripto nuevoInscripto;
                printf("Ingrese el DNI: ");
                scanf("%d", &nuevoInscripto.dni);
                printf("Ingrese el Nombre y Apellido: ");
                scanf(" %[^\n]", nuevoInscripto.nombreApellido);
                printf("Ingrese el e-mail: ");
                scanf(" %[^\n]", nuevoInscripto.email);
                printf("Ingrese el codigo de categoria (01, 02 o 03): ");
                scanf(" %[^\n]", nuevoInscripto.categoria);
                printf("Ingrese el monto abonado: ");
                scanf("%f", &nuevoInscripto.montoAbonado);

                // Calcular el monto abonado según la categoría
                if (strcmp(nuevoInscripto.categoria, "01") == 0) {
                    nuevoInscripto.montoAbonado = 200.0;
                } else if (strcmp(nuevoInscripto.categoria, "02") == 0) {
                    nuevoInscripto.montoAbonado = 350.0;
                } else if (strcmp(nuevoInscripto.categoria, "03") == 0) {
                    nuevoInscripto.montoAbonado = 350.0;
                } else {
                    printf("Codigo de categoría no valido. No se registro al inscripto.\n");
                    continue;
                }

                push(&pila, nuevoInscripto);
                printf("Inscripto registrado con exito.\n");
                break;
            }
            case 2: {
                Nodo* actual = pila;
                int totalInscriptos = 0;

                while (actual != NULL) {
                    if (strcmp(actual->inscripto.categoria, "02") == 0) {
                        cantidadProfesionales++;
                    }
                    actual = actual->siguiente;
                    totalInscriptos++;
                }

                float porcentajeProfesionales = (float)cantidadProfesionales / totalInscriptos * 100;

                printf("Cantidad de profesionales inscritos: %d\n", cantidadProfesionales);
                printf("Porcentaje de profesionales sobre el total de inscriptos: %.2f%%\n", porcentajeProfesionales);
                break;
            }
            case 3: {
                Nodo* actual = pila;

                while (actual != NULL) {
                    if (strcmp(actual->inscripto.categoria, "01") == 0) {
                        montoEstudiantes += actual->inscripto.montoAbonado;
                    }
                    actual = actual->siguiente;
                }

                printf("Monto recaudado de inscriptos en la categoría Estudiantes: %.2f\n", montoEstudiantes);
                break;
            }
            case 4: {
                Nodo* actual = pila;

                while (actual != NULL) {
                    montoTotal += actual->inscripto.montoAbonado;
                    actual = actual->siguiente;
                }

                printf("Monto total recaudado en concepto de inscripciones: %.2f\n", montoTotal);
                break;
            }
            case 5: {
                printf("Saliendo del programa.\n");
                break;
            }
            default: {
                printf("Opcion no valida. Intente de nuevo.\n");
                break;
            }
        }
    } while (opcion != 5);

    // Liberar memoria de la pila antes de salir
    free (pila);

    return 0;
}

