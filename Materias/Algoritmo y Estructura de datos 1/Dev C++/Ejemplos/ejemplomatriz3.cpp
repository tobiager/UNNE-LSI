#include <stdio.h>
int vMATRIZ[5][5];
int fila, columna;


int main(){
// esto ingresa los valores a la matriz
printf("\nMATRIZ\n\n");
    for(fila=0; fila<=4; fila++){
    	
    	printf("Digite el valor de la FILA %d \n",fila);
    	
    	for(columna=0; columna<=4; columna++){
    		
	printf("Digite el valor de la posicion:[%d] [%d]: ",fila ,columna);
	
	scanf("%d",&vMATRIZ[fila][columna]);
	
}
printf("\n");
}
printf("\n");


//esto imprine la matriz
 for (fila = 0; fila <= 4; fila++) {
        for (columna = 0; columna <= 4; columna++) {
            printf("\t[%d] ", vMATRIZ[fila][columna]);
        }
        printf("\n");
    }

	return 0;
}
