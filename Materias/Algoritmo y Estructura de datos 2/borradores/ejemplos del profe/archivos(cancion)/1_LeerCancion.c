#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void iniciarProceso();
void mostrarCancion();
void finalizarProceso();

FILE * archivoTexto;

int main() {
	iniciarProceso();
	mostrarCancion();
	finalizarProceso();
	return 0;
}

void iniciarProceso() {
	archivoTexto = fopen("Fix_you.txt", "r");
	
	if ( archivoTexto == NULL ) {
		printf("El archivo No existe \n");
		exit( EXIT_FAILURE );
	} else {
		printf("\nArchivo abierto ...\n\n");		
	}	
}

void mostrarCancion() {
	char letra;
	
	letra = getc(archivoTexto);
	while( !feof(archivoTexto) ){
		printf("%c", letra);
		letra = getc(archivoTexto);	
	}	
}

void finalizarProceso() {
	fclose(archivoTexto);
	printf("\n\nArchivo cerrado! ...\n");		
}

