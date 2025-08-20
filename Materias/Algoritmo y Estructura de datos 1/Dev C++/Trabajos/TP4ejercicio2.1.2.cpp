#include <stdio.h>

int main() {
    int cantidad;
    float precio, total, bonificacion;
    float totalbonificado;
    
    printf("Ingrese la cantidad de productos: ");
    scanf("%d", &cantidad);
    
    printf("Ingrese el precio por unidad: $ ");
    scanf("%f", &precio);
    
    total = cantidad * precio;
    
    if (total >= 5000) {
        bonificacion = total * 0.15;
        totalbonificado = total - bonificacion;
    } else {
        bonificacion = 0;
        totalbonificado= total - bonificacion;
    }
    
    printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", cantidad, precio);
    printf("Total: $ %.2f\n", total);
    printf("Bonificacion: $ %.2f\n", bonificacion);
    printf("Total a pagar: $ %.2f\n", totalbonificado);
    printf("¡Gracias por su compra!");
    
    return 0;
}

