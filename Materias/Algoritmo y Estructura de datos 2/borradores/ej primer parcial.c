#include <stdio.h>

// Variable global para almacenar el resultado de la multiplicación
int resultado = 1;

// Función recursiva para ingresar elementos en un arreglo
void ingresarElementos(int arreglo[], int cantelem, int actual) {
    if (actual < cantelem) {
        printf("Elemento %d: ", actual + 1);
        scanf("%d", &arreglo[actual]);
        ingresarElementos(arreglo, cantelem, actual + 1);
    }
}

// Función recursiva para multiplicar los números impares en un arreglo
void multiplicarImpares(int arreglo[], int cantelem, int actual) {
    // Caso base: si el índice actual es igual a la cantidad de elementos, hemos llegado al final del arreglo.
    if (actual == cantelem) {
        return;
    }

    // Obtenemos el elemento en el índice actual.
    int elementoActual = arreglo[actual];

    // Comprobamos si el elemento actual es impar.
    if (elementoActual % 2 != 0) {
        // Si es impar, multiplicamos por el resultado actual.
        resultado *= elementoActual;
    }

    // Llamamos de manera recursiva a la función con el siguiente índice.
    multiplicarImpares(arreglo, cantelem, actual + 1);
}

int main() {
    int cantelem;
    printf("Ingrese la cantidad de elementos en el arreglo: ");
    scanf("%d", &cantelem);

    int arreglo[cantelem];
    
    // Llamamos a la función recursiva para ingresar elementos en el arreglo.
    ingresarElementos(arreglo, cantelem, 0);

    // Llamamos a la función recursiva para calcular el producto de los impares.
    multiplicarImpares(arreglo, cantelem, 0);
    
    printf("El producto de los números impares en el arreglo es: %d\n", resultado);

    return 0;
}



