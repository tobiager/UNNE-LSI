 #include <stdio.h>
#include <stdbool.h>
#define N 10

/* Declaración de tipos de datos personalizados */
typedef int tVertice;

typedef struct {
	tVertice origen;
	tVertice destino;	
} tArco;

typedef bool conjuntoVertices[N];
typedef bool conjuntoArcos[N][N];

typedef struct {
	conjuntoVertices vertices;
	conjuntoArcos arcos;
} tGrafoNoPonderado;

/* Declaración de los prototipos */
void inicializarGrafo( tGrafoNoPonderado * );
void agregarVertice( tGrafoNoPonderado *, tVertice ); 
void agregarArco( tGrafoNoPonderado *, tArco ); 
void borrarVertice( tGrafoNoPonderado *, tVertice ); 
void borrarArco( tGrafoNoPonderado *, tArco ); 

int maximoVertice( tGrafoNoPonderado );
void visualizarMatrizAdyacencia( tGrafoNoPonderado );
bool existeVertice( tGrafoNoPonderado, tVertice );

/* Declaración de las variables globales */
tGrafoNoPonderado grafo;

int main() {
	tArco arco;
					
	inicializarGrafo( &grafo );
	agregarVertice( &grafo, 2 );
	agregarVertice( &grafo, 3 );
	agregarVertice( &grafo, 4);
	//[0,0,1,1,1,0,0,0,0,0,0]
	
	arco.origen = 3;
	arco.destino = 2;
	agregarArco( &grafo, arco );
	
	arco.origen = 2;
	arco.destino = 4;
	agregarArco( &grafo, arco );
	
	arco.origen = 3;
	arco.destino = 4;
	agregarArco( &grafo, arco );
	
	visualizarMatrizAdyacencia( grafo );
	
	borrarVertice( &grafo, 2 );
	
	visualizarMatrizAdyacencia( grafo );
	
	borrarArco( &grafo, arco );
	
	visualizarMatrizAdyacencia( grafo );
	
	return 0;
}

void inicializarGrafo( tGrafoNoPonderado * pGrafo ) {
	int x, y;
	
	for( x=0; x<=N; x++ ) {
		pGrafo->vertices[x] = 0;		
					
		for( y=0; y<=N; y++ ) {
			pGrafo->arcos[x][y] = 0;
		}
	}
}

void agregarVertice( tGrafoNoPonderado * pGrafo, tVertice pVertice ) {
	// ( *pGrafo ).vertices[pVertice] = 1;
	pGrafo->vertices[pVertice] = 1;//
	printf( "Se agrego el vertice %d\n", pVertice );
} 

void agregarArco( tGrafoNoPonderado * pGrafo, tArco pArco )  {
	if( pGrafo->vertices[pArco.origen] == 1 
			&& pGrafo->vertices[pArco.destino] == 1 ) {
		( *pGrafo ).arcos[pArco.origen][pArco.destino] = 1;
		printf( "Se agrego el arco [%d, %d]\n", pArco.origen, pArco.destino );
	} else {
		printf( "No se pudo agregar - Alguno de los vertices no se encuentra activo\n" );
	}		
}

void borrarVertice( tGrafoNoPonderado * pGrafo, tVertice pVertice )  {
	if( pGrafo->vertices[pVertice] =! 0 ) {
		pGrafo->vertices[pVertice] = 0;
		printf( "Se desactivo el vertice %d\n", pVertice );
	} else {
		printf( "El vertice no se encuentra \n" );
	}

}

void borrarArco( tGrafoNoPonderado * pGrafo, tArco pArco )  {
	if( pGrafo->arcos[pArco.origen][pArco.destino] != 0 ) {
		pGrafo->arcos[pArco.origen][pArco.destino] = 0;
		printf( "Se desactivo el arco [%d, %d]\n", pArco.origen, pArco.destino );
	} else {
		printf( "El arco no se encuentra \n" );
	}	
	
} 

int maximoVertice( tGrafoNoPonderado pGrafo )  {
	int x, max;
	max = 0;

	for( x=0; x<N; x++ ) {
		if( pGrafo.vertices[x] == 1) {
			max = x;
		}
	}	
	return max;
}

void visualizarMatrizAdyacencia( tGrafoNoPonderado pGrafo )  {
	int x, y, maxVer;
	bool existeArista = false;
	
	maxVer= maximoVertice( pGrafo );
	
	
	printf( "\n MATRIZ DE ADYACENCIA \n" );
	for( x=1; x<=maxVer; x++ ) {
		for( y=1; y<=maxVer; y++ ) {
			existeArista = ( pGrafo.arcos[x][y] == 1 ) && existeVertice( pGrafo, x ) && existeVertice( pGrafo, y );
			if( existeArista ) {
				printf("1 ");
			} else {
				printf("0 ");
			}
		}
		printf("\n");
	}
}

bool existeVertice( tGrafoNoPonderado pGrafo, tVertice pVertice ) {
	return pGrafo.vertices[pVertice] == 1;
}
 
