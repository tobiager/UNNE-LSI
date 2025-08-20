#include <stdio.h>

int main() {
    float sueldo, prestamo;
    
    printf("Ingrese el monto del sueldo del solicitante: $");
    scanf("%f", &sueldo);
    
    if (sueldo >= 100000) {
        prestamo = 300000;
        printf("Se autoriza un prestamo de $%.2f\n", prestamo);
    } else {
        prestamo = sueldo * 0.75;
        printf("Se autoriza un prestamo de $%.2f\n", prestamo);
    }
    
    return 0;
}

