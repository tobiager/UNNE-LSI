import java.text.DecimalFormat;
import java.util.Random;
import java.util.Scanner;

public class CreaFigura {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    Random numeroRandom = new Random();
    DecimalFormat df = new DecimalFormat("#.##");
    double radio = numeroRandom.nextDouble() * 100.0;

    Circulo circulo1 = new Circulo(radio, new Punto());
    circulo1.desplazar(-240, -230);
    Circulo circulo2 = null;

    int opcion = 0;

    while (opcion != 7) {
      System.out.println("\nMenú:");
      System.out.println("1. Generar nuevo circulo");
      System.out.println("2. Desplazar circulo 1");
      System.out.println("3. Mostrar circulo 1");
      System.out.println("4. Mostrar circulo 2");
      System.out.println("5. Calcular el circulo con mayor área");
      System.out.println("6. Calcular la distancia entre los dos circulos");
      System.out.println("7. Salir");

      System.out.print("Selecciona una opción: ");
      opcion = scanner.nextInt();

      switch (opcion) {
        case 1:
          double radio2 = new Random().nextDouble() * 100.0;
          double x = new Random().nextDouble() * 100.0;
          double y = new Random().nextDouble() * 100.0;
          circulo2 = new Circulo(radio2, new Punto(x, y));
          System.out.println("Nuevo circulo generado.");
          break;
        case 2:
          System.out.print("Ingrese la cantidad de desplazamiento en X: ");
          double desplazamientoX = scanner.nextDouble();
          System.out.print("Ingrese la cantidad de desplazamiento en Y: ");
          double desplazamientoY = scanner.nextDouble();
          circulo1.desplazar(desplazamientoX, desplazamientoY);
          System.out.println("Circulo 1 desplazado.");
          break;
        case 3:
          circulo1.caracteristicas();
          break;
        case 4:
          if (circulo2 != null) {
            circulo2.caracteristicas();
          } else {
             System.out.println("No se ha generado un segundo circulo.");
          }
          break;
        case 5:
          if (circulo2 != null) {
            Circulo mayor = circulo1.elMayor(circulo2);
            System.out.println("El circulo con mayor área es: ");
            mayor.caracteristicas();
          } else {
            System.out.println("No se ha generado un segundo circulo.");
          }
          break;
        case 6:
          if (circulo2 != null) {
            double distancia = circulo1.distanciaA(circulo2);
            System.out.println("Distancia entre los dos circulos: " + df.format(distancia));
          } else {
            System.out.println("No se ha generado un segundo circulo.");
          }
          break;
        case 7:
          System.out.println("Saliendo del programa.");
          scanner.close();
        default:
          System.out.println("Opción no válida. Por favor, seleccione una opción válida.");
          break;
      }
    }
  }
}
