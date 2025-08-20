#include <stdio.h>

int main() {
    int cantidad;
    float precio, total, bonificacion;
    float totalbonificado;
    char forma_de_pago;
    
    printf("Ingrese la cantidad de productos: ");
    scanf("%d", &cantidad);
    
    printf("Ingrese el precio por unidad: $ ");
    scanf("%f", &precio);
    
    printf("(c-tarjeta de credito / d-tarjeta de debito / e-efectivo): ");
    scanf("%s", &forma_de_pago);
    
    total = cantidad * precio;
    
    if (total >= 5000 && forma_de_pago == 'e' && forma_de_pago != 'c' && forma_de_pago != 'd') {
        bonificacion = total * 0.10;
        totalbonificado = total - bonificacion;
    } else {
        bonificacion = 0;
        totalbonificado = total;
    }
    
    printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", cantidad, precio);
    printf("Total: $ %.2f\n", total);

    if (bonificacion > 0) {
        printf("Bonificacion: $ %.2f\n", bonificacion);
    }

    if (forma_de_pago == 'e') {
        printf("Forma de pago: efectivo\n");
    } else if (forma_de_pago == 'c') {
        printf("Forma de pago: tarjeta de credito\n");
    } else if (forma_de_pago == 'd') {
        printf("Forma de pago: tarjeta de debito\n");
    } else {
        printf("Forma de pago invalida\n");
        return 1;
    }
    
    printf("Total a pagar: $ %.2f\n", totalbonificado);
    printf("¡Gracias por su compra!\n");

    return 0;
}

