#include <stdio.h>
/*Declaración de prototipos */
void inicializarVariables();
void ingresarDatos();
void CalcularCompra();
void ImprimirResultados();
/*Declaración de variables globales */
int cantProd;
float preUnid;
float totalPagar;

/*Bloque principal*/
int main(){
	inicializarVariables();
	ingresarDatos();
	CalcularCompra();
	ImprimirResultados();
		return 0;
}

void inicializarVariables(){
cantProd = 0;
preUnid = 0.0;	
totalPagar = 0.0;
}

void ingresarDatos(){
	printf ("Ingrese Unidades compradas: ");
	scanf ("%d", &cantProd );
	printf ("Ingrese Precio por Unidad: ");
	scanf ("%f", &preUnid );
	
}
void CalcularCompra(){
totalPagar=cantProd*preUnid;	
}
void ImprimirResultados(){
printf ("Cantidad comprada: %d \n", cantProd);
printf ("Precio por Unidad: %.2f \n", preUnid );
printf ("Total a Pagar: %.2f \n", totalPagar );
}


