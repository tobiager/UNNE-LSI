#include <stdio.h>

int main() {
    int partidos_jugados, partidos_ganados;
    int partidos_empatados;
    float porcentaje_ganados;
    int puntos_conseguidos;
    
    printf("Ingrese la cantidad de partidos jugados: ");
    scanf("%d", &partidos_jugados);
    
    printf("Ingrese la cantidad de partidos ganados: ");
    scanf("%d", &partidos_ganados);
    
     printf("Ingrese la cantidad de partidos empatados: ");
    scanf("%d", &partidos_empatados);
    
    porcentaje_ganados = (float)partidos_ganados / partidos_jugados * 100;
     puntos_conseguidos = partidos_ganados * 3 + partidos_empatados * 1;
    
    printf("Porcentaje de partidos ganados: %.2f%%", porcentaje_ganados);
    printf("\nPuntos obtenidos en el campeonato: %d\n", puntos_conseguidos);
    
    return 0;
}

