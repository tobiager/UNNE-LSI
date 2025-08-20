#include <stdio.h>

#define DIAS_ENERO 31

int main() {
    int pasajeros[DIAS_ENERO];
    int totalPasajeros = 0;
    int maxPasajeros = 0;
    int diaMaxPasajeros = 0;

    printf("Ingrese la cantidad de pasajeros para cada dia del mes de enero:\n");
    for (int i = 0; i < DIAS_ENERO; i++) {
        printf("Dia %d: ", i + 1);
        scanf("%d", &pasajeros[i]);

        totalPasajeros += pasajeros[i];

        if (pasajeros[i] > maxPasajeros) {
            maxPasajeros = pasajeros[i];
            diaMaxPasajeros = i + 1;
        }
    }

    float promedioPasajeros = static_cast<float>(totalPasajeros) / DIAS_ENERO;

    printf("\nPromedio de pasajeros en enero: %.2f\n", promedioPasajeros);
    printf("Mayor cantidad de pasajeros en un vuelo: %d (Dia %d)\n", maxPasajeros, diaMaxPasajeros);

    return 0;
}

