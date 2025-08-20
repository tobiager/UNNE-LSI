/* 
	AUTOR 1: Orban, Tobias
	AUTOR 2: APELLIDO, NOMBRE
	
	
	OBJETIVO:
		Informe de efectividad:
			- RECOLECTAR DATOS DE PERSONAS VACUNAS 
			- EMITIR UN MENSAJE PARA LOS VACUNADOS CON ANTIGRIPAL
			- EMITIR UN INFORME FINAL SEGUN EL FORMATO DADO
			
	ESTRATEGIA:
		
		hacer
			ingresarDatos(); 							
			emitirMensajeAntigripal();
			procesarVacunados();
			continuar();
		mientras respuesta == 's'
		mostrarInformeFinal()
			- porcentaje(subtotal, total) --> devuelve un valor que representa un porcentaje
	-------------------------------------------------------------------------------
			inicializarVariables();	
	ingresarPregControl();
	while (respuesta == 's')
		ingresarDatosVacuna();
		procesarVacuna();
		ingresarPregControl();
		mostrarInforme();
	
*/

#include<stdio.h>
#define TITULO "Campania de vacunacion Corrientes"

void inicializarVariables();
void ingresarPregControl();
void ingresarDatosVacuna();
void procesarVacuna();
void procesarCovid();
void procesarAntigripal();
void mostrarInforme();
float porcentaje(int, int);
	
int tipoVacuna, dosis, edad, lugar;

int cantAntigripal, cantMenoresTra, cantCovid;
char respuesta;

int main(){	
	inicializarVariables();	
	ingresarPregControl();
	while (respuesta == 's'){
		ingresarDatosVacuna();
		procesarVacuna();
		ingresarPregControl();
	}
		mostrarInforme();
	return 0;
}

void inicializarVariables() {
	cantAntigripal = 0;
	cantMenoresTra = 0;
	cantCovid = 0;
}
void ingresarPregControl(){
	printf("Desea cargar datos de vacunacion? s/n: ");
	fflush(stdin);
	scanf("%c", &respuesta);
	/* Solo se ingresan los datos en caso que respuesta sea = s */
}	
void ingresarDatosVacuna() {
	printf("\tTipo de vacuna (1 - Covid, 2 - Antigripal): ");
	scanf("%d", &tipoVacuna);	
	printf("\tDosis (1, 2, 3 o 4): ");	
	scanf("%d", &dosis);	
	printf("\tEdad: ");	
	scanf("%d", &edad);
	printf("\tLugar de vacunacion (1 - Morgue, 2 - Facultad de Medicina, 3 - Hospital Llano): ");	
	scanf("%d", &lugar);
	
}
void procesarVacuna() {
		if(tipoVacuna == 1){
			procesarCovid();
		}else{
			procesarAntigripal();
		}	
	}


void procesarCovid() {
	cantCovid = cantCovid + 1;	
	if (edad < 18 && dosis == 3) {
			cantMenoresTra = cantMenoresTra + 1;
	}
}

void procesarAntigripal() {	
	cantAntigripal = cantAntigripal + 1;	
	printf("\n***  Antigripal -  Edad: %d Lugar: %d ***\n", edad, lugar);
}

float porcentaje(int pCantMenoresTra, int pCantCovid){
		return (float) pCantMenoresTra / pCantCovid * 100;
}


void mostrarInforme() {	
	printf("\n\n %s \n", TITULO);
	printf("\n\nCantidad Vacunados Antigripal: %d \n", cantAntigripal);
	printf("\nCantidad Menores con 3 dosis de AntiCovid: %d  (%.2f %%)", cantMenoresTra, porcentaje(cantMenoresTra, cantCovid));
}


