#include <stdio.h>

bool esTerminacionPar(int terminacion) {
    return (terminacion % 2 == 0);
}

int main() {
    int terminacion, dia;
    printf("Ingrese la terminacion del DNI: ");
    scanf("%d", &terminacion);
    printf("Ingrese el dia de la semana (1-Lunes 2-Martes 3-Miercoles 4-Jueves 5-Viernes 6-Sabado 7-Domingo): ");
    scanf("%d", &dia);
    if (dia == 7) {
        printf("No autorizado\n");
    } else if ((esTerminacionPar(terminacion) && (dia == 1 || dia == 3 || dia == 5)) || (!esTerminacionPar(terminacion) && (dia == 2 || dia == 4 || dia == 6))) {
        printf("Autorizado\n");
    } else {
        printf("No autorizado\n");
    }
    printf("Dia de la semana: %d\n", dia);
    printf("Terminacion del DNI: %d\n", terminacion);
    return 0;
}

