#include <stdio.h>
#include <stdlib.h>

typedef char *apuntadorC;

apuntadorC a1, a2;

int main() {
    a1 = (apuntadorC)malloc(sizeof(char));
    a2 = (apuntadorC)malloc(sizeof(char));
    *a1 = 'A';
    *a2 = 'B';
    printf("%c \n", *a1);
    printf("%c \n", *a2);
    
    free(a1);
    free(a2);

    return 0;
}


//En este código de conversión, las líneas a1 = (apuntadorC)malloc(sizeof(char));e a2 = (apuntadorC)malloc(sizeof(char));incluyen una limpieza para el tipo de puntero apuntadorCalrededor de las llamadas a malloc. Esto resuelve el problema de conversión incorrecta y debería permitirte compilar y ejecutar el código sin errores. Además, también se agregaron líneas para liberar la memoria apoyada con freeal final del programa para evitar fugas de memoria.
