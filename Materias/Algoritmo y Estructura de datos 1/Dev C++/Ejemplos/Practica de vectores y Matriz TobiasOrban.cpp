#include <stdio.h>
#define MAX 10
int v1[] = {3,4,5,6,7};
int v2[] = {0,1,2,3,4};
int vMATRIZ [5][5];
int matriz [MAX][10];
int i, j;
int fila, columna;
int main(){

	printf("\nHECHO CON EL FOR:\n");
	for(i=0; i<5; i++){
			printf("el valor de la posicion %d es: %d\n",v2[i], v1[i]);
}
 printf("\n"); printf("\n");


for (j = 0; j <10; j++){
    	matriz [0][j] = j;
    }
    for (j = 0; j <10; j++){
    	matriz [1][j] = 2;
    }
    for (j = 0; j <10; j++){
    	matriz [2][j] = 3;
    }
    for (j = 0; j <10; j++){
    	matriz [3][j] = 4;
    }
    for (j = 0; j <10; j++){
    	matriz [4][j] = 5;
    }
    for (j = 0; j <10; j++){
    	matriz [5][j] = 6;
    }
    for (j = 0; j <10; j++){
    	matriz [6][j] = 7;
    }
    for (j = 0; j <10; j++){
    	matriz [7][j] = 8;
    }
    for (j = 0; j <10; j++){
    	matriz [8][j] = 9;
    }
   
    for (i = 0; i<MAX; i++){
    for (j = 0; j <10; j++){
    	printf("%d ",matriz[i][j]);
    }
    printf("\n");
    }
    
    
    
   	printf("\nMATRIZ\n");
    for(fila=0; fila<=4; fila++){
    	
    	printf("Digite el valor de la FILA %d \n",fila);
    	
    	for(columna=0; columna<=4; columna++){
    		
	printf("Digite el valor de la posicion:[%d] [%d]: ",fila ,columna);
	
	scanf("%d",&vMATRIZ[fila][columna]);
	
}
printf("\n");
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
