#include <stdio.h>
#include <string.h>

const int NUM_FILAS = 6;
const int NUM_COLUMNAS = 12;

void obtenerMaximaVenta(float matrizVentas[NUM_FILAS][NUM_COLUMNAS], float& maxVenta, int& filaMaxVenta);

int main() {
    float matrizVentas[NUM_FILAS][NUM_COLUMNAS];
    
    // Ingresar los montos de venta por teclado
    for (int fila = 0; fila < NUM_FILAS; ++fila) {
        printf("Sucursal %d:\n", fila + 1);
        for (int columna = 0; columna < NUM_COLUMNAS; ++columna) {
            printf("Ingrese el monto de venta para el mes %d: ", columna + 1);
            scanf("%f", &matrizVentas[fila][columna]);
        }
        printf("\n");
    }
    
    // Obtener el máximo monto de venta y la sucursal correspondiente
    float maxVenta;
    int filaMaxVenta;
    obtenerMaximaVenta(matrizVentas, maxVenta, filaMaxVenta);
    
    printf("El máximo monto de venta es %.2f y corresponde a la sucursal %d.\n", maxVenta, filaMaxVenta + 1);
    
    return 0;
}

void obtenerMaximaVenta(float matrizVentas[NUM_FILAS][NUM_COLUMNAS], float& maxVenta, int& filaMaxVenta) {
    maxVenta = matrizVentas[0][0];
    filaMaxVenta = 0;
    
    for (int fila = 0; fila < NUM_FILAS; ++fila) {
        for (int columna = 0; columna < NUM_COLUMNAS; ++columna) {
            if (matrizVentas[fila][columna] > maxVenta) {
                maxVenta = matrizVentas[fila][columna];
                filaMaxVenta = fila;
            }
        }
    }
}


