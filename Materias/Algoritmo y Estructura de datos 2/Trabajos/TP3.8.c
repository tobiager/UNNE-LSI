#include <stdio.h>

// Declaración de la función recursiva
int calcularPotencia(int base, int exponente);

int main() {
    int base, exponente;

    printf("Ingrese la base entera: ");
    scanf("%d", &base);

    printf("Ingrese el exponente entero positivo: ");
    scanf("%d", &exponente);

    if (exponente >= 0) {
        int resultado = calcularPotencia(base, exponente);
        printf("%d elevado a %d es igual a: %d\n", base, exponente, resultado);
    } else {
        printf("El exponente debe ser un número entero positivo.\n");
    }

    return 0;
}

int calcularPotencia(int base, int exponente) {
    if (exponente == 0) {
        return 1; // Caso base: cualquier número elevado a 0 es 1.
    } else {
        return base * calcularPotencia(base, exponente - 1); // Definición recursiva basada en la propiedad asociativa de la multiplicación.
    }
}

