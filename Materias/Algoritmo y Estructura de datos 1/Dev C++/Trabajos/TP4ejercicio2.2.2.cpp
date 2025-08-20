#include <stdio.h>

int main() {
    int tipoEntrada;
    char ventaAnticipada;
    float precioEntrada, precioTotal;

    void ingresarTipoEntrada();
    printf("Ingrese el tipo de entrada (1-con consumicion, 2-sin consumicion): ");
    scanf("%d", &tipoEntrada);
    
    void calcularTipoEntrada();
    if (tipoEntrada == 1) {
        precioEntrada = 750;
    } else if (tipoEntrada == 2) {
        precioEntrada = 500;
    } else {
        printf("Tipo de entrada invalido\n");
        return 0;
    }
    
    void entradaAnticipada();
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

    void entradaConsumicion();
    if (tipoEntrada == 1 ){
    	printf("La entrada es con consumicion\n");
    }else if (tipoEntrada == 2 ){
    	printf("La entrada es sin consumicion\n");
}
    void entradaAnticipada();
    if (ventaAnticipada == 's' ){
    	printf("La entrada es anticipada\n");
    }else if (ventaAnticipada == 'n' ){
    	printf("La entrada no es anticipada\n");
    }
    
    void calcularPrecioTotal();
    printf("Precio total: $%.2f\n", precioTotal);
    
    return 0;
}

