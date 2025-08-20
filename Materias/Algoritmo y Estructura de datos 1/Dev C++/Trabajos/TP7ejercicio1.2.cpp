#include <stdio.h>

int vecEdad[5];
void inicializarVec();
void mostrarVec();
void cargarVec();
void mostrarVecotravez();
void detectarMyEdad();
void mostrarNotasMayoresAlPromedio();

int i, sumarVector, mayorEdad, mayorEdadi;
float prom;

int main() {
    inicializarVec();
    mostrarVec();
    cargarVec();
    mostrarVecotravez();
    detectarMyEdad();
    mostrarNotasMayoresAlPromedio();

    return 0;
}

void inicializarVec() {
    for (i = 0; i < 5; i++) {
        vecEdad[i] = 0;
    }
}

void mostrarVec() {
    for (i = 0; i < 5; i++) {
        printf("\nEl valor de la edad del alumno %d es: %d ", i + 1, vecEdad[i]);
    }
    printf("\n El vector esta inicializado en 0 \n");
}

void cargarVec() {
    for (i = 0; i < 5; i++) {
        printf("\ningrese la edad del alumno %d: ", i + 1);
        scanf("%d", &vecEdad[i]);
    }
}

void mostrarVecotravez() {
    for (i = 0; i < 5; i++) {
        printf("\nEl valor de la edad del alumno en la posicion %d es: %d : ", i + 1, vecEdad[i]);
    }
}

void detectarMyEdad() {
    mayorEdad = 0; //si se quisiera detectar el menor valor sería menorEdad = 99 y cambiaria en  el if
    for (i = 0; i < 5; i++) {
        if (vecEdad[i] > mayorEdad) {
            mayorEdad = vecEdad[i];
            mayorEdadi = i + 1;
        }
    }
    printf("\nLa mayor edad es: %d ", mayorEdad);
    printf("\nEn la posicion: %d ", mayorEdadi);
}

void mostrarNotasMayoresAlPromedio() {
    sumarVector = 0;
    for (i = 0; i < 5; i++) {
        sumarVector += vecEdad[i];
    }
    prom = sumarVector / 5.0;

    printf("\nNotas mayores al promedio (%.2f):\n", prom);
    for (i = 0; i < 5; i++) {
        if (vecEdad[i] > prom) {
            printf("Nota en la posicion %d: %d\n", i + 1, vecEdad[i]);
        }
    }
}

