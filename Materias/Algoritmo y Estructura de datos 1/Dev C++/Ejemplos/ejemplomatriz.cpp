#include <stdio.h>

int matriz[3][3];
int fila, columna;

int main() {
    for (fila = 0; fila <= 2; fila++) {
        for (columna = 0; columna <= 2; columna++) {
            printf("Digite el valor de la posicion [%d][%d]: ", fila, columna);
            scanf("%d", &matriz[fila][columna]);
        }
    }
    printf("\n");

    for (fila = 0; fila <= 2; fila++) {
        for (columna = 0; columna <= 2; columna++) {
            printf("\t[%d] ", matriz[fila][columna]);
        }
        printf("\n");
    }

   for (fila = 0; fila <= 2; fila++){
		for (columna = 0; columna <= 2; columna++){
			if(fila == columna)
			printf("\nLa diagonal es: [%d][%d]: [%d]\n", fila, columna, matriz[fila][columna]);
		}
}
return 0;
}

