#include <stdio.h>

int main() {
    int n = 10; // número de alumnos
    int aprobados = 0; // número de alumnos aprobados
    float nota, suma = 0.0, promedio; // nota de cada alumno, suma de notas y promedio
    
    for (int i = 1; i <= n; i++) {
        printf("Ingrese la nota del alumno %d: ", i);
        scanf("%f", &nota);
        if (nota >= 6.0) { // si la nota es mayor o igual a 6, el alumno aprobó
            aprobados++;
            suma += nota;
        }
    }
    
    if (aprobados == 0) {
        printf("Ningun alumno aprobó el examen.");
    } else {
        promedio = suma / aprobados;
        printf("El promedio general de los examenes aprobados es: %.2f", promedio);
    }
    
    return 0;
}

