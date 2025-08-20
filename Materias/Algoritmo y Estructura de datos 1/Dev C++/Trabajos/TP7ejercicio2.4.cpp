#include <stdio.h>

int main() {
    int casos[3][5]; // Matriz para almacenar los casos diarios de COVID-19 (3 meses x 5 días)
    int acumulados[3] = {0}; // Vector para almacenar los acumulados mensuales (3 meses)
    int maxCasos = 0, minCasos = -1;
    int maxMes, maxDia, minMes, minDia;

    // Ingreso de datos
    for (int i = 0; i < 3; i++) {
        printf("Mes %d:\n", i + 1);
        for (int j = 0; j < 5; j++) {
            printf("Ingrese la cantidad de casos para el dia %d: ", j + 1);
            scanf("%d", &casos[i][j]);
            acumulados[i] += casos[i][j]; // Calcula el acumulado mensual
        }
    }

    // Buscar el máximo y mínimo de casos nuevos
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 5; j++) {
            if (casos[i][j] > maxCasos) {
                maxCasos = casos[i][j];
                maxMes = i + 1;
                maxDia = j + 1;
            }
            if (minCasos == -1 || casos[i][j] < minCasos) {
                minCasos = casos[i][j];
                minMes = i + 1;
                minDia = j + 1;
            }
        }
    }

    // Mostrar los datos de la matriz y el vector con los datos acumulados
    printf("\nDatos de la matriz:\n");
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 5; j++) {
            printf("Mes %d, día %d: %d casos\n", i + 1, j + 1, casos[i][j]);
        }
    }

    printf("\nDatos acumulados mensuales:\n");
    for (int i = 0; i < 3; i++) {
        printf("Mes %d: %d casos\n", i + 1, acumulados[i]);
    }

    // Mostrar la mayor cantidad de casos nuevos y su fecha
    printf("\nMayor cantidad de casos nuevos:\n");
    printf("Mes %d, día %d: %d casos\n", maxMes, maxDia, maxCasos);

    // Mostrar la menor cantidad de casos nuevos y su fecha
    printf("\nMenor cantidad de casos nuevos:\n");
    printf("Mes %d, día %d: %d casos\n", minMes, minDia, minCasos);

    return 0;
}

