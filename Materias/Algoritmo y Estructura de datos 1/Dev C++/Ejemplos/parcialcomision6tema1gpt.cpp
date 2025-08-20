#include <stdio.h>

#define TITULO "Tienda de mascotas - Servicios del dia"

// Declaración de funciones
void inicializarVariables();
void ingresarDatos();
void procesarServicio();
void contarServicios();
void contarTotalFacturado();
void mostrarInforme();

// Variables globales
int tipoServicio;
int cantServicio;
int numeroAtencion;
float importeFacturado, importeTotal, totalFacturado;
char respuesta;

int main() {

    inicializarVariables();

    do {
        ingresarDatos();
        procesarServicio();
        contarServicios();
        contarTotalFacturado();
        printf("\nDesea cargar datos de vacunacion? s/n: ");
        fflush(stdin);
        scanf("%c", &respuesta);
    } while(respuesta == 's');

    mostrarInforme();

    return 0;
}

void inicializarVariables() {
    tipoServicio = 0;
    cantServicio = 0;
    numeroAtencion = 0;
    importeTotal = 0;
}

void ingresarDatos() {
    printf("Ingrese numero de atencion: ");
    scanf("%d", &numeroAtencion);
    printf("Ingrese tipo de servicio (1-Venta de alimentos / 2-Atencion a mascotas): ");
    scanf("%d", &tipoServicio);
    printf("Ingrese importe facturado: ");
    scanf("%f", &importeFacturado);
}

void procesarServicio() {
    if(tipoServicio == 2) {
        printf("*** Nro de atencion %d recibió atencion del veterinario! ***\n", numeroAtencion);
    }
}

void contarServicios() {
    cantServicio++;
}

void contarTotalFacturado() {
    importeTotal += importeFacturado;
    totalFacturado = importeTotal;
}

void mostrarInforme() {
    printf("%s\n", TITULO);
    printf("Cantidad de servicios prestados en el día: %d\n", cantServicio);
    printf("Importe total facturado: $%.2f\n", totalFacturado);
    printf("Monto promedio de facturación: $%.2f\n", totalFacturado / cantServicio);
}

