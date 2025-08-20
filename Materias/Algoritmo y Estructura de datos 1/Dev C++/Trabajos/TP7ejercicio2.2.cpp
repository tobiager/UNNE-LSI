#include <stdio.h>

#define SUCURSALES 6
#define MESES 12

void ingresarVentas(int ventas[][MESES]) {
    printf("Ingrese el importe vendido para cada sucursal y mes del año 2019:\n");
    for (int i = 0; i < SUCURSALES; i++) {
        for (int j = 0; j < MESES; j++) {
            printf("Sucursal %d, Mes %d: $", i + 1, j + 1);
            scanf("%d", &ventas[i][j]);
        }
    }
}

void mostrarVentas(const int ventas[][MESES]) {
    printf("\nDatos de la matriz de ventas:\n");
    for (int i = 0; i < SUCURSALES; i++) {
        printf("Sucursal %d: ", i + 1);
        for (int j = 0; j < MESES; j++) {
            printf("%d ", ventas[i][j]);
        }
        printf("\n");
    }
}

void generarVentaAnual(const int ventas[][MESES], int ventaAnual[]) {
    for (int i = 0; i < SUCURSALES; i++) {
        int sumaMensual = 0;
        for (int j = 0; j < MESES; j++) {
            sumaMensual += ventas[i][j];
        }
        ventaAnual[i] = sumaMensual;
    }
}

void mostrarVentaAnual(const int ventaAnual[]) {
    printf("\nVenta anual de cada sucursal:\n");
    for (int i = 0; i < SUCURSALES; i++) {
        printf("Sucursal %d: $%d\n", i + 1, ventaAnual[i]);
    }
}

int main() {
    int ventas[SUCURSALES][MESES];
    int ventaAnual[SUCURSALES];

    ingresarVentas(ventas);
    mostrarVentas(ventas);

    generarVentaAnual(ventas, ventaAnual);
    mostrarVentaAnual(ventaAnual);

    return 0;
}

