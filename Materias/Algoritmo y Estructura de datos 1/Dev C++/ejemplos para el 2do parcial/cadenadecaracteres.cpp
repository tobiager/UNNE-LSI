#include <stdio.h>

int main (){
	
	char *cadena1 = "abcdefg";
	char cadena2[10] = "QUE PEDO";
	char cadena3[] = "ARGENTINA";
	char cadena4[100];
	
	printf("\ncadena1 es: %s",cadena1);
	
	printf("\ncadena2 es: ");
	printf("%s",cadena2);
	
	
	printf("\nIngrese una cadena de caracteres: ");
	scanf("%s",cadena4);
	printf("cadena4 es: %s ",cadena4);
	
	
	return 0;
}
