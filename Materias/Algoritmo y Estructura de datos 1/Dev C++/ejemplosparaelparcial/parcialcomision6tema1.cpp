/*
Una tienda de mascotas necesita un programa que permita ingresar datos relacionados a los servicios
proporcionados en el día y que emita información relacionada.
El sistema debe permitir el ingreso por teclado de los datos: número de atención, código de tipo de servicio
(1-venta de alimentos, 2-atención a mascotas), importe facturado. Se requiere:
- Cada vez que se ingresan los datos evaluar la condición y mostrar, si corresponde:
o En caso de que se trate de un servicio de atención a mascotas, se debe emitir un mensaje que
indique que recibió atención del veterinario. Ejemplo de salida en pantalla:
*** Nro de atención 12345 Recibió atención del veterinario! ***
- Al finalizar la carga de datos, mostrar la siguiente información, según formato de informe final:
o Informar la cantidad de servicios prestados en el día.
o Informar el importe total facturado y el monto promedio de facturación por servicio.
El programa debe permitir cargar datos de los servicios hasta que el usuario indique que no hay más datos
para cargar
*/

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
        printf("*** Nro de atencion %d recibio atencion del veterinario! ***\n", numeroAtencion);
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
    printf("Cantidad de servicios prestados en el dia: %d\n", cantServicio);
    printf("Importe total facturado: $%.2f\n", totalFacturado);
    printf("Monto promedio de facturacion: $%.2f\n", totalFacturado / cantServicio);
}
