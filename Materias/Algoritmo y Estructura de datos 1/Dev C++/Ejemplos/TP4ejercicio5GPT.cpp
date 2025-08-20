#include <stdio.h>

int main() {
    int cantidad;
    float precio, total, bonificacion;
    float totalbonificado;
    char forma_de_pago;
    char forma_de_pago_str[15];
    
    printf("Ingrese la cantidad de productos: ");
    scanf("%d", &cantidad);
    
    printf("Ingrese el precio por unidad: $ ");
    scanf("%f", &precio);
    
    printf("(c-tarjeta de crédito / d-tarjeta de débito / e-efectivo): ");
    scanf(" %s", &forma_de_pago);
    
    total = cantidad * precio;
    
    if (total >= 5000 && forma_de_pago == 'e') {
        bonificacion = total * 0.10;
        totalbonificado = total - bonificacion;
        sprintf(forma_de_pago_str, "efectivo");
    } else {
        bonificacion = 0;
        totalbonificado = total;
        switch (forma_de_pago) {
            case 'c':
                sprintf(forma_de_pago_str, "tarjeta de crédito");
                break;
            case 'd':
                sprintf(forma_de_pago_str, "tarjeta de débito");
                break;
            default:
                sprintf(forma_de_pago_str, "desconocida");
                break;
        }
    }
    
    printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", cantidad, precio);
    printf("Total: $ %.2f\n", total);
    printf("Forma de pago: %s\n", forma_de_pago_str);
    printf("Bonificacion: $ %.2f\n", bonificacion);
    printf("Total a pagar: $ %.2f\n", totalbonificado);
    printf("¡Gracias por su compra!");
    
    return 0;
}

