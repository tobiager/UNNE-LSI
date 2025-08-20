#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva
int calcularFactorial(int n);

int main() {
    int numero;

    printf("Ingrese un número entero positivo: ");
    scanf("%d", &numero);

    if (numero >= 0) {
        int resultado = calcularFactorial(numero);
        printf("El factorial de %d es: %d\n", numero, resultado);
    } else {
        printf("El número debe ser un entero positivo.\n");
    }

    return 0;
}

int calcularFactorial(int n) {
    if (n == 0 || n == 1) {
        return 1; // Caso base: el factorial de 0 y 1 es 1.
    } else {
        return n * calcularFactorial(n - 1); // Llamada recursiva para calcular el factorial.
    }
}

