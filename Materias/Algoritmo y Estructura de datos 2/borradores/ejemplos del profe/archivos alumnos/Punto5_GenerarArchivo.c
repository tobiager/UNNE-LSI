#include <stdio.h>


typedef char string[8];

typedef struct{
	long int dni; //DNI, 4bits
	short int cod_carrera;//código de carrera, 2bits
	char cod_genero;//código de género y m-v-x 1 bit
	short int edad;//edad 2bits
} tAlumno;

tAlumno alumno;
FILE * Archivo;


void inicializarProceso();
void ingresarDatos();//while
void finalizarProceso();

void ingresarAlumno();//scan

int main()
{

	inicializarProceso();
	ingresarDatos();
	finalizarProceso();
	
	return 0;

}


void inicializarProceso()
{
	
	Archivo = fopen("alumno.dat","ab");
	
	if(Archivo == NULL)
	{
		printf("Error al abrir el archivo");
	}
	else
	{
		printf("Archivo Abierto \n");
	}
	
}


void ingresarDatos()
{
	
	char resp = 's';//para forzar el primer while
	
	while( resp != 'n')
	{
		
		ingresarAlumno();//aca van los scans
		
		fwrite(&alumno,sizeof(tAlumno),1,Archivo);//grabar el registro en el archivo	
		
		printf("Ingresar nuevo alumno? s/n \n");
		scanf("%s",&resp);
		
	}
}


void ingresarAlumno()
{
	
	printf("DNI: ");
	scanf("%d", &alumno.dni);
	
	printf("Codigo de Carrera: \n");
	printf("18-Lic. en Sistemas de Información (LSI) \n");
	printf("19-Lic. en Cs. Biológicas \n");
	printf("20-Agrimensura \n");
	printf("28-Bioquímica \n");
	printf("29-Ing. Electrónica \n");
	scanf("%d", &alumno.cod_carrera);
	
	fflush(stdin);
	printf("Codigo de Genero: \n");
	printf("m-mujer \n");
	printf("v-varón \n");
	printf("x-otro \n");
	scanf("%s", &alumno.cod_genero);
	
	printf("Edad: ");
	scanf("%d", &alumno.edad);
	
	
}


void finalizarProceso(){
	
	
	fclose(Archivo);
}


///abriri archvio como lectura

///cargar todo ese archivop de productos en vectos lista pila

//actualziar sobre esa estrcutar

//volver a grabar TODO el archivo dfe nuevo 





