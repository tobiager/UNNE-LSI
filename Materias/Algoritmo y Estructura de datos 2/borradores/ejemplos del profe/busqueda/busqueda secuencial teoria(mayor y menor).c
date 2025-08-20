#include <stdio.h>

#define MAX 100

typedef struct {
    int data[MAX];
    int size;
} tVectorInt;

int busquedaSecuencial(tVectorInt *pVector, int elem) {
    int result = -1;
    int i = 0;

    while (i < pVector->size && pVector->data[i] != elem) {
        i = i + 1;
    }

    if (i < pVector->size && pVector->data[i] == elem) {
        result = i;
    }

    return result;
}

int buscarMayor(tVectorInt *pVector) {
    int i, mayor, posMayor;
    mayor = pVector->data[0];
    posMayor = 0;

    for (i = 1; i < pVector->size; i++) {
        if (pVector->data[i] > mayor) {
            mayor = pVector->data[i];
            posMayor = i;
        }
    }

    return posMayor;
}

int buscarMenor(tVectorInt *pVector) {
    int i, menor, posMenor;
    menor = pVector->data[0];
    posMenor = 0;

    for (i = 1; i < pVector->size; i++) {
        if (pVector->data[i] < menor) {
            menor = pVector->data[i];
            posMenor = i;
        }
    }

    return posMenor;
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

        int resultado = busquedaSecuencial(&vector, elementoBuscar);

        if (resultado != -1) {
            printf("El valor %d se encuentra en la posicion %d del vector.\n", elementoBuscar, resultado);
        } else {
            printf("El valor %d no se encuentra en el vector.\n", elementoBuscar);
        }

        printf("\n¿Desea buscar otro valor? (S/N): ");
        scanf(" %c", &respuesta);

    } while (respuesta == 'S' || respuesta == 's');

    int posMayor = buscarMayor(&vector);
    printf("\nEl elemento mayor del vector es %d y esta en la posicion %d\n", vector.data[posMayor], posMayor);
    
    int posMenor = buscarMenor(&vector);
    printf("\nEl elemento menor del vector es %d y esta en la posicion %d\n", vector.data[posMenor], posMenor);

    return 0;
}

