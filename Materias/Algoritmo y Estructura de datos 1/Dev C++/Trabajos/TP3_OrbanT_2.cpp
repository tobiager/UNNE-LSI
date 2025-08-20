#include <stdio.h>

/* Declaración de prototipos */
void inicializarVariables();
void ingresarValores();
void mostrarLeyenda ();

/* Declaración de variables globales */
float unFloat;
double unDoble;
int unEntero;
short unShort;
char unCaracter;
long unLong;

/* Bloque principal */
int main(){
	inicializarVariables();
	ingresarValores();
	mostrarLeyenda();
	
	return 0;
}

void inicializarVariables(){
	unFloat = 0;
	unDoble = 0;
	unEntero = 0;
	unShort = 0;
	unCaracter = ' ';
	unLong = 0;
}

void ingresarValores(){
	printf ("Ingresar el valor de la variable del tipo float: \n");
	fflush(stdin);
	scanf("%f", &unFloat);
	printf ("Ingresar el valor de la variable del tipo doble: \n");
	fflush(stdin);
	scanf("%lf", &unDoble);
	printf ("Ingresar el valor de la variaable del tipo entero: \n");
	fflush(stdin);
	scanf("%d", &unEntero);
	printf ("Ingresar el valor de la variable del tipo entero corto: \n");
	fflush (stdin);
	scanf("%d", &unShort);
	printf ("Ingresar el valor de la variable del tipo caracter: \n");
	fflush (stdin);
	scanf ("%c", &unCaracter);
	printf ("Ingresar el valor de la variable del tipo entero largo: \n");
	fflush (stdin);
	scanf ("%ld", &unLong);
}

void mostrarLeyenda (){
	printf ("El valor de la variable del tipo: \n");
	printf ("\t float 			es %d bytes y su valor es %e \n", sizeof(unFloat), unFloat);
	printf ("\t doble 			es %d bytes y su valor es %E \n", sizeof(unDoble), unDoble);
	printf ("\t entero 			es %d bytes y su valor es %d \n", sizeof(unEntero), unEntero);
	printf ("\t entero corto	es %d bytes y su valor es %d \n", sizeof(unShort), unShort);
	printf ("\t char	 		es %d bytes y su valor es %c \n", sizeof(unCaracter), unCaracter);
	printf ("\t entero largo	es %d bytes y su valor es %ld \n", sizeof(unLong), unLong);
}
