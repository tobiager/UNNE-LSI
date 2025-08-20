#include <stdio.h>

/* Declaración de prototipos */
void inicializarVariables();
void mostrarLeyenda();

/* Declaración de variables globales */
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
