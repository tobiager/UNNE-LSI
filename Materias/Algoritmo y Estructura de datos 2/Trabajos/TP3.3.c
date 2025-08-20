#include <stdio.h>
#include <stdlib.h>

// Declaraci�n de la funci�n recursiva
void mostrarInvertido(int n);

int main() {
    int numero;

    printf("Ingrese un numero entero positivo: ");
    scanf("%d", &numero);

    if (numero >= 0) {
        printf("El numero invertido es: ");
        mostrarInvertido(numero);
        printf("\n");
    } else {
        printf("El numero debe ser positivo.\n");
    }

    return 0;
}

void mostrarInvertido(int n) {
    if (n < 10) {
        printf("%d", n); // Caso base: Imprime el �ltimo d�gito
    } else {
        printf("%d", n % 10); // Imprime el �ltimo d�gito
        mostrarInvertido(n / 10); // Llamada recursiva con n dividido por 10
    }
}

