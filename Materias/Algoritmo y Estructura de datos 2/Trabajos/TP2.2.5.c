#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Estructura para representar un documento
typedef struct {
    char ipPC[20];
    char nombreDocumento[100];
    int tipoDocumento; // 01: docx, 02: pdf, 03: jpg, 04: png, 05: xlsx
    double tamanoBytes;
} Documento;

// Estructura para representar un nodo de la cola
typedef struct Nodo {
    Documento documento;
    struct Nodo* siguiente;
} Nodo;

// Función para crear un nuevo nodo
Nodo* crearNodo(Documento documento) {
    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    nuevoNodo->documento = documento;
    nuevoNodo->siguiente = NULL;
    return nuevoNodo;
}

// Función para encolar un documento
void enqueue(Nodo** cola, Documento documento) {
    Nodo* nuevoNodo = crearNodo(documento);
    if (*cola == NULL) {
        *cola = nuevoNodo;
    } else {
        Nodo* actual = *cola;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
    }
}

// Función para desencolar un documento
bool dequeue(Nodo** cola) {
    if (*cola == NULL) {
        return false; // La cola está vacía
    } else {
        Nodo* temp = *cola;
        *cola = (*cola)->siguiente;
        free(temp);
        return true;
    }
}

// Función para contar la cantidad de documentos de formato de imágenes en cola
int contarDocumentosImagen(Nodo* cola) {
    int contador = 0;
    Nodo* actual = cola;
    while (actual != NULL) {
        if (actual->documento.tipoDocumento == 03 || actual->documento.tipoDocumento == 04) {
            contador++;
        }
        actual = actual->siguiente;
    }
    return contador;
}

// Función para calcular el tamaño total de documentos en cola (en megabytes)
double calcularTamanoTotal(Nodo* cola) {
    double tamanoTotal = 0.0;
    Nodo* actual = cola;
    while (actual != NULL) {
        tamanoTotal += actual->documento.tamanoBytes;
        actual = actual->siguiente;
    }
    // Convertir bytes a megabytes
    return tamanoTotal / (1024 * 1024);
}

// Función para mostrar el próximo documento a ser impreso
void mostrarProximoDocumento(Nodo* cola) {
    if (cola != NULL) {
        printf("=== Proximo Documento a Ser Impreso ===\n");
        printf("IP de la PC: %s\n", cola->documento.ipPC);
        printf("Nombre del Documento: %s\n", cola->documento.nombreDocumento);
        printf("Tipo de Documento: ");
        switch (cola->documento.tipoDocumento) {
            case 01: printf("docx\n"); break;
            case 02: printf("pdf\n"); break;
            case 03: printf("jpg\n"); break;
            case 04: printf("png\n"); break;
            case 05: printf("xlsx\n"); break;
            default: printf("Desconocido\n"); break;
        }
        printf("Tamaño en Megabytes: %.2lf MB\n", cola->documento.tamanoBytes / (1024 * 1024));
        printf("=======================================\n");
    } else {
        printf("No hay documentos en cola de impresión.\n");
    }
}

int main() {
    Nodo* cola = NULL;
    int opcion;

    do {
        printf("=== Menú de Operaciones ===\n");
        printf("1. Registrar documento\n");
        printf("2. Contar documentos de formato de imagenes en cola\n");
        printf("3. Calcular tamaño total de documentos en cola (MB)\n");
        printf("4. Mostrar proximo documento a ser impreso\n");
        printf("5. Salir\n");
        printf("===========================\n");
        printf("Seleccione una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                Documento nuevoDocumento;
                printf("Ingrese la IP de la PC que envia el documento: ");
                scanf(" %[^\n]", nuevoDocumento.ipPC);
                printf("Ingrese el nombre del documento: ");
                scanf(" %[^\n]", nuevoDocumento.nombreDocumento);
                printf("Ingrese el tipo de documento (01: docx, 02: pdf, 03: jpg, 04: png, 05: xlsx): ");
                scanf("%d", &nuevoDocumento.tipoDocumento);
                printf("Ingrese el tamaño en bytes: ");
                scanf("%lf", &nuevoDocumento.tamanoBytes);
                enqueue(&cola, nuevoDocumento);
                printf("Documento registrado con exito.\n");
                break;
            }
            case 2: {
                int cantidadImagenes = contarDocumentosImagen(cola);
                printf("Cantidad de documentos de formato de imagenes en cola: %d\n", cantidadImagenes);
                break;
            }
            case 3: {
                double tamanoTotal = calcularTamanoTotal(cola);
                printf("Tamaño total de documentos en cola (MB): %.2lf MB\n", tamanoTotal);
                break;
            }
            case 4: {
                mostrarProximoDocumento(cola);
                break;
            }
            case 5: {
                printf("Saliendo del programa.\n");
                break;
            }
            default: {
                printf("Opcion no valida. Intente de nuevo.\n");
                break;
            }
        }
    } while (opcion != 5);

    // Liberar memoria de la cola antes de salir
    free (cola);

    return 0;
}

