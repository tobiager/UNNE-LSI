#include <stdio.h>

// Función para calcular la mitad de un número
float mitadDe(float num) {
  return num / 2;
}
int main() {
  float num;

  // Solicitar al usuario ingresar un valor entero
  printf("Ingrese un numero: ");
  scanf("%f", &num);

  // Ejecutar todas las funciones con el valor ingresado
  printf("La mitad de %f es: %.2f\n", num, mitadDe(num));
  return 0;
}

