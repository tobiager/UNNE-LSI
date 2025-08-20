#include <stdio.h>
#include <string.h>

#define MAX_ALUMNOS 6

int main() {
    char comision1[MAX_ALUMNOS][100];
    char comision2[MAX_ALUMNOS][100];
    int repetidos = 0;

    // Ingreso de nombres para la Comisión 1
    printf("Ingrese los nombres de los alumnos para la Comision 1:\n");
    for (int i = 0; i < MAX_ALUMNOS; i++) {
        printf("Alumno %d: ", i + 1);
        scanf("%s", comision1[i]);
    }

    // Ingreso de nombres para la Comisión 2
    printf("Ingrese los nombres de los alumnos para la Comision 2:\n");
    for (int i = 0; i < MAX_ALUMNOS; i++) {
        printf("Alumno %d: ", i + 1);
        scanf("%s", comision2[i]);
    }

    // Comparación de los nombres en ambas comisiones
    printf("\nResultados de la comparación:\n");
    for (int i = 0; i < MAX_ALUMNOS; i++) {
        if (strcmp(comision1[i], comision2[i]) == 0) {
            printf("Alumno %d de Comisión 1 y Alumno %d de Comisión 2: %s (Son iguales)\n", i + 1, i + 1, comision1[i]);
            repetidos++;
        }
    }

    printf("\nCantidad de nombres repetidos: %d\n", repetidos);

    return 0;
}

