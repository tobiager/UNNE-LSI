#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main() {
    char frase[100];
    int contador = 0;

    printf("Ingresa una frase: ");
    fgets(frase, sizeof(frase), stdin);

    int longitud = strlen(frase);

    for (int i = 0; i < longitud; i++) {
        if (isupper(frase[i])) {
            contador++;
        }
    }

    printf("El numero de letras mayúsculas en la frase es: %d\n", contador);

    return 0;
}

