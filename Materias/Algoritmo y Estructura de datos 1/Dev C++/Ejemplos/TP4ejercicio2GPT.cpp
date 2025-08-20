#include <stdio.h>

int main() {
    int partidos_jugados, partidos_ganados, puntos_obtenidos;
    float porcentaje_ganados;
    
    printf("Ingrese la cantidad de partidos jugados: ");
    scanf("%d", &partidos_jugados);
    
    printf("Ingrese la cantidad de partidos ganados: ");
    scanf("%d", &partidos_ganados);
    
    puntos_obtenidos = partidos_ganados * 3 + (partidos_jugados - partidos_ganados) * 1;
    porcentaje_ganados = (float)partidos_ganados / partidos_jugados * 100;
    
    printf("Porcentaje de partidos ganados: %.2f%%\n", porcentaje_ganados);
    printf("Puntos obtenidos en el campeonato: %d\n", puntos_obtenidos);
    
    return 0;
}

