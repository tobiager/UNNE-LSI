#include <stdio.h>
#include <stdlib.h>
typedef char *apuntadorC; 
apuntadorC a1, a2;
int main() {
	a1 = (apuntadorC) malloc (sizeof(char));
	a2 = (apuntadorC) malloc (sizeof(char));
	
	
	*a1 = 'A';
	*a2 = 'B';
	
	
	printf("valor de a1 %p \n", a1);
	printf("valor de a2 %p \n", a2);	
	printf("valor donde apunta a1 %c \n", *a1);
	printf("valor donde apunta a2 %c \n", *a2);
	
	free(a1);
	free(a2);
	
return 0;
}
// la salida de este programa es 'A' y 'B'


