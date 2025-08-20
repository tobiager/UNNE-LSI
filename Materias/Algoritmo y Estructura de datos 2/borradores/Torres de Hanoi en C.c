#include <stdio.h>

void hanoi(int num, char origen, char destino, char auxiliar)
{
    if (num == 1)
    {
        printf("Mueva el bloque %d desde %c hasta %c\n", num, origen, destino);
    }
    else
    {
        hanoi(num - 1, origen, auxiliar, destino);
        printf("Mueva el bloque %d desde %c hasta %c\n", num, origen, destino);
        hanoi(num - 1, auxiliar, destino, origen);
    }
}

int main()
{
    int n;
    char A = 'A', B = 'B', C = 'C';

    printf("Las clavijas son A B C\n");
    printf("Numero de discos: ");
    scanf("%d", &n);

    hanoi(n, A, C, B);

    return 0;
}

