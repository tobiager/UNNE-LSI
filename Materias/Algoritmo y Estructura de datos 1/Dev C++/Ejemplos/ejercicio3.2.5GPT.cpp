#include <stdio.h>

struct Jugador {
    int dni;
    char sexo;
    int edad;
    char categoria;
    int provincia;
};

int main() {
    Jugador jugadores[50];
    char continuar;
    int i = 0;

    do {
        printf("Ingrese los datos del jugador:\n");
        printf("DNI: ");
        scanf("%d", &jugadores[i].dni);
        printf("Sexo (M/F): ");
        scanf(" %c", &jugadores[i].sexo);
        printf("Edad: ");
        scanf("%d", &jugadores[i].edad);
        printf("Categoría (N-niños, C-cadetes): ");
        scanf(" %c", &jugadores[i].categoria);
        printf("Provincia de origen (1-Chaco, 2-Formosa, 3-Corrientes): ");
        scanf("%d", &jugadores[i].provincia);
        i++;

        printf("¿Desea ingresar más datos? (S/N): ");
        scanf(" %c", &continuar);
    } while (continuar == 'S' || continuar == 's');

    // Muestro DNI de mujeres cadetes de Corrientes o Chaco
    for (int j = 0; j < i; j++) {
        if (jugadores[j].sexo == 'F' && jugadores[j].categoria == 'C' &&
                (jugadores[j].provincia == 1 || jugadores[j].provincia == 3)) {
            printf("DNI de mujer cadete de Corrientes o Chaco: %d\n", jugadores[j].dni);
        }
    }

    // Calculo cantidad de varones entre 10 y 12 años de Formosa
    int cantidad_varones = 0;
    for (int j = 0; j < i; j++) {
        if (jugadores[j].sexo == 'M' && jugadores[j].edad >= 10 && jugadores[j].edad <= 12 &&
                jugadores[j].provincia == 2) {
            cantidad_varones++;
        }
    }
    printf("Cantidad de varones entre 10 y 12 años de Formosa: %d\n", cantidad_varones);

    return 0;
}

