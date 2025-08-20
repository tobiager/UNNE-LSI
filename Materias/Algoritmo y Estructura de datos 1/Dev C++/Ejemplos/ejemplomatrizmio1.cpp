#include <stdio.h>

int vMATRIZ [5][5];
int fila, columna;

int main(){
	
printf("\n INTENTO DE MATRIZ \n");
    for(fila=0; fila<=4; fila++){
    	
    	for(columna=0; columna<=4; columna++){
    		
	printf("Digite el valor de la posicion:[%d] [%d]: ",fila ,columna);
	
	scanf("%d",&vMATRIZ[fila][columna]);
	
}
}
printf("\n");

 for (fila = 0; fila <= 4; fila++) {
        for (columna = 0; columna <= 4; columna++) {
            printf("\t[%d] ", vMATRIZ[fila][columna]);
        }
        printf("\n");
    }


	return 0;
}
