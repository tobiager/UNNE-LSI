#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva
int multiplicacionRecursiva(int a, int b);

int main() {
    int numero1, numero2;

    printf("Ingrese el primer numero entero positivo: ");
    scanf("%d", &numero1);

    printf("Ingrese el segundo numero entero positivo: ");
    scanf("%d", &numero2);

    if (numero1 >= 0 && numero2 >= 0) {
        int resultado = multiplicacionRecursiva(numero1, numero2);
        printf("El producto de %d y %d es: %d\n", numero1, numero2, resultado);
    } else {
        printf("Ambos numeros deben ser positivos.\n");
    }

    return 0;
}

int multiplicacionRecursiva(int a, int b) {
    if (b == 0) {
        return 0; // Caso base: La multiplicación de cualquier número por 0 es 0.
    } else {
        return a + multiplicacionRecursiva(a, b - 1); // Definición recursiva basada en la propiedad asociativa de la suma.
    }
}

