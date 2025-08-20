#include <stdio.h>
#include <string.h>


int main(){
	
	char *cadena1 = "TU Y YO PROGRAMANDO";
	char cadena2[50], cadena3[25], cadena4[25] = " No se, piensalo"; 
	
	
	strcpy (cadena2,cadena1);
	printf("la cadena2 es: %s",cadena2);
	printf("\n");
	
	strcat(cadena2," en el LUSAIL");
	printf("\nla cadena2 es: %s",cadena2);	
	printf("\n");	
	
	strcat(cadena2,cadena4);
	printf("\nla cadena2 es: %s",cadena2);	 
	printf("\n");	
	
	int i = strlen(cadena1);
	printf("\nLa longitud de cadena 1 es: %d", i);
    printf("\n");
	
	
	int c = strcmp (cadena1,cadena4);
	printf("\ncadena1 es mas larga que cadena4? (1-SI/0-igual/-1-NO): %d", c);
	printf("\n");
		
	int k = strcmp (cadena4,cadena1);
	printf("\ncadena4 es mas larga que cadena1? (1-SI/0-igual/-1-NO): %d", k);
	printf("\n");	
	
	
	return 0;
}

