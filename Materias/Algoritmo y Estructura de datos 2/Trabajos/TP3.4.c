#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva
int divisionEnteraRecursiva(int dividendo, int divisor);

int main() {
    int dividendo, divisor;

    printf("Ingrese el dividendo: ");
    scanf("%d", &dividendo);

    printf("Ingrese el divisor: ");
    scanf("%d", &divisor);

    if (divisor != 0) {
        int resultado = divisionEnteraRecursiva(dividendo, divisor);
        printf("Resultado de la division entera: %d\n", resultado);
    } else {
        printf("El divisor no puede ser cero.\n");
    }

    return 0;
}

int divisionEnteraRecursiva(int dividendo, int divisor) {
    if (divisor == 0) {
        // Evitar la división por cero
        printf("Error: División por cero.\n");
        exit(1);
    }

    if (dividendo < divisor) {
        return 0; // Caso base: El dividendo es menor que el divisor, la división entera es 0.
    } else {
        // Llamada recursiva reduciendo el dividendo
        return 1 + divisionEnteraRecursiva(dividendo - divisor, divisor);
    }
}

