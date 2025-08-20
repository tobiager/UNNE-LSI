#include <stdio.h>

int matriz[4][13];  // Se cambió la dimensión de la matriz para incluir la columna 0
int fila, columna;

int main() {
    for (fila = 1; fila <= 3; fila++) {
    	printf("\n*** SUCURSAL %d ***\n",fila);
        for (columna = 1; columna <= 12; columna++) {
            printf("\nDigite el valor de la sucursal %d y mes %d: ",fila, columna);
            scanf("%d", &matriz[fila][columna]);
        }
    }
    printf("\n");

    for (fila = 1; fila <= 3; fila++) {
        for (columna = 1; columna <= 12; columna++) {
            printf("\t[%d] ", matriz[fila][columna]);
        }
        printf("\n");
    }

    return 0;
}

