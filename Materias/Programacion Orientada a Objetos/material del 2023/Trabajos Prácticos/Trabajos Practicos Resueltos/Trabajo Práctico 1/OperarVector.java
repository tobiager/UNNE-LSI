import java.util.Scanner;
// Crear una clase denominada OperarVector que permita ingresar por teclado (Scanner)
// 5 notas de alumnos, las que serán almacenadas en un array de enteros. Calcular
// el promedio y determinar la mayor nota. El promedio debe permitir resultado con decimales
// (aplicar cast a los elementos enteros cuando sea necesario para obtener 
// dicho resultado). Mostrar los elementos ingresados, separados por un tabulador.
// Mostrar el promedio y la mayor nota con el mensaje respectivo. 

public class OperarVector {
  public static void main(String[] args) {
    Scanner teclado = new Scanner(System.in);
    float[] notas = new float[5];
    System.out.println("Ingrese las 5 notas: ");

    for (int i = 0; i < notas.length; i++) {
      System.out.println(">>> ");
      notas[i] = teclado.nextFloat();
    }
    System.out.println("Promedio de Notas: " + promedioNotas(notas));
    System.out.println("Nota Maxima: " + maximaNota(notas));
  }

  private static float maximaNota(float[] pNotas) {
    float maximo = pNotas[0];
    for (int i = 1; i < pNotas.length; i++) {
      if (pNotas[i] > maximo) {
        maximo = pNotas[i];
      }
    }
    return maximo;
  }

  private static float promedioNotas(float[] pNotas) {
    float promedio = 0;
    for (int i = 0; i < pNotas.length; i++) {
      promedio += pNotas[i];
    }
    return promedio / pNotas.length;
  }
}
