#include <stdio.h>

int main() {
    int cantidad;
    float  totalbonificado;
    float precio, total, bonificacion;
    
    printf("Ingrese la cantidad de productos: ");
    scanf("%d", &cantidad);
    
    printf("Ingrese el precio por unidad: $");
    scanf("%f", &precio);
    
    total = cantidad * precio;
    totalbonificado=total;
    
    if (total >= 5000 || cantidad > 10) {
        bonificacion = total * 0.15;
        totalbonificado =total - bonificacion;
    } else {
        bonificacion = 0;
    }
    
    printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", cantidad, precio);
    printf("Total: $ %.2f\n", total);
    
    if (bonificacion > 0) {
        printf("Bonificacion: $ %.2f\n", bonificacion);
    }
    
    printf("Total a pagar: $ %.2f\n", totalbonificado);
    printf("¡Gracias por su compra!\n");
    
    return 0;
}

