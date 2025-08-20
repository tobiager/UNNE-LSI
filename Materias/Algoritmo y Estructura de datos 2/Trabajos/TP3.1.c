#include <stdio.h>
#include <stdlib.h>

// Declaración de la función recursiva
void cuentaRegresiva(int n);

int main() {
    int valor;

    printf("Ingrese un valor para la cuenta regresiva: ");
    scanf("%d", &valor);

    if (valor >= 0) {
        cuentaRegresiva(valor);
    } else {
        printf("El valor debe ser no negativo.\n");
    }

    return 0;
}

void cuentaRegresiva(int n) {
    if (n == 0) {
        printf("Cuenta Finalizada.\n");
    } else {
        printf("%d\n", n);
        cuentaRegresiva(n - 1); // Llamada recursiva con n-1
    }
}

