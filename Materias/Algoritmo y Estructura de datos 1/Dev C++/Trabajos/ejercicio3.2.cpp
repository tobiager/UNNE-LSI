#include <stdio.h>

// Función para calcular la mitad de un número
int mitadDe(int num) {
  return num / 2;
}

// Función para calcular el doble de un número
int dobleDe(int num) {
  return num * 2;
}

// Función para calcular el triple de un número
int tripleDe(int num) {
  return num * 3;
}

// Función para calcular el número anterior
int anteriorDe(int num) {
  return num - 1;
}

// Función para calcular el número posterior
int posteriorDe(int num) {
  return num + 1;
}

// Función para calcular el posterior del doble de un número
int posteriorDelDobleDe(int num) {
  int doble = dobleDe(num);
  return posteriorDe(doble);
}
// Función para calcular el doble del doble de un número
int dobleDelDobleDe(int num) {
  int doble = dobleDe(num);
  return dobleDe(doble);
}
// Función para calcular el doble del doble del doble de un número
int dobleDelDobleDelDoble(int num) {
  int doble = dobleDe(num);
  return dobleDelDobleDe(doble);
}

int main() {
  int num;

  // Solicitar al usuario ingresar un valor entero
  printf("Ingrese un valor entero: ");
  scanf("%d", &num);

  // Ejecutar todas las funciones con el valor ingresado
  printf("La mitad de %d es: %d\n", num, mitadDe(num));
  printf("El doble de %d es: %d\n", num, dobleDe(num));
  printf("El triple de %d es: %d\n", num, tripleDe(num));
  printf("El numero anterior a %d es: %d\n", num, anteriorDe(num));
  printf("El numero posterior a %d es: %d\n", num, posteriorDe(num));
  printf("El posterior del doble de %d es: %d\n", num, posteriorDelDobleDe(num));
  printf("El doble del doble de %d es: %d\n", num, dobleDelDobleDe(num));
  printf("El doble del doble del doble de %d es: %d\n", num, dobleDelDobleDelDoble(num));
  return 0;
}

