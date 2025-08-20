#include <stdio.h>

int main() {
    // Declaración de la matriz de ventas
    int ventas[3][12];
    int fila, columna;

    // Captura de las ventas para cada sucursal y mes
    for (fila = 1; fila <= 3; fila++) {
        printf("Ingrese las ventas para la sucursal %d:\n", fila);
        for (int columna = 1; columna <= 12; columna++) {
            printf("Mes %d: ", columna);
            scanf("%d", &ventas[fila][columna]);
        }
        printf("\n");
    }

    // Mostrar las ventas almacenadas
    printf("Ventas registradas:\n");
    for ( fila =1; fila <= 3; fila++) {
        printf("Sucursal %d:\n", fila);
        for (columna = 1; columna <= 12; columna++) {
            printf("Mes %d: %d\n", columna+ 1, ventas[fila][columna]);
        }
        printf("\n");
    }

    return 0;
}
