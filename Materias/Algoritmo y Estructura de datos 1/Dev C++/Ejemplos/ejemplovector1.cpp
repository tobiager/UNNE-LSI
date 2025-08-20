#include <stdio.h>
/* Este programa inicializa un vector en 0,
Muestra el vector en 0
Carga el vector
Muestra el vector cargado
Calcula y muestra el promedio*/

int vecEdad[5];

void inicializarVec();
void mostrarVec();
void cargarVec();
void mostrarVecotravez();
void calcularPromEdad();

int i,sumarVector;
float prom;

int main() {
	inicializarVec();
	mostrarVec();
	cargarVec();
	mostrarVecotravez();
	calcularPromEdad();
return 0;	
}
void inicializarVec(){	
	for( i= 0;i<5; i++) {
	vecEdad[i]=0;
	}
}
void mostrarVec(){
	for( i= 0;i<5; i++) {
	printf("\nEl valor de la edad del alumno %d es: %d ",i+1 , vecEdad[i]);
	
	}
	printf("\n El vector esta inicializado en 0 \n"); 
}
	
void cargarVec(){
	for( i= 0;i<5; i++) {
	printf("\ningrese la edad del alumno %d: ",i+1);
	scanf("%d",&vecEdad[i]);
	}
}
	
void mostrarVecotravez(){
	for(i= 0;i<5; i++) {
	printf("\nEl valor de la edad del alumno en la posicion %d es: %d : ",i+1, vecEdad[i]);
	
	}
}
void calcularPromEdad(){
for(i= 0;i<5; i++) {
	sumarVector= sumarVector + vecEdad[i];	
	}
	prom= sumarVector/5;
	printf("\nEl promedio de edad de los alumno es: %.2f ",prom);
}

