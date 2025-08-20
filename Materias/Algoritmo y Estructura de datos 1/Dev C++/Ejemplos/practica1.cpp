#include <stdio.h>

int main(){
int sueldo;
int gastos;
int totaldinero;

printf("ingresar el sueldo:");
scanf("%d",&sueldo);

printf("ingresar gastos:");
scanf("%d",&gastos);
	
totaldinero = sueldo - gastos;
    
printf("La cantidad total de dinero es:%d",totaldinero);
return 0;
}
