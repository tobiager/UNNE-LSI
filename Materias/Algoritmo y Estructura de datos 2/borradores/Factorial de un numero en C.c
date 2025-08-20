#include <stdio.h>

int factorial(int n)
{
    if (n == 0 || n == 1) {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

int main()
{
    int n, res;
    
    printf("***********************************\n");
    printf("Factorial Recursion\n");
    printf("***********************************\n");
    
    printf("Ingrese un numero: ");
    scanf("%d", &n);
    
    if (n < 0) {
        printf("El factorial no está definido para números negativos.\n");
    } else {
        res = factorial(n);
        printf("El factorial de %d es: %d\n", n, res);
    }
    
    return 0;
}

