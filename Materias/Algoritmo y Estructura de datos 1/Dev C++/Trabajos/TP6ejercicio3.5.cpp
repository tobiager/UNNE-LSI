#include <stdio.h>
#include <ctype.h>
#include <string.h>

int esPalindromo(char cadena[]) {
    int longitud = strlen(cadena);
    int i = 0;
    int j = longitud - 1;

    while (i < j) {
        if (tolower(cadena[i]) != tolower(cadena[j])) {
            return 0;  // No es palíndromo
        }
        i++;
        j--;
    }

    return 1;  // Es palíndromo
}

int main() {
    char cadena[100];

    printf("Ingrese una cadena: ");
    fgets(cadena, sizeof(cadena), stdin);

    // Eliminar el salto de línea final de fgets
    cadena[strcspn(cadena, "\n")] = '\0';

    if (esPalindromo(cadena)) {
        printf("La cadena es un palindromo.\n");
    } else {
        printf("La cadena no es un palindromo.\n");
    }

    return 0;
}

