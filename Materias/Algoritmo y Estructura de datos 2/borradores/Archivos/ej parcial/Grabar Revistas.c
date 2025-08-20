#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
	int tipo;//1-informativa, 2-Comics, 3-Educativa, 4-Arquitectura,etc
	int stock;
}tRevista;

void inicializacion();//abrir archivo
void ingresarRevistas();//ingresar revistas
void finalizacion();

FILE * archivo;
tRevista revista;//temporal

int main(){
	inicializacion();//abrir archivo
 	ingresarRevistas();//ingresar revistas
 	finalizacion();
}

void inicializacion(){
	archivo = fopen("revistas.dat","wb");
	if(archivo != NULL){
		printf("Archivo abierto correctamente");
	}else{
		printf("Error al abrir el archivo");
		exit(EXIT_FAILURE);
	}
}

void ingresarRevistas(){
	revista.tipo = 1;
	revista.stock = 12;
	fwrite(&revista,sizeof(tRevista),1,archivo);
	
	revista.tipo = 2;
	revista.stock = 92;
	fwrite(&revista,sizeof(tRevista),1,archivo);
	
	revista.tipo = 3;
	revista.stock = 0;
	fwrite(&revista,sizeof(tRevista),1,archivo);
	
	revista.tipo = 4;
	revista.stock = 1;
	fwrite(&revista,sizeof(tRevista),1,archivo);
}

void finalizacion(){
	fclose(archivo);
}
