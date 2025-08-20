// Tobias Naim Orban  DNI: 46385637
// xxxxxx xxxx xxxxx  xxx  xxxxxxxx/
#include <stdio.h>

void calcularPorcentaje(int total, int cantidad, float& resultado) {
    resultado = (float)cantidad / (float)total * 100;
}

int main() {
    int dni, edad, tipoVacuna, nroDosis, lugarVacunacion;
    int cantidadAntigripal = 0, cantidadCovid = 0, cantidadCovidQuintaDosisMenores = 0;
    float porcentajeCovidQuintaDosisMenores = 0.0;
    bool continuar = true;
    
    while (continuar) {
        printf("Ingrese el DNI (0 para terminar): ");
        scanf("%d", &dni);
        if (dni == 0) {
            continuar = false;
        } else {
            printf("Ingrese la edad: ");
            scanf("%d", &edad);
            printf("Ingrese el tipo de vacuna (1 - Covid, 2 - Antigripal): ");
            scanf("%d", &tipoVacuna);
            printf("Ingrese el numero de dosis: ");
            scanf("%d", &nroDosis);
            printf("Ingrese el lugar de vacunacion (1 - Morgue, 2 - Facultad de Medicina): ");
            scanf("%d", &lugarVacunacion);
            
            if (tipoVacuna == 2) {
                printf("*** Antigripal - DNI: %d Edad: %d Lugar: %s ***\n", dni, edad, (lugarVacunacion == 1 ? "Morgue" : "Facultad de Medicina"));
                cantidadAntigripal++;
            } else {
                cantidadCovid++;
                if (nroDosis == 5 && edad < 18) {
                    cantidadCovidQuintaDosisMenores++;
                }
            }
        }
    }
    
    calcularPorcentaje(cantidadCovid, cantidadCovidQuintaDosisMenores, porcentajeCovidQuintaDosisMenores);
    
    printf("\nCampa%ca de Vacunacion de Corrientes\n",164 );
    printf("Cantidad vacunados antigripal: %d\n", cantidadAntigripal);
    printf("Cantidad de vacunados Covid con quinta dosis menores de edad: %d\n", cantidadCovidQuintaDosisMenores);
    printf("Porcentaje con quinta dosis menores de edad sobre total de vacunados Covid: %.2f%%\n", porcentajeCovidQuintaDosisMenores);
    
    return 0;
}

