#include <stdio.h>

// Función para encontrar la menor altura en una serie
float encontrarMenorAltura(float serie[], int tamano, int* mesMenorAltura) {
    float menorAltura = serie[0];
    *mesMenorAltura = 0;

    for (int i = 1; i < tamano; i++) {
        if (serie[i] < menorAltura) {
            menorAltura = serie[i];
            *mesMenorAltura = i;
        }
    }

    return menorAltura;
}

int main() {
    // Declarar las dos series de datos
    float serie1[] = {1.2, 1.5, 0.8, 0.7, 1.0, 0.9, 1.1, 1.3, 1.4, 1.2, 1.0, 0.7};
    float serie2[] = {0.9, 0.6, 0.8, 0.5, 0.7, 0.4, 0.9, 1.0, 0.8, 0.7, 0.6, 0.5};
    int tamanoSerie = sizeof(serie1) / sizeof(serie1[0]);

    // Variables para almacenar los resultados
    int mesMenorAlturaSerie1, mesMenorAlturaSerie2;
    float menorAlturaSerie1, menorAlturaSerie2;

    // Encontrar la menor altura y el mes correspondiente en cada serie
    menorAlturaSerie1 = encontrarMenorAltura(serie1, tamanoSerie, &mesMenorAlturaSerie1);
    menorAlturaSerie2 = encontrarMenorAltura(serie2, tamanoSerie, &mesMenorAlturaSerie2);

    // Imprimir los resultados
    printf("En la Serie 1, la menor altura fue %.2f en el mes %d\n", menorAlturaSerie1, mesMenorAlturaSerie1 + 1);
    printf("En la Serie 2, la menor altura fue %.2f en el mes %d\n", menorAlturaSerie2, mesMenorAlturaSerie2 + 1);

    // Determinar en qué serie se dio la menor altura
    if (menorAlturaSerie1 < menorAlturaSerie2) {
        printf("La menor altura se dio en la Serie 1\n");
    } else if (menorAlturaSerie2 < menorAlturaSerie1) {
        printf("La menor altura se dio en la Serie 2\n");
    } else {
        printf("La menor altura se dio en ambas series\n");
    }

    return 0;
}

