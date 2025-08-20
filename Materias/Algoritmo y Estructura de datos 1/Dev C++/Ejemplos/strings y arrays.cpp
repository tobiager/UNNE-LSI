#include <stdio.h>
#include <string.h>

int main() {
    char cadena1[10][15] = {"goku", "esfera", "azul", "verde", "rojo", "leche", "cafe", "programa", "c++", "youdeves"};
    char cadena2[10][15];
    int i, j;

    printf("\nINGRESA PALABRAS PARA LA CADENA2\n\n");

    for (i = 0; i < 10; i++) {
        printf("palabra %d: ", i + 1);
        scanf("%s", cadena2[i]);
    }

    printf("\nComparar cadena1 con cadena2");
    printf("\nLas palabras iguales son: \n\n");

    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            if (strcmp(cadena2[i], cadena1[j]) == 0) {
                printf("%s\n", cadena2[i]);
                break;  // Salir del bucle interno cuando se encuentra una palabra igual
            }
        }
    }

    return 0;
}

