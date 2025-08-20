#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define N 5

typedef int tVector [N];

void cargaVector ();
void ordenacionBurbuja (tVector);
void visualizarVector (tVector);

tVector vector;
int cargaVec;

int main (){
	
  cargaVector ();
  ordenacionBurbuja (vector);
  visualizarVector (vector);
	return 0;
	
}

void cargaVector (){
	int i;
	printf ("Ingrese los numeros que desea cargar al vector:");
	for (i=0; i<N; i++){
		scanf ("%d", &vector[i]);
	}
}


void ordenacionBurbuja (tVector pVector){
	int i, j, aux;
	
	for (i=0; i<N-1; i++){
		for (j=0; j<N-1;j++){
			
			if (pVector [j]> pVector [j+1]){
				
				aux = pVector[j];
				pVector[j]= pVector[j+1];
				pVector[j+1] = aux;
			}
		}
	}
}

void visualizarVector (tVector pVector){
	
	int i;
	
	printf ("\n Vector ordenado: \n);
	for (i=0; i<N; i++){
		printf (" - }%d ", vector [i]);
	}
	
}


