#include <stdio.h>
void inicializarVariables();
void ingresarNum();
void sumarNum();
void mostrarSuma();
int n, sumaNros;

int main(){
inicializarVariables();
ingresarNum();
sumarNum();
mostrarSuma();

return 0;
	
}

void inicializarVariables(){
	sumaNros=0;
}

void ingresarNum(){
	printf("Ingresar un numero entero:");
	scanf("%d", &n); 
}

void sumarNum(){
	int i;
	for(i=1; i<=n; i++){
		sumaNros = sumaNros + i;
	}
	
}

void mostrarSuma(){
	printf("suma de numeros desde 1 hasta %d = %d\n",n , sumaNros);
}
