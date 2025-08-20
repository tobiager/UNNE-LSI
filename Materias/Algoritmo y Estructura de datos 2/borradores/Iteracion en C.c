#include <stdio.h>

int main() {
    int fac = 0;
    
    printf("Ingresa un numero para calcular el factorial: ");
    scanf("%d", &fac);

    if (fac < 0) {
        printf("El factorial no está definido para números negativos.\n");
    } else if (fac == 0) {
        printf("El factorial de 0 es 1.\n");
    } else {
        int temp = fac - 1;
        int r = fac;

        while (temp >= 1) {
            r = r * temp;
            temp--;
        }

        printf("El factorial de %d es: %d\n", fac, r);
    }

    return 0;
}

