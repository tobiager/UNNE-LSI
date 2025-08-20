#include <stdio.h>
#include <stdlib.h>

// Estructura para representar un producto
typedef struct {
    int codigoProducto;
    int codigoRubro;
    int cantidad;
    float precioUnitario;
    char descripcion[100];
} Producto;

// Estructura para representar un nodo de la pila
typedef struct Nodo {
    Producto producto;
    struct Nodo* siguiente;
} Nodo;

// Función para crear un nuevo nodo
Nodo* crearNodo(Producto producto) {
    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    nuevoNodo->producto = producto;
    nuevoNodo->siguiente = NULL;
    return nuevoNodo;
}

// Función para insertar un producto en la pila
void push(Nodo** pila, Producto producto) {
    Nodo* nuevoNodo = crearNodo(producto);
    nuevoNodo->siguiente = *pila;
    *pila = nuevoNodo;
}

// Función para eliminar un producto de la pila
void pop(Nodo** pila) {
    if (*pila == NULL) {
        printf("La pila esta vacia.\n");
    } else {
        Nodo* temp = *pila;
        *pila = (*pila)->siguiente;
        free(temp);
    }
}

// Función para calcular el monto total recaudado
float calcularTotal(Nodo* pila) {
    float total = 0;
    Nodo* actual = pila;
    while (actual != NULL) {
        total += (actual->producto.cantidad) * (actual->producto.precioUnitario);
        actual = actual->siguiente;
    }
    return total;
}

// Función para mostrar el menú principal
void mostrarMenu() {
    printf("=== Menu de Operaciones ===\n");
    printf("1. Agregar producto\n");
    printf("2. Eliminar producto\n");
    printf("3. Calcular monto total recaudado\n");
    printf("4. Salir\n");
    printf("===========================\n");
    printf("Seleccione una opcion: ");
}

int main() {
    Nodo* pila = NULL;
    int opcion;

    do {
        mostrarMenu();
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Producto nuevoProducto;
                printf("Ingrese el codigo del producto: ");
                scanf("%d", &nuevoProducto.codigoProducto);
                printf("Ingrese el codigo del rubro: ");
                scanf("%d", &nuevoProducto.codigoRubro);
                printf("Ingrese la cantidad: ");
                scanf("%d", &nuevoProducto.cantidad);
                printf("Ingrese el precio unitario: ");
                scanf("%f", &nuevoProducto.precioUnitario);
                printf("Ingrese la descripcion: ");
                scanf(" %[^\n]", nuevoProducto.descripcion);
                push(&pila, nuevoProducto);
                printf("Producto agregado con exito.\n");
                break;
            }
            case 2: {
                pop(&pila);
                printf("Producto eliminado con exito.\n");
                break;
            }
            case 3: {
                float total = calcularTotal(pila);
                printf("Monto total recaudado: %.2f\n", total);
                break;
            }
            case 4: {
                printf("Saliendo del programa.\n");
                break;
            }
            default: {
                printf("Opcion no valida. Intente de nuevo.\n");
                break;
            }
        }
    } while (opcion != 4);

    // Liberar memoria de la pila antes de salir
    while (pila != NULL) {
        free(pila);
    }

    return 0;
}

