#include <stdio.h>

int main() {
    int N, i, sum = 0, count = 0, p;
    const int MAX = 20; // Constante para el valor 20

    // Mostrar los n�meros enteros desde 1 hasta N, sumarlos e informar la suma
    printf("Ingrese un numero entero positivo: ");
    scanf("%d", &N);

    for (i = 1; i <= N; i++) {
        printf("%d ", i);
        sum += i;
    }
    printf("\nLa suma de los numeros enteros del 1 al %d es: %d\n", N, sum);

    // Calcular e informar el promedio de los n�meros impares menores o iguales a 20
    for (i = 1; i <= MAX; i += 2) {
        count++;
        sum += i;
    }
    printf("El promedio de los numeros impares menores o iguales a %d es: %.2f\n", MAX, (float)sum / count);

    // Generar y mostrar la tabla de multiplicar de un n�mero introducido
    printf("Ingrese un numero entero para generar su tabla de multiplicar: ");
    scanf("%d", &p);

    for (i = 1; i <= 10; i++) {
        printf("%d x %d = %d\n", p, i, p * i);
    }

    return 0;
}

