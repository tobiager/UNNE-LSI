#include <stdio.h>
#include <stdlib.h>

// Definición del tipo de dato tListaProductos
struct tListaProductos {
    int codProducto;
    char descripcion[25];
    float precioUnitario;
};

int main() {
    // Declaración de un puntero a tListaProductos
    struct tListaProductos* primerNodo;

    // Asignación de memoria para el primer nodo
    primerNodo = (struct tListaProductos*)malloc(sizeof(struct tListaProductos));

    // Ingreso de datos por teclado para el primer nodo
    printf("Ingrese el codigo del producto: ");
    scanf("%d", &primerNodo->codProducto);

    printf("Ingrese la descripcion del producto: ");
    scanf("%s", primerNodo->descripcion);

    printf("Ingrese el precio unitario del producto: ");
    scanf("%f", &primerNodo->precioUnitario);

    // Mostrar los datos del primer nodo almacenado
    printf("\nDatos del primer nodo:\n");
    printf("Codigo del producto: %d\n", primerNodo->codProducto);
    printf("Descripcion: %s\n", primerNodo->descripcion);
    printf("Precio Unitario: %.2f\n", primerNodo->precioUnitario);

    // Liberar la memoria asignada
    free(primerNodo);

    return 0;
}

