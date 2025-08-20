#include <stdio.h>

int main() {
    int n, i, key;
    char respuesta;

    do {
        printf("Ingrese el tama%co del vector: ",164);
        scanf("%d", &n);

        int arr[n];

        printf("Ingrese %d valores al vector:\n", n);
        for (i = 0; i < n; i++) {
            scanf("%d", &arr[i]);
        }

        do {
            printf("Ingrese el valor que desea buscar: ");
            scanf("%d", &key);

            int found = 0;
            for (i = 0; i < n; i++) {
                if (arr[i] == key) {
                    printf("El valor %d se encuentra en la posicion %d del vector.\n", key, i);
                    found = 1;
                    break;
                }
            }

            if (!found) {
                printf("El valor %d no se encuentra en el vector.\n", key);
            }

            printf("\n¿Desea buscar otro valor? (S/N): ");
            scanf(" %c", &respuesta);  // Espacio antes de %c para consumir el salto de línea.

        } while (respuesta == 'S' || respuesta == 's');

        printf("\n¿Desea ingresar otro vector? (S/N): ");
        scanf(" %c", &respuesta);  // Espacio antes de %c para consumir el salto de línea.

    } while (respuesta == 'S' || respuesta == 's');

    return 0;
}


