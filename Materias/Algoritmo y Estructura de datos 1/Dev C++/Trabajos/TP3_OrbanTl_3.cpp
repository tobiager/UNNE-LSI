#include <stdio.h>

/* Declaraci�n de prototipos */
void inicializarVariables();
void mostrarLeyenda();

/* Declaraci�n de variables globales */
int unEntero;
char uncaracter;

/* Bloque principal */
int main (){
	
	inicializarVariables();
	mostrarLeyenda();
	
	return 0;
}

void inicializarVariables(){
	unEntero = 25;
	uncaracter = 'x';
}

void mostrarLeyenda(){
	printf ("Tipo entero: %d \n", unEntero);
	printf ("Tipo caracter: %c ", uncaracter);
}
