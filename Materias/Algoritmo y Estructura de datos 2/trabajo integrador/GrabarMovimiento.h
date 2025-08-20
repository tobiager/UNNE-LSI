#include <stdio.h>
#include <string.h>
#include "tipoDatos.h"

/* Declaración de prototipos */
void inicializarProceso();
void grabarCliente();
void finalizarProceso();

//Creo una funcion que invoque a los tres procesos, así solo llamo a una func en el codigo principal a la hora de guardar.	
void guardarMovimiento();

FILE * archivoBilletera;

void inicializarProceso(){
	archivoBilletera = fopen("DatosClientes.dat", "ab");
	
	if(archivoBilletera != NULL){
		printf("Archivo abierto para grabar!\n");
	}else{
		printf("Error al abrir el archivo...");
	}
}
			
void grabarCliente(){
		fwrite(&regMov, sizeof(tMovimiento), 1, archivoBilletera);
		printf("Movimiento insertado:\n %d | %s | %s | %d | %.2f\n", regMov.codDia, regMov.fecha, regMov.descripcion, regMov.codImporte, regMov.importe);
}

void finalizarProceso(){
	fclose(archivoBilletera);
}

void guardarMovimiento(){
   inicializarProceso();
   grabarCliente();
   finalizarProceso();
}

