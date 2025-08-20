#include <stdio.h>

int main(){
	
int cantidad;
float precio, total;

printf("Ingresar cantidad de productos:");
scanf("%d",&cantidad);

printf("Ingresar el precio de los productos:");
scanf("%f",&precio);

total = cantidad * precio;
 
printf("Cant. unidades: %d - Precio unit.: $ %.2f\n", cantidad, precio);
printf("Precio total:%.2f\n", total);
return 0;
}

