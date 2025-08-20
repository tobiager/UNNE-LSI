#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Estructura para representar un turno
typedef struct {
    int numeroTurno;
    char nombreCliente[100];
    int motivo; // 1: Transacci�n, 2: Consulta
} Turno;

// Estructura para representar un nodo de la cola
typedef struct Nodo {
    Turno turno;
    struct Nodo* siguiente;
} Nodo;

// Funci�n para crear un nuevo nodo
Nodo* crearNodo(Turno turno) {
    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    nuevoNodo->turno = turno;
    nuevoNodo->siguiente = NULL;
    return nuevoNodo;
}

// Funci�n para encolar un turno
void enqueue(Nodo** cola, Turno turno) {
    Nodo* nuevoNodo = crearNodo(turno);
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

// Funci�n para desencolar un turno
bool dequeue(Nodo** cola) {
    if (*cola == NULL) {
        return false; // La cola est� vac�a
    } else {
        Nodo* temp = *cola;
        *cola = (*cola)->siguiente;
        free(temp);
        return true;
    }
}

// Funci�n para contar la cantidad de personas esperando un turno para "transacci�n"
int contarTransacciones(Nodo* cola) {
    int contador = 0;
    Nodo* actual = cola;
    while (actual != NULL) {
        if (actual->turno.motivo == 1) {
            contador++;
        }
        actual = actual->siguiente;
    }
    return contador;
}

// Funci�n para contar la cantidad de personas esperando un turno para "consulta"
int contarConsultas(Nodo* cola) {
    int contador = 0;
    Nodo* actual = cola;
    while (actual != NULL) {
        if (actual->turno.motivo == 2) {
            contador++;
        }
        actual = actual->siguiente;
    }
    return contador;
}

// Funci�n para mostrar el listado de personas en la cola
void mostrarListado(Nodo* cola) {
    printf("=== Listado de Personas en la Cola ===\n");
    Nodo* actual = cola;
    int contador = 1;
    while (actual != NULL) {
        printf("Turno %d: Nombre: %s, Motivo: %s\n", contador, actual->turno.nombreCliente,
               (actual->turno.motivo == 1) ? "Transaccion" : "Consulta");
        actual = actual->siguiente;
        contador++;
    }
    printf("=====================================\n");
}

int main() {
    Nodo* cola = NULL;
    int opcion;

    do {
        printf("=== Menu de Operaciones ===\n");
        printf("1. Registrar turno\n");
        printf("2. Contar personas esperando para transacci�n\n");
        printf("3. Contar personas esperando para consulta\n");
        printf("4. Mostrar listado de personas en la cola\n");
        printf("5. Salir\n");
        printf("===========================\n");
        printf("Seleccione una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Turno nuevoTurno;
                printf("Ingrese el numero de turno: ");
                scanf("%d", &nuevoTurno.numeroTurno);
                printf("Ingrese el nombre del cliente: ");
                scanf(" %[^\n]", nuevoTurno.nombreCliente);
                printf("Ingrese el motivo (1: Transaccion, 2: Consulta): ");
                scanf("%d", &nuevoTurno.motivo);
                enqueue(&cola, nuevoTurno);
                printf("Turno registrado con exito.\n");
                break;
            }
            case 2: {
                int cantidadTransacciones = contarTransacciones(cola);
                printf("Cantidad de personas esperando para transaccion: %d\n", cantidadTransacciones);
                break;
            }
            case 3: {
                int cantidadConsultas = contarConsultas(cola);
                printf("Cantidad de personas esperando para consulta: %d\n", cantidadConsultas);
                break;
            }
            case 4: {
                mostrarListado(cola);
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

    // Liberar memoria de la cola antes de salir
    free(cola);

    return 0;
}

