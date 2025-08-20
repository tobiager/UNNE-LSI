#include <stdio.h>
#include <stdbool.h>
#include <string.h>

// Funci�n para verificar si una palabra es un pal�ndromo
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
            return false; // No es un pal�ndromo
        }
        izquierda++;
        derecha--;
    }

    return true; // Es un pal�ndromo
}

