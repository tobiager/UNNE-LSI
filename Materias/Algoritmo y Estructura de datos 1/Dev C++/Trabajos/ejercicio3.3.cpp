#include <stdio.h>

float calcularIMC(float peso, float altura) {
    float altura_metros = altura / 100; // Convertir altura de cm a m
    float imc = peso / (altura_metros * altura_metros); // Calcular IMC
    return imc;
}

int main() {
    float peso, altura;
    printf("Ingrese su peso en kg: ");
    scanf("%f", &peso);
    printf("Ingrese su altura en cm: ");
    scanf("%f", &altura);
    float imc = calcularIMC(peso, altura);
    printf("Su indice de masa corporal es: %.2f\n", imc);
    return 0;
}

