#include <stdio.h>
/* Este programa inicializa un vector en 0,
Muestra el vector en 0
Carga el vector
Muestra el vector cargado
Mostrar cual es el mayor valor*/

int vecEdad[5];
void inicializarVec();
void mostrarVec();
void cargarVec();
void mostrarVecotravez();
void detectarMyEdad();

int i,sumarVector, mayorEdad, mayorEdadi;
float prom;
int main() {
	inicializarVec();
	mostrarVec();
	cargarVec();
	mostrarVecotravez();
	detectarMyEdad();
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
void detectarMyEdad(){
mayorEdad=0;
for(i= 0;i<5; i++) {
	if (vecEdad[i]> mayorEdad) {
		mayorEdad= vecEdad[i];
		mayorEdadi = i+1;
	}	
	
	}
	printf("\nLa mayor edad es: %d ",mayorEdad);
	printf("\nEn la posicions: %d ",mayorEdadi);
}

