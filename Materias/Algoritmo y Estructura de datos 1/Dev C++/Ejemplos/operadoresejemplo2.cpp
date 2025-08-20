#include <stdio.h>
int main() {
	float examen1, examen2;
	printf ("Ingrese la nota del primer examen:");
	scanf("%f",&examen1);
	printf ("Ingrese la nota del segundo examen:");
	scanf("%f",&examen2);
	
	float notaFinal;
	notaFinal = (examen1 + examen2) /2;
	printf("La nota final es: %f",notaFinal);
	return 0;
}
