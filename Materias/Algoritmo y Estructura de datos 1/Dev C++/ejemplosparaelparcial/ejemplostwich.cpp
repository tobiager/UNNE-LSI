#include <stdio.h>
int main(){
char sexo, nombre;
int edad;
float peso;

printf("ingrese su nombre: ");
scanf("%s",&nombre);

printf("ingrese su edad: ");
scanf("%d",&edad);

printf("ingrese su peso: ");
scanf("%.2f",&peso);
fflush(stdin);

printf("ingrese su sexo (m-mujer / v-varon): ");
scanf("%c",&sexo);


printf("\n Nombre: %s \n edad: %d \n peso: %.2f", nombre, edad, peso);

switch (sexo){
	case 'm': printf("\nEs mujer!!\n");
	break;
	case 'v': printf("\nEs varon!!\n");	
	break;
	default: printf("\nerror al ingresar el codigo\n");
	break;
}
return 0;
}
