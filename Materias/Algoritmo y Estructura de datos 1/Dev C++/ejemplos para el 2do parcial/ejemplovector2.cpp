#include <stdio.h>
#define MAX 10
int j, i;
int matriz [5][5];

int fila, columna;
int main(){

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
    
    return 0;
}
