#include <stdio.h>

/* Declaración de prototipos */
void inicializarVariables();
void mostrarLeyenda();

/* Declaración de variables globales */
float unFloat;
double unDoble;
int unEntero;
short unShort;
char unCaracter;
long unLong;

/* Bloque principal */
int main(){
	
	inicializarVariables ();
	mostrarLeyenda();
	
	return 0;
}

void inicializarVariables(){
	unFloat = 3.4E+38;
	unDoble = 1.7E+308;
	unEntero = 2147483647;
	unShort = 32767;
	unCaracter = 'Z';
	unLong = 2147483647;
}

void mostrarLeyenda(){
	printf ("El tamaño de la variable del tipo: \n");
	printf ("\t float es			 %d bytes y su valor es %e \n", sizeof(unFloat), unFloat);
	printf ("\t doble es			 %d bytes y su valor es %E \n", sizeof(unDoble), unDoble);
	printf ("\t entero es			 %d bytes y su valor es %d \n", sizeof(unEntero), unEntero);
	printf ("\t entero corto es		 %d bytes y su valor es %d \n", sizeof(unShort), unShort);
	printf ("\t char es				 %d bytes y su valor es %c \n", sizeof(unCaracter), unCaracter);
	printf ("\t entero largo es		 %d bytes y su valor es %dl \n", sizeof(unLong), unLong);
}
