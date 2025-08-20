#include <stdio.h>
#include <string.h>

struct Producto {
    int codigo;
    char descripcion[50];
    float precioCosto;
    float precioSugerido;
};

int main() {
    Producto producto;

    // Pedir al usuario que ingrese los datos del producto
    printf("Ingrese el codigo del producto (0 para finalizar): ");
    scanf("%d", &producto.codigo);

    // Verificar si el usuario quiere finalizar el programa
    while (producto.codigo != 0) {
        printf("Ingrese la descripcion del producto: ");
        scanf(" %[^\n]", producto.descripcion);

        printf("Ingrese el precio de costo del producto: ");
        scanf("%f", &producto.precioCosto);

        // Calcular el precio sugerido
        producto.precioSugerido = producto.precioCosto * 1.3;

        // Mostrar los datos del producto
        printf("\nDatos del producto:\n");
        printf("Codigo: %d\n", producto.codigo);
        printf("Descripcion: %s\n", producto.descripcion);
        printf("Precio de costo: %.2f\n", producto.precioCosto);
        printf("Precio sugerido: %.2f\n\n", producto.precioSugerido);

        // Pedir al usuario que ingrese el siguiente código de producto
        printf("Ingrese el codigo del producto (0 para finalizar): ");
        scanf("%d", &producto.codigo);
    }

    printf("Programa finalizado.\n");

    return 0;
}

