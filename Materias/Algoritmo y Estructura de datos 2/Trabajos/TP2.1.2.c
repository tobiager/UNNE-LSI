#include <stdio.h>
#include <stdlib.h>

// Definición del tipo de dato tListaProductos
struct tListaProductos {
    int codProducto;
    char descripcion[50];
    float precioUnitario;
    struct tListaProductos* siguiente;
};

// Prototipos de funciones
void inicializarLista(struct tListaProductos** lista);
int estaVacia(struct tListaProductos* lista);
void insertarPrimerProducto(struct tListaProductos** lista);
void insertarProductoAlPrincipio(struct tListaProductos** lista);
void eliminarPrimerProducto(struct tListaProductos** lista);
void insertarProductoEnPosicion(struct tListaProductos** lista, int posicion);
void eliminarProductoEnPosicion(struct tListaProductos** lista, int posicion);
void mostrarLista(struct tListaProductos* lista);

int main() {
	
	//inicializar lista
	//ingresar datos por teclado
	//insertar producto a la lista
	// lista esta vacia
	
	
    struct tListaProductos* lista = NULL; // Inicializar la lista

    int opcion;
    do {
        printf("\nOperaciones disponibles:\n");
        printf("1. Inicializar lista\n");
        printf("2. Verificar si la lista esta vacia\n");
        printf("3. Insertar el primer producto\n");
        printf("4. Insertar un producto al principio\n");
        printf("5. Eliminar el primer producto\n");
        printf("6. Insertar un producto en una posición\n");
        printf("7. Eliminar un producto en una posición\n");
        printf("8. Mostrar la lista\n");
        printf("0. Salir\n");
        printf("Elija una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1:
                inicializarLista(&lista);
                break;
            case 2:
                if (estaVacia(lista)) {
                    printf("La lista esta vacia.\n");
                } else {
                    printf("La lista no esta vacia.\n");
                }
                break;
            case 3:
                insertarPrimerProducto(&lista);
                break;
            case 4:
                insertarProductoAlPrincipio(&lista);
                break;
            case 5:
                eliminarPrimerProducto(&lista);
                break;
            case 6:
                {
                    int posicion;
                    printf("Ingrese la posicion donde desea insertar el producto: ");
                    scanf("%d", &posicion);
                    insertarProductoEnPosicion(&lista, posicion);
                }
                break;
            case 7:
                {
                    int posicion;
                    printf("Ingrese la posicion del producto que desea eliminar: ");
                    scanf("%d", &posicion);
                    eliminarProductoEnPosicion(&lista, posicion);
                }
                break;
            case 8:
                mostrarLista(lista);
                break;
            case 0:
                // Salir del programa
                break;
            default:
                printf("Opcion no valida. Intente de nuevo.\n");
        }
    } while (opcion != 0);

    // Liberar la memoria de la lista antes de salir
    while (lista != NULL) {
        struct tListaProductos* temp = lista;
        lista = lista->siguiente;
        free(temp);
    }

    return 0;
}

void inicializarLista(struct tListaProductos** lista) {
    // Liberar la memoria de la lista actual si existe
    while (*lista != NULL) {
        struct tListaProductos* temp = *lista;
        *lista = (*lista)->siguiente;
        free(temp);
    }
    *lista = NULL;
    printf("Lista inicializada.\n");
}

int estaVacia(struct tListaProductos* lista) {
    return lista == NULL;
}

void insertarPrimerProducto(struct tListaProductos** lista) {
    struct tListaProductos* nuevoProducto = (struct tListaProductos*)malloc(sizeof(struct tListaProductos));
    
    printf("Ingrese el codigo del producto: ");
    scanf("%d", &nuevoProducto->codProducto);
    
    printf("Ingrese la descripcion del producto: ");
    scanf("%s", nuevoProducto->descripcion);
    
    printf("Ingrese el precio unitario del producto: ");
    scanf("%f", &nuevoProducto->precioUnitario);
    
    nuevoProducto->siguiente = *lista;
    *lista = nuevoProducto;
    
    printf("Producto insertado al principio de la lista.\n");
}

void insertarProductoAlPrincipio(struct tListaProductos** lista) {
    insertarPrimerProducto(lista);
}

void eliminarPrimerProducto(struct tListaProductos** lista) {
    if (*lista != NULL) {
        struct tListaProductos* temp = *lista;
        *lista = (*lista)->siguiente;
        free(temp);
        printf("Primer producto eliminado de la lista.\n");
    } else {
        printf("La lista esta vacia. No se puede eliminar ningun producto.\n");
    }
}

void insertarProductoEnPosicion(struct tListaProductos** lista, int posicion) {
    if (posicion <= 0) {
        printf("Posicion no valida. Debe ser mayor que 0.\n");
        return;
    }

    struct tListaProductos* nuevoProducto = (struct tListaProductos*)malloc(sizeof(struct tListaProductos));

    printf("Ingrese el codigo del producto: ");
    scanf("%d", &nuevoProducto->codProducto);

    printf("Ingrese la descripcion del producto: ");
    scanf("%s", nuevoProducto->descripcion);

    printf("Ingrese el precio unitario del producto: ");
    scanf("%f", &nuevoProducto->precioUnitario);

    if (posicion == 1) {
        nuevoProducto->siguiente = *lista;
        *lista = nuevoProducto;
        printf("Producto insertado en la posición 1 de la lista.\n");
    } else {
        int i = 1;
        struct tListaProductos* temp = *lista;

        while (i < posicion - 1 && temp != NULL) {
            temp = temp->siguiente;
            i++;
        }

        if (temp != NULL) {
            nuevoProducto->siguiente = temp->siguiente;
            temp->siguiente = nuevoProducto;
            printf("Producto insertado en la posicion %d de la lista.\n", posicion);
        } else {
            printf("Posicion fuera de rango. No se puede insertar el producto en la posición %d.\n", posicion);
            free(nuevoProducto);
        }
    }
}

void eliminarProductoEnPosicion(struct tListaProductos** lista, int posicion) {
    if (posicion <= 0) {
        printf("Posicion no valida. Debe ser mayor que 0.\n");
        return;
    }

    if (*lista == NULL) {
        printf("La lista está vacia. No se puede eliminar ningun producto.\n");
        return;
    }

    if (posicion == 1) {
        struct tListaProductos* temp = *lista;
        *lista = (*lista)->siguiente;
        free(temp);
        printf("Primer producto eliminado de la lista.\n");
    } else {
        int i = 1;
        struct tListaProductos* temp = *lista;
        struct tListaProductos* prev = NULL;

        while (i < posicion && temp != NULL) {
            prev = temp;
            temp = temp->siguiente;
            i++;
        }

        if (temp != NULL) {
            prev->siguiente = temp->siguiente;
            free(temp);
            printf("Producto eliminado en la posición %d de la lista.\n", posicion);
        } else {
            printf("Posicion fuera de rango. No se puede eliminar el producto en la posicion %d.\n", posicion);
        }
    }
}

void mostrarLista(struct tListaProductos* lista) {
    if (lista == NULL) {
        printf("La lista esta vacia.\n");
    } else {
        printf("\nDatos de los productos en la lista:\n");
        int posicion = 1;
        while (lista != NULL) {
            printf("Posicion %d:\n", posicion);
            printf("Codigo del producto: %d\n", lista->codProducto);
            printf("Descripcion: %s\n", lista->descripcion);
            printf("Precio Unitario: %.2f\n\n", lista->precioUnitario);
            lista = lista->siguiente;
            posicion++;
        }
    }
}

