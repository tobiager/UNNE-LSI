#include <stdio.h>

typedef char string[8];

typedef struct{
	long int dni; //DNI, 4bits
	short int carrera;//código de carrera, 2bits
	char genero;//código de género y m-v-x 1 bit
	short int edad;//edad 2bits
} tAlumno;


void inicializarProceso();///open

void procesarArchivo();//while feof

void procesarAlumno();//por cada registro

void imprimirTotales();//imprimir resutlado

void finalizarProceso();//close 

tAlumno alumno;

FILE * Archivo;

int cantidadLSI, cantidadTotal;
float porcentaje;

int main()
{
	inicializarProceso();
	procesarArchivo();
	imprimirTotales();
	finalizarProceso();
	
	return 0;
	
}

void inicializarProceso()
{

	Archivo = fopen("alumno.dat","rb");//lectura binaria
}

void procesarArchivo()
{
	//lectura adelanta
	
	fread(&alumno,sizeof(tAlumno),1,Archivo);
	
	while(!feof(Archivo))
	{
		procesarAlumno();//procesar Registro
		
		fread(&alumno,sizeof(tAlumno),1,Archivo);
	}
	
	//calcular el porcentaje --- aca recien tengo los totales
	porcentaje = (float) (cantidadLSI * 100) / cantidadTotal ;
	
}


void procesarAlumno()
{
	
	//cuantos son de LSI
	if(alumno.carrera == 18)
	{
		cantidadLSI++;
	}
	//que porcentaje representan del total
	cantidadTotal++;	
	
	
}

void imprimirTotales()
{
	
	printf("La Cantidad de Alumno de LIC. en sistemas es %d \n",cantidadLSI);
	printf("Corresponden al %.2f %% del total de alumno de la Facultad \n",porcentaje);
	
}

void finalizarProceso()
{
	
	fclose(Archivo);
	printf("Archivo Cerrado");
}



