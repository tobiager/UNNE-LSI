#include <stdio.h>
#define TITULO "Tienda de mascotas - Servicios del día";
void inicializarVariables();
void ingresarPregControl();
void ingresarDatos();
void procesarServicio();
void contarServicios();
void contarTotalFacturado();
void mostrarInforme();



int tipoServicio;
int cantServicio;
int numeroAtencion;
float importeFacturado, importeTotal, totalFacturado;
char respuesta
	
	
int main(){
inicializarVariables();
ingresarPregControl();

while (respuesta == 's'){
ingresarDatos();
procesarServicio();	
ingresarPregControl();
	}
contarServicios();
contarTotalFacturado();
mostrarInforme();
return 0;
}



void inicializarVariables(){
tipoServicio= 0;
cantServicio=0;
numeroAtencion=0;	
importeTotal=0;
}


void ingresarPregControl(){
	printf("Desea cargar datos de vacunacion? s/n: ");
	fflush(stdin);
	scanf("%c", &respuesta);	
}


void ingresarDatos(){
	printf("Ingrese numero de atencion: ");
	scanf("%d", &numeroAtencion);	
	printf("Ingrese tipo de servicio(1 - Venta de alimentos / 2 - Atencion a mascotas): ");	
	scanf("%d", &tipoServicio);	
	printf("Ingrese importe facturado: ");	
	scanf("%.2f", &importeFacturado);
}


void procesarServicio(){
		if(tipoServicio == 2){
			printf("\nNro de atencion %d recibio atencion del veterinario!", tipoServicio);
		}else{
			printf("\nNro de atencion %d compro alimentos!", tipoServicio);
		}
}

contarServicios(){
	cantServicio = cantServicio + 1;
}


contarTotalFacturado(){
	 importeTotal += importeFacturado; // sumamos el importe facturado al importe total
    totalFacturado = importeTotal; // asignamos el importe total a la variable que se mostrará en el informe
    float promedioFacturacion = importeTotal / cantServicio; // calculamos el promedio de facturación
    printf("Monto promedio de facturación por servicio: $%.2f\n", promedioFacturacion);
}


void mostrarInforme(){
	printf("%s\n", TITULO);
	printf("importe total facturado:%.2f",totalFacturado);
	printf("Cantidad de servicios prestados:%d",cantServicio);
}



	

