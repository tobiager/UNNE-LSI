#include <stdio.h>

int main() {
    const int num_alumnos = 96;
    int num_notas;
    float nota, suma_notas = 0, promedio;

    printf("Ingrese la cantidad de notas a procesar: ");
    scanf("%d", &num_notas);

    for (int i = 1; i <= num_notas; i++) {
        printf("Ingrese la nota del alumno %d: ", i);
        scanf("%f", &nota);
        if (nota >= 4.0) {
            suma_notas += nota;
        }
    }

    promedio = suma_notas / num_notas;
    printf("El promedio general de los examenes aprobados es: %.2f", promedio);

    return 0;
}

