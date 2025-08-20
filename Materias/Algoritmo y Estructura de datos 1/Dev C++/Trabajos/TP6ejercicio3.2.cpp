#include <stdio.h>
#include <string.h>
#include <ctype.h>

int contarPalabras(const char *titulo) {
    int palabras = 0;
    int longitud = strlen(titulo);
    bool enPalabra = false;

    for (int i = 0; i < longitud; i++) {
        if (titulo[i] == ' ' || titulo[i] == '.') {
            enPalabra = false;
        } else if (!enPalabra) {
            enPalabra = true;
            palabras++;
        }
    }

    return palabras;
}

void convertirMayusculas(char *titulo) {
    int longitud = strlen(titulo);

    for (int i = 0; i < longitud; i++) {
        titulo[i] = toupper(titulo[i]);
    }
}

int main() {
    char titulo[200];
    int palabras;

    printf("Ingrese el titulo del trabajo (termine con un punto): ");
    fgets(titulo, sizeof(titulo), stdin);

    // Eliminar el salto de línea al final del título
    titulo[strcspn(titulo, "\n")] = '\0';

    palabras = contarPalabras(titulo);
    convertirMayusculas(titulo);

    printf("Titulo en mayusculas: %s\n", titulo);

    if (palabras > 20) {
        printf("El titulo excede las 20 palabras.\n");
    } else {
        printf("El titulo no excede las 20 palabras.\n");
    }

    return 0;
}

