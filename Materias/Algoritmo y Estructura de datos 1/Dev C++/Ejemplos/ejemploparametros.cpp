#include <stdio.h>

int sumar(int,int);
void mostrarResultado();

int main(){
	mostrarResultado();
	return 0;
}
int sumar(int pNro1, int pNro2){
	return pNro1 + pNro2;
}
void mostrarResultado(){
	printf("La suma de 5 y 10 es: %d", sumar(5, 10));
}
