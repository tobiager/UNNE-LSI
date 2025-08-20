import java.util.Scanner;
// Crear una clase denominada OrdenVector, que permita ingresar por teclado (Scanner) 4 elementos de tipo
// doble, y almacenarlos en un array. Determinar el menor elemento y mostrarlo. Ordenar los elementos del 
// vector de menor a mayor. Mostrar los elementos ordenados, separados por un tabulador. Usar instrucción
// FOR para el ingreso de datos. Utilizar método de la Burbuja.

public class OrdenVector {
  public static void main(String[] args) {
    Scanner teclado = new Scanner(System.in);
    double[] vector = new double[4];
    System.out.println("Ingrese los elementos: ");
    for (int i = 0; i < vector.length; i++) {
      vector[i] = teclado.nextDouble();
    }
    System.out.println("El menor elemento es: " + menorElemento(vector));
    System.out.println("Los elementos ordenados son: ");
    for (int i = 0; i < vector.length; i++) {
      System.out.print(ordenarBurbuja(vector)[i] + "\t");
    }
  }

  private static double menorElemento(double[] pVector) {
    double menor = pVector[0];
    for (int i = 1; i < pVector.length; i++) {
      if (pVector[i] < menor) {
        menor = pVector[i];
      }
    }
    return menor;
  }

  private static double[] ordenarBurbuja(double[] pVector) {
    int n = pVector.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (pVector[j] > pVector[j + 1]) {
          // double aux = pVector[j];
          // pVector[j] = pVector[j + 1];
          // pVector[j + 1] = aux;
          pVector[j] += pVector[j + 1];
          pVector[j + 1] = pVector[j] - pVector[j + 1];
          pVector[j] -= pVector[j + 1];
        }
      }
    }
    return pVector;
  }
}
