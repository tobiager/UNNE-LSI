#include <stdio.h>

/* Declaración de prototipos */
void inicializarVariables();
void mostrarLeyenda();

/* Declaración de variables globales */
float unFloat;
double unDoble;

/* Bloque principal */
int main (){
	
	inicializarVariables();
	mostrarLeyenda();
	
	return 0;
}

void inicializarVariables(){
	unFloat = -123000.567;
	unDoble = -123000.567;
}

void mostrarLeyenda(){
	printf ("Variable float con valor negativo \n");
	printf ("\t Formato original: %f \n", unFloat);
	printf ("\t con dos decimales: %.2f \n", unFloat);
	printf ("\t solo parte entera: %d \n\n", (int)unFloat);
	
	printf ("Variable double con valor negativo \n");
	printf ("\t Formato original: %f \n", unDoble);
	printf ("\t Con dos decimales: %.lf \n", unDoble);
	printf ("\t Solo parte entera: %d \n\n", (int)unDoble);
}
