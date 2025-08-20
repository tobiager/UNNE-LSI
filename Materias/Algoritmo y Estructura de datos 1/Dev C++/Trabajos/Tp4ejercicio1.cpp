#include <stdio.h>

int main() {
    int pCantidad;
    float pPrecio, total;
    
    printf("Ingrese la cantidad de unidades: ");
    scanf("%d", &pCantidad);
    
    printf("Ingrese el precio unitario: $ ");
    scanf("%f", &pPrecio);
    
    total = pCantidad * pPrecio;
    
    printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", pCantidad, pPrecio);
    printf("Total: $ %.2f\n", total);
    printf("¡Gracias por su compra!");
    
    return 0;
}

