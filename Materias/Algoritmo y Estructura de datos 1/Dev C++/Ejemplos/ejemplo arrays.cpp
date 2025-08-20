#include<stdio.h>
#define MAX_ALUMNOS 5

typedef float tv_ArrayNotas[MAX_ALUMNOS];

void ingresarNotas(tv_ArrayNotas);
void mostrarPromedioYPorcentaje(tv_ArrayNotas);
float promedioAprob(tv_ArrayNotas);
float porcentajeAprob(tv_ArrayNotas);
void mostrarNotasMayoresAlPromedio(tv_ArrayNotas);

tv_ArrayNotas vv_Notas;

int main(){
	ingresarNotas(vv_Notas);
	mostrarPromedioYPorcentaje(vv_Notas);
	mostrarNotasMayoresAlPromedio(vv_Notas);
	return 0;	
}

void ingresarNotas(tv_ArrayNotas pNotas){
	int i;
	for (i=0;i<MAX_ALUMNOS;i++){
		printf("Ingrese nota del alumno %d: ", i+1);
		scanf("%f", &pNotas[i]);
	}
}

void mostrarPromedioYPorcentaje(tv_ArrayNotas pNotas){
	printf("Promedio de notas aprobadas: %.2f\n", promedioAprob(pNotas));
	printf("Porcentaje de aprobados sobre el total: %.2f%%\n", porcentajeAprob(pNotas));
}

float promedioAprob(tv_ArrayNotas pNotas){
	int i;
	int cantAprobados = 0;
	float acumulaNotasAprob = 0.0;
	for (i=0; i<MAX_ALUMNOS; i++){
		if (pNotas[i] >= 6){
			cantAprobados++;
			acumulaNotasAprob += pNotas[i];
		}
	}
	return (float) acumulaNotasAprob / cantAprobados;
}

float porcentajeAprob(tv_ArrayNotas pNotas){
	int i;
	int cantAprobados = 0;
	for (i=0; i<MAX_ALUMNOS; i++){
		if (pNotas[i] >= 6){
			cantAprobados++;
		}
	}
	return (float) cantAprobados / MAX_ALUMNOS * 100;
}

void mostrarNotasMayoresAlPromedio(tv_ArrayNotas pNotas){
	int i;
	float prom = promedioAprob(pNotas);
	
	for (i=0; i<MAX_ALUMNOS; i++){
		if (pNotas[i] > prom){
			printf("%.2f - Alumno %d\n", pNotas[i], i+1);
		}
	}
}
