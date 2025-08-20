#include <stdio.h>
#include <string.h>

#define SUCURSALES 6
#define RUBROS 7

const char* nombresSucursales[SUCURSALES] = {
    "Tucuman", "Maipu", "Irigoyen", "Paraguay", "Riachuelo", "Santa Ana"
};

const char* nombresRubros[RUBROS] = {
    "Pastas Frescos", "Lacteos", "Limpieza", "Art. en Latas", "Perfumeria", "Bebidas", "Verduleria"
};

void cargarMatriz(float matriz[][RUBROS]) {
    printf("Ingrese los montos vendidos en cada sucursal y rubro:\n");

    for (int i = 0; i < SUCURSALES; i++) {
        printf("\nSucursal %s:\n", nombresSucursales[i]);

        for (int j = 0; j < RUBROS; j++) {
            printf("%s: $", nombresRubros[j]);
            scanf("%f", &matriz[i][j]);
        }
    }
}

void imprimirMatriz(float matriz[][RUBROS]) {
    printf("\n\tMatriz de montos vendidos:\n");
    printf("\tSucursal\t");

    for (int j = 0; j < RUBROS; j++) {
        printf("%s\t", nombresRubros[j]);
    }

    printf("\n");

    for (int i = 0; i < SUCURSALES; i++) {
        printf("%s\t", nombresSucursales[i]);

        for (int j = 0; j < RUBROS; j++) {
            printf("%.2f\t", matriz[i][j]);
        }

        printf("\n");
    }
}

void calcularTotalVentasSucursal(float matriz[][RUBROS]) {
    float totalVentas = 0.0;
    int sucursalMaxVentas = 0;
    float maxVentas = 0.0;

    for (int i = 0; i < SUCURSALES; i++) {
        float totalSucursal = 0.0;

        for (int j = 0; j < RUBROS; j++) {
            totalSucursal += matriz[i][j];
        }

        if (totalSucursal > maxVentas) {
            maxVentas = totalSucursal;
            sucursalMaxVentas = i;
        }

        totalVentas += totalSucursal;
    }

    printf("\nLa sucursal con el mayor total de ventas es: %s (Sucursal %d)\n", nombresSucursales[sucursalMaxVentas], sucursalMaxVentas);
}

void calcularTotalesPorRubro(float matriz[][RUBROS]) {
    float totales[RUBROS] = {0.0};

    for (int j = 0; j < RUBROS; j++) {
        for (int i = 0; i < SUCURSALES; i++) {
            totales[j] += matriz[i][j];
        }
    }

    printf("\nTotales por rubro:\n");

    for (int j = 0; j < RUBROS; j++) {
        printf("%s: %.2f\n", nombresRubros[j], totales[j]);
    }
}

void calcularPorcentajePerfumeria(float matriz[][RUBROS]) {
    float totalPerfumeria = 0.0;
    float totalOtrosRubros = 0.0;

    for (int i = 0; i < SUCURSALES; i++) {
        totalPerfumeria += matriz[i][4]; // Índice 4 representa el rubro "Perfumería"

        for (int j = 0; j < RUBROS; j++) {
            if (j != 4) { // Excluye el rubro "Perfumería"
                totalOtrosRubros += matriz[i][j];
            }
        }
    }

    float porcentaje = (totalPerfumeria / totalOtrosRubros) * 100;

    printf("\nPorcentaje del monto vendido en Perfumería respecto al total de los otros rubros: %.2f%%\n", porcentaje);
}

int main() {
    float matriz[SUCURSALES][RUBROS];

    cargarMatriz(matriz);
    imprimirMatriz(matriz);
    calcularTotalVentasSucursal(matriz);
    calcularTotalesPorRubro(matriz);
    calcularPorcentajePerfumeria(matriz);

    return 0;
}

