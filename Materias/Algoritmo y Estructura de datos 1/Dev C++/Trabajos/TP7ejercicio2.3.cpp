#include <stdio.h>
#include <string.h>

#define TIPOS_ACEITE 5
#define VALORACIONES 3
#define MAX_LONGITUD 20

void ingresarOpiniones(int opiniones[][VALORACIONES], char tiposAceite[][MAX_LONGITUD]) {
    printf("Ingrese las opiniones del consumidor. Para finalizar, ingrese 'fin' como tipo de aceite.\n");

    char tipoAceite[MAX_LONGITUD];
    char valoracion[MAX_LONGITUD];

    while (1) {
        printf("Tipo de aceite: ");
        scanf("%s", tipoAceite);

        if (strcmp(tipoAceite, "fin") == 0) {
            break;
        }

        printf("Valoracion (excelente, buena, mala): ");
        scanf("%s", valoracion);

        int tipo = -1;
        for (int i = 0; i < TIPOS_ACEITE; i++) {
            if (strcmp(tiposAceite[i], tipoAceite) == 0) {
                tipo = i;
                break;
            }
        }

        if (tipo != -1) {
            if (strcmp(valoracion, "excelente") == 0) {
                opiniones[tipo][0]++;
            } else if (strcmp(valoracion, "buena") == 0) {
                opiniones[tipo][1]++;
            } else if (strcmp(valoracion, "mala") == 0) {
                opiniones[tipo][2]++;
            }
        }
    }
}

void obtenerMaxValoraciones(const int opiniones[][VALORACIONES], const char tiposAceite[][MAX_LONGITUD], int& maxExcelente, int& maxMala, char tipoExcelente[MAX_LONGITUD], char tipoMala[MAX_LONGITUD]) {
    maxExcelente = 0;
    maxMala = 0;

    for (int i = 0; i < TIPOS_ACEITE; i++) {
        if (opiniones[i][0] > maxExcelente) {
            maxExcelente = opiniones[i][0];
            strcpy(tipoExcelente, tiposAceite[i]);
        }

        if (opiniones[i][2] > maxMala) {
            maxMala = opiniones[i][2];
            strcpy(tipoMala, tiposAceite[i]);
        }
    }
}

int main() {
    char tiposAceite[TIPOS_ACEITE][MAX_LONGITUD] = {
        "Aceite A",
        "Aceite B",
        "Aceite C",
        "Aceite D",
        "Aceite E"
    };

    int opiniones[TIPOS_ACEITE][VALORACIONES] = {0};

    ingresarOpiniones(opiniones, tiposAceite);

    int maxExcelente, maxMala;
    char tipoExcelente[MAX_LONGITUD], tipoMala[MAX_LONGITUD];

    obtenerMaxValoraciones(opiniones, tiposAceite, maxExcelente, maxMala, tipoExcelente, tipoMala);

    printf("\nTipo de aceite con mayor cantidad de valoración 'Excelente': %s (Cantidad: %d)\n", tipoExcelente, maxExcelente);
    printf("Tipo de aceite con mayor cantidad de valoración 'Mala': %s (Cantidad: %d)\n", tipoMala, maxMala);

    return 0;
}

