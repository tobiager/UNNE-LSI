//Practica para el parcial 2
#include <stdio.h>
#define MESES 12

float serie1[MESES];
float serie2[MESES];
int i;
int j;
char nombreMeses[MESES][20] = {"mayo/18", "junio/18", "julio/18", "agosto/18", "septiembre/18", "octubre/18",
        "noviembre/18", "diciembre/18", "enero/19", "febrero/19", "marzo/19", "abril/19"};
        
char nombreMeses2[MESES][20] = {"mayo/19", "junio/19", "julio/19", "agosto/19", "septiembre/19", "octubre/19",
        "noviembre/19", "diciembre/19", "enero/20", "febrero/20", "marzo/20", "abril/20"};


void ingresarDatos();
void ingresarDatos2();

int main(){
	ingresarDatos();
	ingresarDatos2();
}

void ingresarDatos(){
  printf("\nIngrese los valores del rio en la serie 1:");
  for(i = 0; i < MESES; i++) {
  	printf("\nIngrese el valor del rio para el mes %s:\n", nombreMeses[i]);
  	scanf(" %f", &serie1[i]);
  }
  

  }
  
  void ingresarDatos2(){
  	 printf("Ingrese los valores del rio en la serie 2:\n\n");
  for(j = 0; j < MESES; j++){
  	printf("Ingrese el valor del rio para el mes %s:\n", nombreMeses2[j]);
  	scanf(" %f", &serie2[j]);
  }
}
