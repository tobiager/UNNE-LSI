#include <stdio.h>

int main() {
    float temp;
    printf("Ingrese la temperatura: ");
    scanf("%f", &temp);

    if (temp >= -10 && temp < 10) {
        printf("Sensacion termica: Mucho frio\n");
    } else if (temp >= 10 && temp < 15) {
        printf("Sensacion termica: Poco frio\n");
    } else if (temp >= 15 && temp < 25) {
        printf("Sensacion termica: Temperatura normal\n");
    } else if (temp >= 25 && temp < 30) {
        printf("Sensacion termica: Poco calor\n");
    } else if (temp >= 30 && temp < 45) {
        printf("Sensacion termica: Mucho calor\n");
    } else if (temp >= 45 && temp < 10000000) {
        printf("Sensacion termica: calor solar\n");
	} else {
        printf("Valor de temperatura fuera de rango\n");
    }

    return 0;
}

