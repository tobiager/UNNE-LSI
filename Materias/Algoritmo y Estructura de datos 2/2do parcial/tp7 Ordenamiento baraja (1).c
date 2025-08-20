#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define N 5

typedef int tVector[N];

void cargarVector();
void ordenamientoInsercion(tVector);
void mostrarVector(tVector);

tVector vector;

int main()
{
    cargarVector();
    ordenamientoInsercion(vector);
    mostrarVector(vector);

    return 0;
}

void cargarVector()
{
    int i;
    printf("Ingrese los numeros que desea ordenar:\t");
    for (i = 0; i < N; i++)
    {
        scanf("%d", &vector[i]);
    }
}

void ordenamientoInsercion(tVector pVector)
{
    int i, j, aux;//aux para ordenar el elemento
    for (i = 1; i < N; i++)//se recorre el vector
    {
        aux = pVector[i];//se guarda el valor del elemento actual en aux
        j = i - 1;

        while ((j >= 0) && (pVector[j] > aux))//bucle interno se ejecuta mientras j sea mayor o igual a cero y el elemento en la posición jsea mayor que aux.
        {
            pVector[j + 1] = pVector[j];//se desplaza j hacia la derecha
            j = j - 1;//Se disminuye el valor de j.
        }

        pVector[j + 1] = aux;//La posición j + 1 es la posición correcta para insertar el elemento aux.
    }
}

void mostrarVector(tVector pVector)
{
    int i;

    printf("Numeros ordenados de menor a mayor: \t");
    for (i = 0; i < N; i++)//recorre el primer elemento hasta el ultimo e i va desde 0 hasta N-1
    {
        printf(" %d ", vector[i]);
    }

    printf("\nNumeros ordenados de mayor a menor: \t");//recorre el ultimo elemento hasta el primero e i va desde N hasta 0
    for (i = N - 1; i >= 0; i--)
    {
        printf(" %d ", vector[i]);
    }
}

