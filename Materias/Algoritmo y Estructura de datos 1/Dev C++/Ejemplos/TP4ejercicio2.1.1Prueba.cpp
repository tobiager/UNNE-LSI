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
    
    printf("+-----------------+------------+--------------+\n");
    printf("| Cant. unidades  | Precio unit| Total a pagar |\n");
    printf("+-----------------+------------+--------------+\n");
    printf("| %15d | %10.2f | %12.2f |\n", cantidad, precio, totalbonificado);
    printf("+-----------------+------------+--------------+\n");
    printf("|                  |           |             |\n");
    printf("+-----------------+------------+--------------+\n");
    
    return 0;
}

