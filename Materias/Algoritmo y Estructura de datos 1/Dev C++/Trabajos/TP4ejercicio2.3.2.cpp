#include <stdio.h>

int main() {
    char tipoProducto;
    int cantidad;
    float precio, valorCompra, bonificacion;

    printf("Ingrese el tipo de producto ('P' para Perfumería, 'F' para Farmacia, 'L' para Limpieza): ");
    scanf(" %c", &tipoProducto);

    printf("Ingrese la cantidad de productos vendidos: ");
    scanf("%d", &cantidad);

    printf("Ingrese el precio unitario del producto: ");
    scanf("%f", &precio);

    valorCompra = cantidad * precio;

    switch (tipoProducto) {
        case 'P':
            bonificacion = valorCompra * 0.05;
            break;
        case 'F':
            bonificacion = valorCompra * 0.10;
            break;
        case 'L':
            bonificacion = valorCompra * 0.15;
            break;
        default:
            printf("Tipo de producto invalido\n");
            return 0;
    }

    printf("Valor de la compra: $%.2f\n", valorCompra);
    printf("Porcentaje bonificado: %.0f%%\n", bonificacion / valorCompra * 100);
    printf("Importe a pagar: $%.2f\n", valorCompra - bonificacion);

    return 0;
}
 
