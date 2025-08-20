#include <stdio.h>
#include <string.h>
#include <ctype.h>

int contarVocales(const char *frase, char vocal) {
    int cantidad = 0;
    int longitud = strlen(frase);

    for (int i = 0; i < longitud; i++) {
        if (tolower(frase[i]) == tolower(vocal)) {
            cantidad++;
        }
    }

    return cantidad;
}

int main() {
    char frase[200];
    char vocal;
    int cantidad;

    printf("Ingrese una frase (termine con un punto): ");
    fgets(frase, sizeof(frase), stdin);

    // Eliminar el salto de línea al final de la frase
    frase[strcspn(frase, "\n")] = '\0';

    printf("Ingrese una vocal: ");
    scanf("%c", &vocal);

    cantidad = contarVocales(frase, vocal);

    printf("La vocal '%c' aparece %d veces en la frase.\n", vocal, cantidad);

    return 0;
}

