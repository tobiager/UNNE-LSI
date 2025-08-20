#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {																		//
    int tipo; // 1-Informativa, 2-Comics, 3-Educativa, 4-Arquitectura, etc...   		//			defino mi estructura de datos por revista
    int stock;																			//
} tRevista;

void inicializar();																		//
void procesoCorte();																	//				defino mis funciones
void finalizacion();																	//
		
void principioCorte();																	//
void unGrupo();																			//				funciones de procesoCorte
void finCorte();																		//

tRevista revista;//asigna una variable temporal a la estructura
FILE* archivo;//puntero de archivo

typedef char string[20];
int revistaAnterior;//aux que recorre los tipos de revistas

float promedioStock = 0;
int totalStock = 0;
int revistaMenor = 9999;																//
int menorStock = 9999;																	//
int mayorStock = 0;																		//
int revistaMayor = 0;																	//				defino mis variables globales y locales
int cantidadStock = 0;																	//
int cantidadSinStock = 0;	
int calcularPromedio = 0;															//

string vTipo[5] = {"", "Informativa", "Comics ", "Educativa ", "Arquitectura"};			//vector para imprimir los tipos

int main() {
    inicializar();
    procesoCorte();
    finalizacion();
}

void inicializar() {
    archivo = fopen("revistas.dat", "rb");																	
																												
    if (archivo == NULL) {																						
        printf("Error...\n");
        exit(EXIT_FAILURE);
    } else {
        printf("Archivo abierto...\n");
    }
	
	//primera lectura del archivo
    fread(&revista, sizeof(tRevista), 1, archivo);
	
	//inicializo mis variables
	mayorStock = 0;
    menorStock = 999;
    revistaMenor = 999;
    revistaMayor = 0;
    promedioStock = 0;
	totalStock = 0;
	calcularPromedio = 0;
	//se actualiza anterior
    revistaAnterior = revista.tipo;
    printf("| Codigo de Tipo  | Cantidad de Revistas en Stock  | Cantidad de Revistas sin Stock  |\n");
    printf("-----------------------------------------------------------------------------------------------\n");
}

void procesoCorte() {
    while (!feof(archivo)) {
        principioCorte();

        while (!feof(archivo) && revista.tipo == revistaAnterior) {
            unGrupo();
            fread(&revista, sizeof(tRevista), 1, archivo);
        }
        finCorte();
    }
}

void principioCorte() {
    cantidadStock = 0;
    cantidadSinStock = 0;
}

void unGrupo() {
    if (revista.stock > 0) {
        cantidadStock = cantidadStock + revista.stock;
        totalStock = totalStock + cantidadStock;
    } else {
        cantidadSinStock++;
    }
    calcularPromedio++;
    
}

void finCorte() {
	
    if (cantidadStock < menorStock && cantidadStock > 0) {
        menorStock = cantidadStock;
        revistaMenor = revistaAnterior;
    }
	if (cantidadStock > mayorStock) {
        mayorStock = cantidadStock;
        revistaMayor = revistaAnterior;
    }
    

    printf("|\t %d \t  | %d \t\t\t \t   | \t\t  %d  \t\t | \n",revistaAnterior,cantidadStock,cantidadSinStock);
	
	//actualizo anterior
    revistaAnterior = revista.tipo;
}

void finalizacion(){
	
	promedioStock = totalStock/calcularPromedio;
	
	printf("\nRevista con mayor cantidad disponible es %s con %d\n", vTipo[revistaMayor],mayorStock);
	printf("\nRevista con menor cantidad disponible es %s con %d\n", vTipo[revistaMenor],menorStock);
	printf("\n\nEl promedio de stock fue: %.2f\n", promedioStock);

	
	fclose(archivo);
}

