#include <stdio.h>

int main() {
    int tipoEntrada;
    char ventaAnticipada;
    float precioEntrada, precioTotal;

    printf("Ingrese el tipo de entrada (1-con consumicion, 2-sin consumicion): ");
    scanf("%d", &tipoEntrada);

    if (tipoEntrada == 1) {
        precioEntrada = 750;
    } else if (tipoEntrada == 2) {
        precioEntrada = 500;
    } else {
        printf("Tipo de entrada invalido\n");
        return 0;
    }

    printf("La venta fue anticipada? ('s' o 'n'): ");
    scanf(" %c", &ventaAnticipada);

    if (ventaAnticipada == 's') {
        precioTotal = precioEntrada * 0.8;
    } else if (ventaAnticipada == 'n') {
        precioTotal = precioEntrada;
    } else {
        printf("Opcion invalida\n");
        return 0;
    }
   switch (tipoEntrada) {
    case 1:
        printf("La entrada es con consumicion\n");
        break;
    case 2:
        printf("La entrada es sin consumicion\n");
        break;
    default:
        printf("Tipo de entrada invalido\n");
        break;
}

switch (ventaAnticipada) {
    case 's':
        printf("La entrada es anticipada\n");
        break;
    case 'n':
        printf("La entrada no es anticipada\n");
        break;
    default:
        printf("Opcion invalida\n");
        break;
}

    printf("Precio total: $%.2f\n", precioTotal);
    return 0;
}
