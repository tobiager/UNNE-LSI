#include <stdio.h>

int main() {
    char respuesta;
    int dni, edad, provincia, cantidad_varones_formosa = 0;
    char sexo, categoria;

    do {
        printf("Ingrese DNI: ");
        scanf("%d", &dni);
        printf("Ingrese sexo (M-Masculino/F-Femenino): ");
        scanf(" %c", &sexo);
        printf("Ingrese edad: ");
        scanf("%d", &edad);
        printf("Ingrese categoria (N-Ni%Cos/C-Cadetes): ",164);
        scanf(" %c", &categoria);
        printf("Ingrese provincia de origen (1-Chaco, 2-Formosa, 3-Corrientes): ");
        scanf("%d", &provincia);

        if (sexo == 'F' && categoria == 'C' && (provincia == 1 || provincia == 3)) {
            printf("Mujer cadete de Corrientes o del Chaco: %d\n", dni);
        }

        if (sexo == 'M' && categoria == 'N' && provincia == 2 && edad >= 10 && edad <= 12) {
            cantidad_varones_formosa++;
        }

        printf("Desea ingresar mas datos? (S/N): ");
        scanf(" %c", &respuesta);
    } while (respuesta == 'S');

    printf("Cantidad de varones entre 10 y 12 a%cos de Formosa: %d\n", 164,cantidad_varones_formosa);

    return 0;
}


