#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_VERTICES 7

// Definición del tipo de dato para el grafo no ponderado
typedef struct {
    int numVertices;
    int matrizAdyacencia[MAX_VERTICES][MAX_VERTICES];
} tGrafoNoPonderado;

// Función para inicializar el grafo
void inicializarGrafo(tGrafoNoPonderado *grafo) {
    grafo->numVertices = 0;
    int i, j; // Variables declaradas fuera del bucle
    for (i = 0; i < MAX_VERTICES; i++) {
        for (j = 0; j < MAX_VERTICES; j++) {
            grafo->matrizAdyacencia[i][j] = 0;
        }
    }
}

// Función para agregar un vértice al grafo
int agregarVertice(tGrafoNoPonderado *grafo) {
    if (grafo->numVertices < MAX_VERTICES) {
        grafo->numVertices++;
        return grafo->numVertices - 1; // Devuelve el índice del vértice
    } else {
        return -1; // No se pueden agregar más vértices
    }
}

// Función para agregar un arco entre dos vértices
void agregarArco(tGrafoNoPonderado *grafo, int vertice1, int vertice2) {
    if (vertice1 >= 0 && vertice1 < grafo->numVertices && vertice2 >= 0 && vertice2 < grafo->numVertices) {
        grafo->matrizAdyacencia[vertice1][vertice2] = 1;
        grafo->matrizAdyacencia[vertice2][vertice1] = 1; // Grafo no dirigido
    }
}

// Función para visualizar la matriz de adyacencia del grafo
void visualizarMatrizAdyacencia(tGrafoNoPonderado *grafo) {
    printf("Matriz de Adyacencia:\n");
    int i, j; // Variables declaradas fuera del bucle
    for (i = 0; i < grafo->numVertices; i++) {
        for (j = 0; j < grafo->numVertices; j++) {
            printf("%d ", grafo->matrizAdyacencia[i][j]);
        }
        printf("\n");
    }
}

int main() {
    tGrafoNoPonderado grafo;
    inicializarGrafo(&grafo);

    int opcion;
    int v1, v2;
    
    while (1) {
        printf("\n--- Menu ---\n");
        printf("1. Agregar un vertice al grafo\n");
        printf("2. Agregar un arco al grafo\n");
        printf("3. Visualizar la matriz de adyacencia\n");
        printf("4. Salir\n");
        printf("Selecciona una opcion: ");
        scanf("%d", &opcion);
        
        switch (opcion) {
            case 1:
                v1 = agregarVertice(&grafo);
                if (v1 == -1) {
                    printf("No se pueden agregar mas vertices.\n");
                } else {
                    printf("Vertice %d agregado al grafo.\n", v1);
                }
                break;
                
            case 2:
                printf("Ingrese el indice de los dos vertices (separados por espacio) para agregar un arco: ");
                scanf("%d %d", &v1, &v2);
                agregarArco(&grafo, v1, v2);
                printf("Arco agregado entre vertices %d y %d.\n", v1, v2);
                break;
                
            case 3:
                visualizarMatrizAdyacencia(&grafo);
                break;
                
            case 4:
                return 0;
                
            default:
                printf("Opcion no valida. Intente de nuevo.\n");
        }
    }

    return 0;
}

