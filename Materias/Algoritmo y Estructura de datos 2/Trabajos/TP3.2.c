#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva
void verEnBinario(int n);

int main() {
    int numero;

    printf("Ingrese un numero entero: ");
    scanf("%d", &numero);

    if (numero >= 0) {
        printf("El equivalente en binario es: ");
        if (numero == 0) {
            printf("0");
        } else {
            verEnBinario(numero);
        }
        printf("\n");
    } else {
        printf("El numero debe ser no negativo.\n");
    }

    return 0;
}

void verEnBinario(int n) {
    if (n > 0) {
        verEnBinario(n / 2); // Llamada recursiva con n dividido por 2
        printf("%d", n % 2);
    }
}

