#include <stdio.h>

#define SIZE 10

void generarVectorB(const char vectorA[], char vectorB[]) {
    for (int i = 0; i < SIZE; i++) {
        vectorB[i] = vectorA[SIZE - 1 - i];
    }
}

void mostrarVectores(const char vectorA[], const char vectorB[]) {
    printf("Vector A: ");
    for (int i = 0; i < SIZE; i++) {
        printf("%c ", vectorA[i]);
    }

    printf("\nVector B: ");
    for (int i = 0; i < SIZE; i++) {
        printf("%c ", vectorB[i]);
    }
    printf("\n");
}

int main() {
    char vectorA[SIZE];
    char vectorB[SIZE];

    printf("Ingrese los elementos del vector A:\n");
    for (int i = 0; i < SIZE; i++) {
        printf("Elemento %d: ", i + 1);
        scanf(" %c", &vectorA[i]);
    }

    generarVectorB(vectorA, vectorB);

    mostrarVectores(vectorA, vectorB);

    return 0;
}

