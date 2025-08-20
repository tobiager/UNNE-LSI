#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_VERTICES 10

// Definición del tipo de dato para el grafo ponderado
typedef struct {
    int numVertices;
    double matrizPesos[MAX_VERTICES][MAX_VERTICES];
} tGrafoPonderado;

// Función para inicializar el grafo
void inicializarGrafo(tGrafoPonderado *grafo) {
    grafo->numVertices = 0;
    int i, j; // Variables declaradas fuera del bucle
    for (i = 0; i < MAX_VERTICES; i++) {
        for (j = 0; j < MAX_VERTICES; j++) {
            grafo->matrizPesos[i][j] = 0.0;
        }
    }
}

// Función para agregar un vértice al grafo
int agregarVertice(tGrafoPonderado *grafo) {
    if (grafo->numVertices < MAX_VERTICES) {
        grafo->numVertices++;
        return grafo->numVertices - 1; // Devuelve el índice del vértice
    } else {
        return -1; // No se pueden agregar más vértices
    }
}

// Función para agregar un arco ponderado entre dos vértices
void agregarArco(tGrafoPonderado *grafo, int vertice1, int vertice2, double peso) {
    if (vertice1 >= 0 && vertice1 < grafo->numVertices && vertice2 >= 0 && vertice2 < grafo->numVertices) {
        grafo->matrizPesos[vertice1][vertice2] = peso;
    }
}

// Función para visualizar la matriz de pesos del grafo
void visualizarMatrizPesos(tGrafoPonderado *grafo) {
    printf("Matriz de Pesos (en kg):\n");
    int i, j; // Variables declaradas fuera del bucle
    for (i = 0; i < grafo->numVertices; i++) {
        for (j = 0; j < grafo->numVertices; j++) {
            printf("%.2f\t", grafo->matrizPesos[i][j]);
        }
        printf("\n");
    }
}

int main() {
    tGrafoPonderado grafo;
    inicializarGrafo(&grafo);

    int opcion;
    int v1, v2;
    double peso;
    
    while (1) {
        printf("\n--- Menu ---\n");
        printf("1. Agregar un vértice al grafo\n");
        printf("2. Agregar un arco al grafo\n");
        printf("3. Visualizar la matriz de pesos\n");
        printf("4. Salir\n");
        printf("Selecciona una opción: ");
        scanf("%d", &opcion);
        
        switch (opcion) {
            case 1:
                v1 = agregarVertice(&grafo);
                if (v1 == -1) {
                    printf("No se pueden agregar más vértices.\n");
                } else {
                    printf("Vértice %d agregado al grafo.\n", v1);
                }
                break;
                
            case 2:
                printf("Ingrese el índice de los dos vértices (separados por espacio) y el peso (en kg) para agregar un arco: ");
                scanf("%d %d %lf", &v1, &v2, &peso);
                agregarArco(&grafo, v1, v2, peso);
                printf("Arco agregado entre vértices %d y %d con un peso de %.2f kg.\n", v1, v2, peso);
                break;
                
            case 3:
                visualizarMatrizPesos(&grafo);
                break;
                
            case 4:
                return 0;
                
            default:
                printf("Opción no válida. Intente de nuevo.\n");
        }
    }

    return 0;
}

