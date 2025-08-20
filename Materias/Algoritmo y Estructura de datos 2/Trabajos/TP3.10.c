#include <stdio.h>
#include <stdbool.h>
#include <string.h>

// Función para verificar si una palabra es un palíndromo
bool esPalindromo(char palabra[]);

int main() {
    char palabra[100];

    printf("Ingrese una palabra: ");
    scanf("%s", palabra);

    if (esPalindromo(palabra)) {
        printf("La palabra '%s' es un palindromo.\n", palabra);
    } else {
        printf("La palabra '%s' no es un palindromo.\n", palabra);
    }

    return 0;
}

bool esPalindromo(char palabra[]) {
    int izquierda = 0;
    int derecha = strlen(palabra) - 1;

    while (izquierda < derecha) {
        if (palabra[izquierda] != palabra[derecha]) {
            return false; // No es un palíndromo
        }
        izquierda++;
        derecha--;
    }

    return true; // Es un palíndromo
}

