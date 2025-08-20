/*
Una concesionaria de autos necesita un programa que permita ingresar datos relacionados a las ventas
mensuales de veh�culos y que emita informaci�n relacionada.
El sistema debe permitir el ingreso por teclado de los datos: n�mero de venta, marca del veh�culo (1-Ford,
2-Toyota), tipo de veh�culo (1-auto 2-camioneta). Se requiere:
- Cada vez que se ingresan los datos evaluar la condici�n y mostrar, si corresponde:
o En caso de ventas de camionetas, se debe emitir un mensaje que indique que dispone de
beneficios adicionales. Ejemplo de salida en pantalla:
*** Nro de venta 12345 Dispone de beneficios adicionales! ***
- Al finalizar la carga de datos, mostrar la siguiente informaci�n, seg�n formato de informe final:
o Informar la cantidad de veh�culos vendidos en el mes.
o Informar la cantidad de camionetas vendidas y el porcentaje de camionetas respecto del total
de veh�culos vendidos.
El programa debe permitir cargar datos de los veh�culos vendidos hasta que el usuario indique que no hay
m�s datos para cargar.
*Nota: Utilice una funci�n con par�metros para calcular el porcentaje de vendidas.
El formato del informe debe ser el siguiente (Utilizar una constante para el t�tulo):
*/
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

