#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
    int tipo; // 1-informativa, 2-Comics, 3-Educativa, 4-Arquitectura, etc
    int stock;
} tRevista;

void inicializacion();
void procesoCorte();
void finalizacion();
void ordenarPorStock();

void principioCorte(); // iniciar contadores parciales
void unGrupo();        // actualizar contadores parciales
void finCorte();        // calcular resultados parciales

FILE* archivo;
tRevista revista; // temporal

typedef char string[20];
int revistaAnterior;

// totales parciales por grupo
int cantidadStock = 0;
int cantidadsinStock = 0;
// totales generales
int cantMayor = 0;
int revistaMayor = 0;
int cantMenor = 9999;
int revistaMenor = 9999;

string vTipo[5] = { "", "informativa", "Comics", "Educativa", "Arquitectura" };

// Vector para almacenar la cantidad de stock por categoría
int stockPorCategoria[5] = {0};

int main() {
    inicializacion();
    procesoCorte();
    ordenarPorStock();
    finalizacion();
}

void inicializacion() {
    archivo = fopen("revistas.dat", "rb");
    if (archivo == NULL) {
        printf("Error al abrir el archivo");
        exit(EXIT_FAILURE);
    } else {
        printf("Archivo Abierto....\n");
    }

    // primer lectura
    fread(&revista, sizeof(tRevista), 1, archivo);
 	//inicializo variables globales
	 cantMayor = 0;
    revistaMayor = 0;
    cantMenor = 9999;
    revistaMenor = 9999;
    // actualizar anterior
    revistaAnterior = revista.tipo;

    printf("| Codigo de Tipo | Cantidad de revistas en Stock | Cantidad de revistas sin Stock |\n");
    printf("------------------------------------------------------------------------------------\n");
}

void procesoCorte() {
    while (!feof(archivo)) {
        principioCorte();
        while (!feof(archivo) && revista.tipo == revistaAnterior) {
            unGrupo();
            // Incrementa la cantidad de stock por categoría
            stockPorCategoria[revistaAnterior] += revista.stock;
            fread(&revista, sizeof(tRevista), 1, archivo);
        }
        finCorte();
    }
}

void principioCorte() {
    cantidadStock = 0;
    cantidadsinStock = 0;
}

void unGrupo() {
    if (revista.stock > 0) {
        cantidadStock += revista.stock;
    } else {
        cantidadsinStock++;
    }
}

void finCorte() {
    if (cantidadStock > cantMayor ) {
        cantMayor = cantidadStock;
        revistaMayor = revistaAnterior;
    }

    if (cantidadStock < cantMenor && cantidadStock > 0) {
        cantMenor = cantidadStock;
        revistaMenor = revistaAnterior;
    }

    printf("|\t %d \t |\t\t %d \t\t |\t\t %d \t \t  |\n", revistaAnterior, cantidadStock, cantidadsinStock);

    // actualizo anterior
    revistaAnterior = revista.tipo;
}

void ordenarPorStock() {
    int i, j, temp;
    for (i = 1; i < 5; i++) {
        for (j = i; j > 0 && stockPorCategoria[j] < stockPorCategoria[j - 1]; j--) {
            temp = stockPorCategoria[j];
            stockPorCategoria[j] = stockPorCategoria[j - 1];
            stockPorCategoria[j - 1] = temp;
        }
    }
}

void finalizacion() {
	
    printf("\nLa revista con mayor cantidad disponible es %s con %d\n", vTipo[revistaMayor], cantMayor);
    printf("La revista con menor cantidad disponible es %s con %d\n", vTipo[revistaMenor], cantMenor);

    printf("\nVector de stock de menor a mayor: ");
    for (int i = 1; i <= 4; i++) {
        printf("%d ", stockPorCategoria[i]);
    }

    fclose(archivo);
}






