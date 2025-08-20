#include <stdio.h>

#define NMAX 100 // Define la dimensión máxima del vector

// Declaración de la función recursiva
int sumaVec(int v[], int n);

int main() {
    int n;
    int v[NMAX];

    printf("Ingrese la cantidad de elementos del vector: ");
    scanf("%d", &n);

    if (n >= 0 && n <= NMAX) {
        printf("Ingrese los elementos del vector:\n");
        for (int i = 0; i < n; i++) {
            scanf("%d", &v[i]);
        }

        int resultado = sumaVec(v, n);
        printf("La suma de los elementos del vector es: %d\n", resultado);
    } else {
        printf("La cantidad de elementos debe estar entre 0 y %d.\n", NMAX);
    }

    return 0;
}

int sumaVec(int v[], int n) {
    if (n == 0) {
        return 0; // Caso base: el vector está vacío, la suma es 0.
    } else {
        return sumaVec(v, n - 1) + v[n - 1]; // Llamada recursiva con n-1 y suma del último elemento.
    }
}

