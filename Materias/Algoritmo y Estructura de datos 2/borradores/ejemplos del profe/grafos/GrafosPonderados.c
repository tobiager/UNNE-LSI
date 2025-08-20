#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#define N 10

/* Declaración de tipos de datos personalizados */
typedef int tVertice;

typedef float tPeso;

typedef struct {
	tVertice origen;
	tVertice destino;
	tPeso peso;
}tArco; 

typedef bool conjuntoVertices[N];
typedef tPeso conjuntoArcos[N][N];

typedef struct{
	conjuntoVertices vertices;
	conjuntoArcos arcos;
}tGrafoPonderado;

/* Declaración de los prototipos */
void inicializarGrafo( tGrafoPonderado * );
void agregarVertice( tGrafoPonderado *, tVertice ); 
void agregarArco( tGrafoPonderado *, tArco ); 
void borrarVertice( tGrafoPonderado *, tVertice ); 
void borrarArco( tGrafoPonderado *, tArco ); 

int maximoVertice( tGrafoPonderado );
void visualizarMatrizAdyacencia( tGrafoPonderado );
void visualizarMatrizPesos( tGrafoPonderado );
bool existeVertice( tGrafoPonderado, tVertice );

/* Declaración de las variables globales */
tGrafoPonderado grafo;

int main() {
	tArco arco;
	
	inicializarGrafo( &grafo );

	agregarVertice( &grafo, 2 );
	agregarVertice( &grafo, 3 );
	agregarVertice( &grafo, 4);	
	
	arco.origen = 3;
	arco.destino = 2;
	arco.peso = 25.0;
	agregarArco( &grafo, arco );
	
	arco.origen = 2;
	arco.destino = 4;
	arco.peso = 7.5;
	agregarArco( &grafo, arco );
	
	arco.origen = 3;
	arco.destino = 4;
	arco.peso = 33.75;
	agregarArco( &grafo, arco );

	visualizarMatrizAdyacencia( grafo );
	
	visualizarMatrizPesos( grafo );
	
	/*borrarVertice( &grafo, 2 );
	
	visualizarMatrizAdyacencia( grafo );
	visualizarMatrizPesos( grafo );*/
	
	borrarArco( &grafo, arco );
	
	visualizarMatrizAdyacencia( grafo );
	visualizarMatrizPesos( grafo );
	
	return 0;
}

void inicializarGrafo( tGrafoPonderado * pGrafo ) {
	// Consiste en inicializar en cero el array de vértices y
	// la matriz de arcos 
	int x, y;
	for(x=0; x<N; x++){
		pGrafo->vertices[x] = 0;
		// (*pGrafo).vertices[x] = 0;
		for(y=0; y<N; y++){
			pGrafo->arcos[x][y] = 0;
		}
	}
	printf("Grafo inicializado!\n");
}

void agregarVertice( tGrafoPonderado * pGrafo, tVertice pVertice ) {
	// Consiste en marcar 1 en el vértice que se desea activar en
	// el array de vértices
	if(pVertice < N){
		pGrafo->vertices[pVertice] = true;
		printf("Vertice %d activado!\n", pVertice);
	}else{
		printf("Vertice invalido!\n");
	}
} 

void agregarArco( tGrafoPonderado * pGrafo, tArco pArco )  {
	// Consiste en activar el arco en la matriz de arcos siempre que exista
	// el vértice activo
	if( pGrafo->vertices[pArco.origen] == true &&
		pGrafo->vertices[pArco.destino] == true ) {
		pGrafo->arcos[pArco.origen][pArco.destino] = pArco.peso;
		printf("Arco (%d, %d) activado!\n", pArco.origen, pArco.destino);
	}else{
		printf("Arco invalido!\n");
		// se podría mejorar la validación
	}
}

void borrarVertice( tGrafoPonderado * pGrafo, tVertice pVertice )  {
	// Consiste en desactivar el vértice del vector de vértices 
	// si está activo
	bool existeV = existeVertice( *pGrafo, pVertice );
	
	if(existeV){
		pGrafo->vertices[pVertice] = false;
	}else{
		printf("No existe el vertice que se desea quitar!\n");	
	}	
}

void borrarArco( tGrafoPonderado * pGrafo, tArco pArco )  {
	// Consiste en borrar el arco si existe en la matriz de arcos
	if( pGrafo->arcos[pArco.origen][pArco.destino] != 0.0 ) {
		pGrafo->arcos[pArco.origen][pArco.destino] = 0.0;
		printf("Arco (%d, %d) desactivado!\n", pArco.origen, pArco.destino);
	}else{
		printf("No existe el arco!\n");	
	}
} 

int maximoVertice( tGrafoPonderado pGrafo )  {
	// Consiste en obtener el valor de vértice activo más grande
	int x;
	int max = 0;
	
	for(x=0; x<N; x++) {
		if(pGrafo.vertices[x] == true){
			max = x;
		}
	}
	
	return max;	
}

void visualizarMatrizAdyacencia( tGrafoPonderado pGrafo )  {
	// Pre-condición: obtener el máximo vértice del grafo
	// Consiste en recorrer la matriz de arcos, e identificar si existe una arista 
	// y mostrar 1 en su lugar y 0 en caso contrario
	int x, y;
	int maxV = maximoVertice( pGrafo );
	bool existeArista = false;
	
	printf("\n*** MATRIZ DE ADYACENCIA ***\n");	
	
	for(x=0; x<=maxV; x++){	
		for(y=0; y<=maxV; y++){
			existeArista = 	( pGrafo.arcos[x][y] != 0.0 )
							&& existeVertice( pGrafo, x )
							&& existeVertice( pGrafo, y );
			
			if(existeArista == true){
				printf("1 | ");		
			}else {
				printf("0 | ");
			}
		}
		printf("\n");
	}	
}

void visualizarMatrizPesos( tGrafoPonderado pGrafo ) {
	// Pre-condición: obtener cantidad de vértices del grafo
	// Consiste en recorrer la matriz de arcos, e identificar si existe una arista 
	// y mostrar su contenido en su lugar y 0 en caso contrario
	
	int x, y;
	int maxV = maximoVertice( pGrafo );
	bool existeArista = false;
	
	printf("\n*** MATRIZ DE ADYACENCIA ***\n");	
	
	for(x=0; x<=maxV; x++){	
		for(y=0; y<=maxV; y++){
			existeArista = 	( pGrafo.arcos[x][y] != 0.0 )
							&& existeVertice( pGrafo, x )
							&& existeVertice( pGrafo, y );
			
			if(existeArista == true){
				printf("%.2f | ", pGrafo.arcos[x][y]);		
			}else {
				printf("00.00 | ");
			}
		}
		printf("\n");
	}
	
	
}

bool existeVertice( tGrafoPonderado pGrafo, tVertice pVertice ) {
	// Consiste en identificar s iel vértice está activo
	return pGrafo.vertices[pVertice] == true;
}

