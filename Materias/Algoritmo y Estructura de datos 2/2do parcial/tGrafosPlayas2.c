#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 15

typedef struct {
    double distancia; // Distancia en km
    double combustible; // Consumo promedio de combustible en litros
} tArista;

typedef struct {
    int numVertices;//cantidad de nodos
    tArista matrizAdyacencia[MAX_VERTICES][MAX_VERTICES];//caminos
} tGrafoPlayas;


void inicializarGrafo(tGrafoPlayas* grafo) {
    grafo->numVertices = 0;

    for (int i = 0; i < MAX_VERTICES; i++) {
        for (int j = 0; j < MAX_VERTICES; j++) {
            grafo->matrizAdyacencia[i][j].distancia = 0.0;//establece la distancia entre los vertices
            grafo->matrizAdyacencia[i][j].combustible = 0.0;//establece la cantidad de combustible que se utiliza pra recorrer esas distancias
        }
    }
}

void agregarVertice(tGrafoPlayas* grafo) {
    if (grafo->numVertices < MAX_VERTICES) {//si la cantidad de vertices es menor a 15 se agrega un vertice
        grafo->numVertices++;//se agrega
    } else {
        printf("No se pueden agregar más vértices. El grafo está lleno.\n");//si es igual a 15 se imprime no se pueden agregar mas vertices
    }
}

void agregarArista(tGrafoPlayas* grafo, int origen, int destino, double distancia, double combustible) {
    if (origen >= 1 && origen <= grafo->numVertices &&
        destino >= 1 && destino <= grafo->numVertices) {//verifica que se puede agregar un camino con distancia y combustible entre dos vertices
        grafo->matrizAdyacencia[origen - 1][destino - 1].distancia = distancia;
        grafo->matrizAdyacencia[origen - 1][destino - 1].combustible = combustible;
    } else {
        printf("Vértices de origen o destino no válidos.\n");
    }
}

void imprimirMatriz(tGrafoPlayas* grafo, char tipo) {
    printf("Matriz de %s:\n", (tipo == 'a' ? "Adyacencia" : "Pesos"));//se dice si se quiere la matriz de adyacencia o de pesos
    for (int i = 0; i < grafo->numVertices; i++) {
        for (int j = 0; j < grafo->numVertices; j++) {
            if (tipo == 'a') {
                if (grafo->matrizAdyacencia[i][j].distancia > 0) {
                    printf("1 ");//si hay relacion entre los vertices se imprime 1
                } else {
                    printf("0 ");//si no hay relacion se imprime 0
                }
            } else if (tipo == 'p') {
                printf("(%.2lf km, %.2lf ltrs) ", grafo->matrizAdyacencia[i][j].distancia, grafo->matrizAdyacencia[i][j].combustible);//se imprime los pesos de la matriz y sino 0.00
            }
        }
        printf("\n");
    }
}

int main() {
    tGrafoPlayas grafo;
    inicializarGrafo(&grafo);

    char opcion;
    int origen, destino;
    double distancia, combustible;

    while (2) {
        printf("Menu:\n");
        printf("1. Agregar vertice\n");
        printf("2. Agregar arco\n");
        printf("3. Imprimir matriz de adyacencia (a)\n");
        printf("4. Imprimir matriz de pesos (p)\n");
        printf("5. Salir\n");

        printf("Seleccione una opcion: ");
        scanf(" %c", &opcion);

        switch (opcion) {
            case '1':
                agregarVertice(&grafo);
                break;

            case '2':
                printf("Ingrese el vertice de origen: ");
                scanf("%d", &origen);
                printf("Ingrese el vertice de destino: ");
                scanf("%d", &destino);
                printf("Ingrese la distancia en km: ");
                scanf("%lf", &distancia);
                printf("Ingrese el consumo promedio de combustible en litros: ");
                scanf("%lf", &combustible);
                agregarArista(&grafo, origen, destino, distancia, combustible);
                break;

            case '3':
                imprimirMatriz(&grafo, 'a');
                break;

            case '4':
                imprimirMatriz(&grafo, 'p');
                break;

            case '5':
                exit(0);

            default:
                printf("Opcion no valida. Por favor, seleccione una opcion valida.\n");
        }
    }

    return 0;
}
