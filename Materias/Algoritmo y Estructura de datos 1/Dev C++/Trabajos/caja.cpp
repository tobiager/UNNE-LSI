#include<stdio.h>
void ingresarValores();
void mostrarResultado();
void inicializarVariables();
void definirPerimetro();

float lado1;
float lado2;
float perimetro;

int main(){
  inicializarVariables();
  ingresarValores();
  definirPerimetro();
  mostrarResultado();

 return 0;
}
void inicializarVariables(){
 lado1=0;
 lado2=0;
 perimetro=0;

}
void ingresarValores(){

   printf("ingrese el valor del ancho de la caja \n");
   scanf("%f",&lado1);
   printf("ingrese el valor de alto de la caja \n");
   scanf("%f",&lado2);

}
void definirPerimetro(){
perimetro= 2*(lado1+lado2);
}
 void mostrarResultado(){
printf("el perimetro es: %f",perimetro);
}

