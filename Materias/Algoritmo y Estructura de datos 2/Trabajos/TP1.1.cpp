#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef char tString [25];

void itemA();

tString * apuntCadena;

int main(){
	itemA();
	return 0;
}

void itemA(){
	apuntCadena = (tString *) malloc(sizeof(tString));
	strcpy((*apuntCadena),"Maria Acosta");
	printf("\nEl contenido de la variable apuntada es: %s \n", *apuntCadena);
	printf("\nLa direccion de la variable apuntada es: %p \n", apuntCadena);
	printf("\nLa direccion de la variable puntero es: %p \n", &apuntCadena);
}

