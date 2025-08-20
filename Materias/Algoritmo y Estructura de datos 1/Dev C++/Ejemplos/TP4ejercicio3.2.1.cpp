#include <stdio.h>

#define MAX_PRODUCTOS 50

int main() {
    int cantidad, total = 0, num_productos = 0;
    float precio_unitario, importe;
    char descripcion[100];

    // Array para guardar los datos de los productos
    int cantidades[MAX_PRODUCTOS];
    float precios_unitarios[MAX_PRODUCTOS];
    float importes[MAX_PRODUCTOS];
    char descripciones[MAX_PRODUCTOS][100];

    while (1) {
        printf("Ingrese la cantidad de unidades (-1 para finalizar): ");
        scanf("%d", &cantidad);
        if (cantidad == -1) {
            break;
        }

        printf("Ingrese el precio unitario: $");
        total += importe;

        printf("Producto: %s | Cantidad: %d | Precio unitario: $%.2f | Importe: $%.2f\n", descripcion, cantidad, precio_unitario, importe);

        // Guardar los datos del producto en el array
        cantidades[num_productos] = cantidad;
        precios_unitarios[num_productos] = precio_unitario;
        importes[num_productos] = importe;
        strcpy(descripciones[num_productos], descripcion);
        scanf("%f", &precio_unitario);

        printf("Ingrese la descripcion del producto: ");
        scanf("%s", descripcion);

        importe = cantidad * precio_unitario;
        num_productos++;
    }

    printf("********************************\n");
    printf("TOTAL A PAGAR: $%.2f\n", (float)total);
    printf("********************************\n");
    printf("¡Gracias por su compra!\n");

    // Imprimir el ticket con los datos de los productos
    printf("Producto          Cantidad    Precio     Resultado esperado\n");
    for (int i = 0; i < num_productos; i++) {
        printf("%-18s %2d          $%-8.2f $%-8.2f\n", descripciones[i], cantidades[i], precios_unitarios[i], importes[i]);
    }
    printf("TOTAL A PAGAR: $%-8.2f\n", (float)total);

    return 0;
}


