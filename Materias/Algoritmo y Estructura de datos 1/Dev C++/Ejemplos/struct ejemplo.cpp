#include <stdio.h>

int main(){
	
	struct musica{
		char titulo[30];
		char artista[25];
		float precio;
		char fecha[10];
	}disco1;
	
	printf("\nTITULO: ");
	scanf("%s",&disco1.titulo);
	fflush(stdin);
	
	printf("\nARTISTA: ");
	scanf("%s",&disco1.artista);
	fflush(stdin);
	
	printf("\nPRECIO: ");
	scanf("%f",&disco1.precio);
	fflush(stdin);
	
	printf("\nFECHA DE COMPRA: ");
	scanf("%s",&disco1.fecha);
	fflush(stdin);
	
	
	printf("\nTITULO: %s",disco1.titulo);
	printf("\nARTISTA: %s",disco1.artista);
	printf("\nPRECIO: %f",disco1.precio);
	printf("\nFECHA DE COMPRA: %s ",disco1.fecha);
	
	return 0;
}
