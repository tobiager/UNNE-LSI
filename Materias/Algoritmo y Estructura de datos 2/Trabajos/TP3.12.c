#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva para calcular la secuencia de Fibonacci
int fibonacci(int n);

int main() {
    int n;

    printf("Ingrese un numero entero positivo para calcular la secuencia de Fibonacci: ");
    scanf("%d", &n);

    if (n >= 0) {
        printf("Secuencia de Fibonacci hasta el termino %d:\n", n);

        int i;
        for (i = 0; i <= n; i++) {
            printf("%d ", fibonacci(i));
        }
        printf("\n");
    } else {
        printf("El numero debe ser un entero positivo.\n");
    }

    return 0;
}

int fibonacci(int n) {
    if (n <= 1) {
        return n; // Caso base: Fibonacci(0) = 0, Fibonacci(1) = 1
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2); // Llamada recursiva para calcular Fibonacci(n)
    }
}

