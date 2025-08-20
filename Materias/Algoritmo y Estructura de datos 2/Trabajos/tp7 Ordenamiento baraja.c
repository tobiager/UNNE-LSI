#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define N 5

typedef int tVector[N];  // Definici�n de un tipo de dato tVector que representa un arreglo de enteros de tama�o N (5 en este caso).

void cargarVector();
void ordenamientoInsercion(tVector);
void mostrarVector(tVector);

tVector vector;  // Declaraci�n de un arreglo de enteros llamado 'vector' de tama�o N.

int main() {
    cargarVector();  // Llama a la funci�n para cargar valores en el arreglo 'vector'.
    ordenamientoInsercion(vector);  // Llama a la funci�n para ordenar el arreglo 'vector' usando el algoritmo de inserci�n.
    mostrarVector(vector);  // Llama a la funci�n para mostrar el arreglo 'vector' ordenado.
    return 0;
}

// Funci�n para cargar valores en el arreglo 'vector'.
void cargarVector() {
    int i;
    printf("Ingrese los numeros que desea ordenar:\t");
    for (i = 0; i < N; i++) {
        scanf("%d", &vector[i]);
    }
}

// Funci�n para ordenar un arreglo usando el algoritmo de inserci�n.
void ordenamientoInsercion(tVector pVector) {
    int i, j, aux;
    for (i = 1; i < N; i++) {
        aux = pVector[i];  // Selecciona el elemento actual a ser insertado en la parte ordenada del arreglo.
        j = i - 1;

        // Mueve los elementos mayores al elemento actual a la derecha.
        while ((j >= 0) && (pVector[j] > aux)) {
            pVector[j + 1] = pVector[j];
            j = j - 1;
        }

        pVector[j + 1] = aux;  // Inserta el elemento actual en la posici�n correcta.
    }
}

// Funci�n para mostrar el arreglo 'vector' ordenado.
void mostrarVector(tVector pVector) {
    int i;

    printf("Numeros ordenados de menor a mayor: \t");
    for (i = 0; i < N; i++) {
        printf("- %d", vector[i]);
    }
}

