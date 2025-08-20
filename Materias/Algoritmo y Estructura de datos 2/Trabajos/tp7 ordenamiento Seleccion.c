#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define N 5

typedef int tVector [N];

void cargarVector ();
void ordenamientoSeleccion (tVector);
void mostrarVector (tVector);

tVector vector;

int main () {
	
	cargarVector ();
	ordenamientoSeleccion (vector);
	mostrarVector (vector);
	
	return 0;
	
}

void cargarVector (){
	int i;
	
	printf ("Ingrese los numeros que desea ordenar:");
	for (i=0; i<N; i++){
		scanf ("%d", &vector[i]);
	}
}

void ordenamientoSeleccion (tVector pVector){
	int i, j, posMenor, valMenor, aux;
	//Tengo que ir actualizando el menor VALOR, y la posicion del MENOR
	
	//1er for: Para recorrer las pasadas con el indice, indico que el primer valor es el menor para partir de algun "menor" (supuesto prepo)
	for (i=0; i<N-1; i++){
		valMenor =pVector[i];
		posMenor= i;
		
	//2do for para 	recorrer y hacer el numero de comparaciones, comparo el "menor" con su suigiente, y reasigno el menor
		for (j=i+1; j<N; j++){
			
			if (pVector[j]< valMenor ){
				
				valMenor = pVector[j];
				posMenor = j;
		    }
			
			if (posMenor != i) {
			  //si el menor no es i, cambio de posicion con un aux
			  aux = pVector [i];
			  pVector[i] = pVector [posMenor];
			  pVector[posMenor]= aux;
		    }
			
		}
	}
	
	
}

void mostrarVector (tVector pVector){
	int i;
	
	printf ("\nNumeros ordenados de menor a mayor:");
	for (i=0;i<N; i++){
		printf ("- %d", vector[i]);
	}
}
