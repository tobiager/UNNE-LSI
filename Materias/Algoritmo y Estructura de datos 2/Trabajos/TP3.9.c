#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>

// Declaraci�n de la funci�n para calcular la suma
int sumaNaturales(int n);

// Funci�n para mostrar la serie de n�meros desde 1 hasta N
void mostrarSerie(int n);

int main() {
    int N;

    printf("Ingrese un numero natural N: ");
    scanf("%d", &N);

    if (N >= 1) {
        printf("Serie de numeros naturales desde 1 hasta %d:\n", N);
        mostrarSerie(N);

        int resultado = sumaNaturales(N);
        printf("La suma de los numeros naturales hasta %d es: %d\n", N, resultado);
    } else {
        printf("El numero debe ser un numero natural (mayor o igual a 1).\n");
    }

    return 0;
}

int sumaNaturales(int n) {
    if (n == 1) {
        return 1; // Caso base: La suma de 1 n�mero natural es 1.
    } else {
        return n + sumaNaturales(n - 1); // Llamada recursiva para sumar los n�meros naturales restantes.
    }
}

void mostrarSerie(int n) {
    int i;
    for (i = 1; i <= n; i++) {
        printf("%d ", i);
    }
    printf("\n");
}

