#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructura para representar un nodo de la lista
struct Nodo {
    char sexo;
    char edad[100];
    float peso;
    float altura;
    char clasificacionIMC[20];
    struct Nodo* siguiente;
};

// Función para calcular el IMC y la clasificación correspondiente
void calcularIMC(struct Nodo* nodo) {
    float imc = nodo->peso / (nodo->altura * nodo->altura);

    if (imc < 18.5)
        strcpy(nodo->clasificacionIMC, "Bajo peso");
    else if (imc < 24.9)
        strcpy(nodo->clasificacionIMC, "Normal");
    else if (imc < 29.9)
        strcpy(nodo->clasificacionIMC, "Sobrepeso");
    else
        strcpy(nodo->clasificacionIMC, "Obeso");
}

// Función para insertar un nuevo nodo al inicio de la lista
void insertarAlInicio(struct Nodo** cabeza, char sexo, char edad[100], float peso, float altura) {
    struct Nodo* nuevoNodo = (struct Nodo*)malloc(sizeof(struct Nodo));
    
    nuevoNodo->sexo = sexo;
    strcpy(nuevoNodo->edad, edad);
    nuevoNodo->peso = peso;
    nuevoNodo->altura = altura;
    nuevoNodo->siguiente = *cabeza;

    calcularIMC(nuevoNodo); // Calcular el IMC antes de insertar
    
    *cabeza = nuevoNodo;
}

// Función para imprimir la lista
void imprimirLista(struct Nodo* cabeza) {
    struct Nodo* actual = cabeza;
    
    while (actual != NULL) {
        printf("Sexo: %c\n", actual->sexo);
        printf("Edad: %s\n", actual->edad);
        printf("Peso: %.2f\n", actual->peso);
        printf("Altura: %.2f\n", actual->altura);
        printf("Clasificacion IMC: %s\n", actual->clasificacionIMC);
        printf("-----------------\n");
        actual = actual->siguiente;
    }
}

int main() {
    struct Nodo* cabeza = NULL;
    char sexo, edad[100];
    float peso, altura;
    
    int numEncuestados;
    printf("Ingrese el numero de encuestados: ");
    scanf("%d", &numEncuestados);
    
    int i; // Mover la declaración de la variable i fuera del bucle
    for (i = 0; i < numEncuestados; i++) {
        printf("Encuestado #%d\n", i + 1);
        printf("Sexo (F/M): ");
        scanf(" %c", &sexo);
        printf("Edad: ");
        scanf(" %s", edad);
        printf("Peso (kg): ");
        scanf("%f", &peso);
        printf("Altura (m): ");
        scanf("%f", &altura);
        
        insertarAlInicio(&cabeza, sexo, edad, peso, altura);
    }
    
    printf("\n--- Datos de Encuestados ---\n");
    imprimirLista(cabeza);
    
    return 0;
}

