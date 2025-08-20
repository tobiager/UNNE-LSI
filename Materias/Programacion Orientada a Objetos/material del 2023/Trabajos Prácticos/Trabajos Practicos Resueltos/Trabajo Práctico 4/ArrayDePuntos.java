import java.util.Scanner;
import java.text.DecimalFormat;

public class ArrayDePuntos {
  public static void main(String[] args) {
    DecimalFormat formato = new DecimalFormat("#.###");
    Scanner teclado = new Scanner(System.in);
    Punto[] arrayPunto = new Punto[6];
    // Punto arrayPunto[] = new Punto[6];

    for (int i = 0; i < arrayPunto.length; i++) {
      System.out.format("Ingrese los datos para el punto %s \n", i + 1);
      System.out.print("Coodenada x: ");
      double x = teclado.nextDouble();
      System.out.print("Coodenada y: ");
      double y = teclado.nextDouble();
      arrayPunto[i] = new Punto(x, y);
    }

    for (Punto punto : arrayPunto) {
      System.out.println(punto.coordenadas());
    }

    for (int i = 0; i < arrayPunto.length - 1; i++) {
      double distancia = arrayPunto[i].distanciaA(arrayPunto[i + 1]);
      System.out.format("Distancia entre Punto %s y Punto %s: %s.\n", i + 1, i + 2, formato.format(distancia));
    }
    teclado.close();
  }
}