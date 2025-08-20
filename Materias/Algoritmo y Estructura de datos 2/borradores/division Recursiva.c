#include <stdio.h>

int divisionRecursiva(int,int);

int main()
{
    int dividendo, divisor; // Declarar las variables para almacenar los valores ingresados por el usuario

    printf("Ingrese el dividendo: ");
    scanf("%d", &dividendo);
    
    printf("Ingrese el divisor: ");
    scanf("%d", &divisor);

    int resultado = divisionRecursiva(dividendo, divisor);
    printf("Resultado: %d\n", resultado);
    
    return 0;
}

int divisionRecursiva(int dividendo, int divisor)
{
    printf("divisionRecursiva(%d, %d);\n", dividendo, divisor);
    
    if (divisor > dividendo)
    {
        printf("resultado: %d\n", 0);
        return 0;
    }
    else
    {
        dividendo = dividendo - divisor;
        int resultado = 1 + divisionRecursiva(dividendo, divisor);
        printf("resultado: %d\n", resultado);
        return resultado;
    }
}

