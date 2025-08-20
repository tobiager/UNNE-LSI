#include <stdio.h>

int main() {
    int N, i, sum = 0, count = 0, p;
    const int MAX = 20; // Constante para el valor 20

    // Mostrar los números enteros desde 1 hasta N, sumarlos e informar la suma
    printf("Ingrese un numero entero positivo: ");
    scanf("%d", &N);

    for (i = 1; i <= N; i++) {
        printf("%d ", i);
        sum += i;
    }
    printf("\nLa suma de los numeros enteros del 1 al %d es: %d\n", N, sum);

    // Calcular e informar el promedio de los números impares menores o iguales a 20
    for (i = 1; i <= MAX; i += 2) {
        count++;
        sum += i;
    }
    printf("El promedio de los numeros impares menores o iguales a %d es: %.2f\n", MAX, (float)sum / count);

    // Generar y mostrar la tabla de multiplicar de un número introducido en un cuadro
    printf("Ingrese un numero entero para generar su tabla de multiplicar: ");
    scanf("%d", &p);

    printf("\nTabla de multiplicar de %d:\n", p);
    printf("+------------+\n"); // Imprimir la línea superior del cuadro

    for (i = 1; i <= 10; i++) {
        printf("| %2d x %2d = %3d |\n", p, i, p * i);
    }

    printf("+------------+\n"); // Imprimir la línea inferior del cuadro

    return 0;
}

