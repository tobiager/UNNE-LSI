#include <stdio.h>

int main() {
    int cantidad, total = 0;
    float precio_unitario, importe;
    char descripcion[100];

    printf("Ingrese los datos de la compra:\n");

    int i = 1;
    while (1) {
        printf("\nProducto %d:\n", i);

        printf("Ingrese la cantidad de unidades (-1 para finalizar): ");
        scanf("%d", &cantidad);
        if (cantidad == -1) {
            break;
        }

        printf("Ingrese el precio unitario: $");
        scanf("%f", &precio_unitario);

        printf("Ingrese la descripcion del producto: ");
        scanf("%s", descripcion);

        importe = cantidad * precio_unitario;
        total += importe;

        printf("%d X $ %.2f\n", cantidad, precio_unitario);
        printf("%s $ %.2f\n", descripcion, importe);

        i++;
    }

    printf("\n********************************\n");
    printf("TOTAL A PAGAR: $%.2f\n", (float)total);
    printf("********************************\n");
    printf("¡Gracias por su compra!\n");

    return 0;
}

