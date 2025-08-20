#include <stdio.h>
#include <stdbool.h>

#define MAX 100

typedef struct {
    int data[MAX];
    int size;
} tVectorInt;

int busquedaBinaria(tVectorInt pVector, int elem) {
    int extInf = 0;
    int extSup = pVector.size - 1;
    int posMed;
    bool encontrado = false;
    int result = -1;

    while (!encontrado && extSup >= extInf) {
        posMed = (extSup + extInf) / 2;

        if (elem == pVector.data[posMed]) {
            encontrado = true;
        } else {
            if (elem > pVector.data[posMed]) {
                extInf = posMed + 1;
            } else {
                extSup = posMed - 1;
            }
        }
    }

    if (encontrado) {
        result = posMed;
    }

    return result;
}


void ingresarVector(tVectorInt *pVector) {
    int i, n;

    printf("Ingrese el tama%co del vector: ",164);
    scanf("%d", &n);

    pVector->size = n;

    printf("Ingrese %d valores al vector:\n", n);
    for (i = 0; i < n; i++) {
        scanf("%d", &pVector->data[i]);
    }
}


int main() {
    tVectorInt vector;

    char respuesta;
    
    ingresarVector(&vector);
    
    do {
        
        int elementoBuscar;
        printf("Ingrese el valor que desea buscar: ");
        scanf("%d", &elementoBuscar);

        int resultado = busquedaBinaria(vector, elementoBuscar);

        if (resultado != -1) {
            printf("El valor %d se encuentra en la posicion %d del vector.\n", elementoBuscar, resultado);
        } else {
            printf("El valor %d no se encuentra en el vector.\n", elementoBuscar);
        }

        printf("¿Desea buscar otro valor en este vector? (S/N): ");
        scanf(" %c", &respuesta);

    } while (respuesta == 'S' || respuesta == 's');

    return 0;
}


