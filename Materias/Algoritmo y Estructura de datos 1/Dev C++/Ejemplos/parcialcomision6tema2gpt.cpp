#include <stdio.h>
#define TITULO "Tienda de autos - Servicios del dia"

void inicializarVariables();
void ingresarDatos();
void procesarServicio();
void contarVehiculosVendidos();
void contarCamionetasVendidas();
void calcularPorcentajeCamionetas();
void mostrarInforme();

int numeroVenta, marcaVehiculo, tipoVehiculo;
char respuesta;
int cantVehiculosVendidos, cantCamionetasVendidos, porcentajeCamionetas;

int main() {
	
    do {
        inicializarVariables();
        ingresarDatos();
        procesarServicio();
        contarVehiculosVendidos();
        contarCamionetasVendidas();
        printf("\nDesea cargar datos de vacunacion? s/n: ");
        fflush(stdin);
        scanf("%c", &respuesta);
    } while(respuesta == 's');

    calcularPorcentajeCamionetas();
    mostrarInforme();

    return 0;
}


void inicializarVariables(){
    cantVehiculosVendidos = 0; 
    cantCamionetasVendidos = 0;
}


void ingresarDatos(){
    printf("Ingrese numero de venta: ");
    scanf("%d", &numeroVenta);
    printf("Ingrese marca de vehiculo (1-Ford / 2- Toyota): ");
    scanf("%d", &marcaVehiculo);
    printf("Ingrese tipo de vehiculo (1-auto / 2- camioneta): ");
    scanf("%d", &tipoVehiculo);	
}

void procesarServicio() {
    if(tipoVehiculo == 2) {
        printf("*** Nro de venta %d dispone de beneficios adicionales! ***\n", numeroVenta);
    }
}

void contarVehiculosVendidos() {
    cantVehiculosVendidos++;
}


void contarCamionetasVendidas() {
    if(tipoVehiculo == 2) {
        cantCamionetasVendidos++;
    }
}

void calcularPorcentajeCamionetas() {
    porcentajeCamionetas = (cantCamionetasVendidos * 100) / cantVehiculosVendidos;
}

void mostrarInforme(){
    printf("%s\n", TITULO);
    printf("Cantidad de de vehiculos vendidos este mes: %d\n", cantVehiculosVendidos);
    printf("Cantitidad de camionetas vendidas: %d\n", cantCamionetasVendidos);
    printf("Porcentaje de camionetas respecto del total de vehiculos vendidos: %d%%\n", porcentajeCamionetas);
}

