#include <stdio.h>
void multiplicarPor10 (int pNro);
int main() {
	multiplicarPor10(20.5);
	return 0;
}
void multiplicarPor10(int pNro){
	printf ("El resultado es: %d \n\n", pNro*10);
}
