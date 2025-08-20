#include <stdio.h>

typedef char string[50];

typedef struct {
	long int dni;
	string apellidoNombre;
	short int destino;
	float precioViaje;
	short int formaPago;
}tRegPasajeros;

void inicializarProceso();
void grabarPasajeros();
void finalizarProceso();
	
void ingresarPasajero();

void mostrarPasajeros();

tRegPasajeros pasajero;
FILE * ArchivoPasajeros;

int main() {

	
	inicializarProceso();
	grabarPasajeros();
	finalizarProceso();
	mostrarPasajeros();
	return 0;
}

void inicializarProceso() {
	ArchivoPasajeros = fopen("Pasajeros.dat", "wb");//Write Binary
	
	if(ArchivoPasajeros == NULL) {
		printf("Error\n");
	} else {
		printf("Archivo abierto para grabar ... \n");
	}
}

void grabarPasajeros() {
	char opcion = 's';
	
	while(opcion != 'n') {
		ingresarPasajero();
		fwrite(&pasajero, sizeof(tRegPasajeros), 1, ArchivoPasajeros);
		
		printf("\tPasajero insertado!\n ");
		
		printf("Ingresar otro ? s/n: ");
		fflush(stdin);
		scanf("%c", &opcion);
	}
}

void finalizarProceso() {
	fclose(ArchivoPasajeros);
}

void ingresarPasajero() {
	printf("*** Ingreso de datos de un pasajero ***\n");
	
	printf("DNI: ");
	scanf("%d", &pasajero.dni);
	
	printf("Apellido y nombre: ");
	fflush(stdin);
	scanf("%[^\n]s", &pasajero.apellidoNombre);
	
	printf("Destino (1-Nacionales, 2-Extranjeros): ");
	scanf("%d", &pasajero.destino);
	
	printf("Precio del viaje: ");
	scanf("%f", &pasajero.precioViaje);
	
	printf("Forma de pago (1-Efectivo, 2-Tarjeta): ");
	scanf("%d", &pasajero.formaPago);	
}

void mostrarPasajeros() {
	ArchivoPasajeros = fopen("Pasajeros.dat", "rb");
	
	fread(&pasajero, sizeof(tRegPasajeros), 1, ArchivoPasajeros);
	
	while(!feof(ArchivoPasajeros)) { // Mientras NO llegue al final del archivo
		printf("%s | %d | %d | %.2f \n", pasajero.apellidoNombre, pasajero.destino, pasajero.formaPago, pasajero.precioViaje);
		
		fread(&pasajero, sizeof(tRegPasajeros), 1, ArchivoPasajeros);
	}
	finalizarProceso();
}




