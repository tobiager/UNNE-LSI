#include <stdio.h>

#define MAX_DISCOS 12

struct PilaDiscos {
    int discos[MAX_DISCOS];
    int tope;
};

void inicializarPila(PilaDiscos& pila) {
    pila.tope = -1;
}

bool pilaVacia(const PilaDiscos& pila) {
    return (pila.tope == -1);
}

bool pilaLlena(const PilaDiscos& pila) {
    return (pila.tope == MAX_DISCOS - 1);
}

void push(PilaDiscos& pila, int peso) {
    if (pilaLlena(pila)) {
        printf("La pila esta llena. No se puede agregar mas discos.\n");
        return;
    }
    pila.discos[++pila.tope] = peso;
}

void pop(PilaDiscos& pila) {
    if (pilaVacia(pila)) {
        printf("La pila esta vacía. No se puede quitar ningun disco.\n");
        return;
    }
    pila.tope--;
}

int topePila(const PilaDiscos& pila) {
    if (pilaVacia(pila)) {
        printf("La pila esta vacía. No hay discos en el tope.\n");
        return -1;
    }
    return pila.discos[pila.tope];
}

void listarDiscos(const PilaDiscos& pila) {
    if (pilaVacia(pila)) {
        printf("La pila esta vacía. No hay discos para listar.\n");
        return;
    }
    printf("Discos apilados:\n");
    for (int i = pila.tope; i >= 0; i--) {
        printf("%d Kg\n", pila.discos[i]);
    }
}

int cantidadDiscos(const PilaDiscos& pila) {
    return pila.tope + 1;
}

float calcularPromedio(const PilaDiscos& pila) {
    if (pilaVacia(pila)) {
        printf("La pila esta vacía. No se puede calcular el promedio.\n");
        return 0.0f;
    }
    int suma = 0;
    for (int i = 0; i <= pila.tope; i++) {
        suma += pila.discos[i];
    }
    return static_cast<float>(suma) / (pila.tope + 1);
}

int main() {
    PilaDiscos pila;
    inicializarPila(pila);
    int opcion, peso;

    do {
        printf("\n----- Menú -----\n");
        printf("1. Cargar disco\n");
        printf("2. Listar discos\n");
        printf("3. Quitar disco\n");
        printf("4. Disco en el tope\n");
        printf("5. Cantidad de discos\n");
        printf("6. Calcular promedio de pesos\n");
        printf("0. Salir\n");
        printf("Ingrese una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 0:
                printf("Saliendo del programa...\n");
                break;
            case 1:
                printf("Ingrese el peso del disco (entre 10 y 100 Kg): ");
                scanf("%d", &peso);
                if (peso >= 10 && peso <= 100) {                    push(pila, peso);
                    printf("Disco agregado a la pila.\n");
                } else {
                    printf("El peso ingresado no esta dentro del rango permitido.\n");
                }
                break;
            case 2:
                listarDiscos(pila);
                break;
            case 3:
                pop(pila);
                printf("Disco quitado de la pila.\n");
                break;
            case 4:
                peso = topePila(pila);
                if (peso != -1) {
                    printf("El disco en el tope de la pila pesa %d Kg.\n", peso);
                }
                break;
            case 5:
                printf("Cantidad de discos apilados: %d\n", cantidadDiscos(pila));
                break;
            case 6:
                printf("Promedio de pesos de los discos en la pila: %.2f Kg\n", calcularPromedio(pila));
                break;
            default:
                printf("Opción invalida. Por favor, ingrese una opción valida.\n");
                break;
        }
    } while (opcion != 0);

    return 0;
}

                   


