#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Estructura para representar una llamada
typedef struct {
    char nombreApellido[100];
    char numeroTelefono[20];
    int dni;
    char lugarProcedencia[3]; // 01: Corrientes, 02: Chaco
} Llamada;

// Estructura para representar un nodo de la cola
typedef struct Nodo {
    Llamada llamada;
    struct Nodo* siguiente;
} Nodo;

// Función para crear un nuevo nodo
Nodo* crearNodo(Llamada llamada) {
    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    nuevoNodo->llamada = llamada;
    nuevoNodo->siguiente = NULL;
    return nuevoNodo;
}

// Función para encolar una llamada
void enqueue(Nodo** cola, Llamada llamada) {
    Nodo* nuevoNodo = crearNodo(llamada);
    if (*cola == NULL) {
        *cola = nuevoNodo;
    } else {
        Nodo* actual = *cola;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
    }
}

// Función para desencolar una llamada
bool dequeue(Nodo** cola) {
    if (*cola == NULL) {
        return false; // La cola está vacía
    } else {
        Nodo* temp = *cola;
        *cola = (*cola)->siguiente;
        free(temp);
        return true;
    }
}

// Función para contar la cantidad de llamadas provenientes de cada lugar de procedencia
void contarLlamadas(Nodo* cola, int* corrientes, int* chaco, int* total) {
    *corrientes = 0;
    *chaco = 0;
    *total = 0;

    Nodo* actual = cola;
    while (actual != NULL) {
        if (strcmp(actual->llamada.lugarProcedencia, "1") == 0) {
            (*corrientes)++;
        } else if (strcmp(actual->llamada.lugarProcedencia, "2") == 0) {
            (*chaco)++;
        }
        (*total)++;
        actual = actual->siguiente;
    }
}

// Función para generar un listado de números telefónicos de llamadas provenientes de Corrientes
void listadoCorrientes(Nodo* cola) {
    printf("=== Listado de Llamadas Provenientes de Corrientes ===\n");
    Nodo* actual = cola;
    while (actual != NULL) {
        if (strcmp(actual->llamada.lugarProcedencia, "1") == 0) {
            printf("Nombre y Apellido: %s, Numero de Telefono: %s\n", actual->llamada.nombreApellido, actual->llamada.numeroTelefono);
        }
        actual = actual->siguiente;
    }
    printf("=====================================================\n");
}

int main() {
    Nodo* cola = NULL;
    int opcion;
    int llamadasCorrientes, llamadasChaco, totalLlamadas;

    do {
        printf("=== Menú de Operaciones ===\n");
        printf("1. Registrar llamada\n");
        printf("2. Contar llamadas por lugar de procedencia\n");
        printf("3. Listado de llamadas provenientes de Corrientes\n");
        printf("4. Salir\n");
        printf("===========================\n");
        printf("Seleccione una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Llamada nuevaLlamada;
                printf("Ingrese el nombre y apellido: ");
                scanf(" %[^\n]", nuevaLlamada.nombreApellido);
                printf("Ingrese el numero de telefono: ");
                scanf(" %[^\n]", nuevaLlamada.numeroTelefono);
                printf("Ingrese el DNI: ");
                scanf("%d", &nuevaLlamada.dni);
                printf("Ingrese el codigo de lugar de procedencia (1-Corrientes o 2-Chaco): ");
                scanf(" %[^\n]", nuevaLlamada.lugarProcedencia);
                enqueue(&cola, nuevaLlamada);
                printf("Llamada registrada con exito.\n");
                break;
            }
            case 2: {
                contarLlamadas(cola, &llamadasCorrientes, &llamadasChaco, &totalLlamadas);
                printf("Cantidad de llamadas provenientes de Corrientes: %d\n", llamadasCorrientes);
                printf("Cantidad de llamadas provenientes de Chaco: %d\n", llamadasChaco);
                printf("Cantidad total de llamadas en cola de espera: %d\n", totalLlamadas);
                break;
            }
            case 3: {
                listadoCorrientes(cola);
                break;
            }
            case 4: {
                printf("Saliendo del programa.\n");
                break;
            }
            default: {
                printf("Opcion no válida. Intente de nuevo.\n");
                break;
            }
        }
    } while (opcion != 4);

    // Liberar memoria de la cola antes de salir
    free (cola);

    return 0;
}

