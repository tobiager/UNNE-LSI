import java.util.Scanner;

public class PuntoMain {
  public static void main(final String[] array) {
    Scanner teclado = new Scanner(System.in);

    Punto punto1 = new Punto(1.0, 2.0);
    Punto punto2 = new Punto(4.0, 6.0);

    int opcion = 0;

    do {
      System.out.println("-------- Menú --------");
      System.out.println("1. Calcular distancia entre puntos: ");
      System.out.println("2. Desplazar puntos x e y del Punto 1: ");
      System.out.println("3. Desplazar puntos x e y del Punto 2: ");
      System.out.println("4. Mostrar Coordenadas del punto 1: ");
      System.out.println("5. Mostrar Coordenadas del punto 2: ");
      System.out.println("6. Salir");
      System.out.print("Seleccione una opción: ");
      opcion = teclado.nextInt();

      switch (opcion) {
        case 1:
          double distancia = punto1.distanciaA(punto2);
          System.out.println("La distancia entre los puntos es: " + distancia);
          break;
        case 2:
          System.out.print("Ingrese la cantidad para desplazar los puntos en x: ");
          double desplazamientoX = teclado.nextDouble();
          System.out.print("Ingrese la cantidad para desplazar los puntos en Y: ");
          double desplazamientoY = teclado.nextDouble();
          punto1.desplazar(desplazamientoX, desplazamientoY);
          System.out.println("Puntos 1 desplazado.");
          break;
        case 3:
          System.out.print("Ingrese la cantidad para desplazar los puntos en x: ");
          double desplazamientoX2 = teclado.nextDouble();
          System.out.print("Ingrese la cantidad para desplazar los puntos en Y: ");
          double desplazamientoY2 = teclado.nextDouble();
          punto1.desplazar(desplazamientoX2, desplazamientoY2);
          System.out.println("Puntos 2 desplazado.");
          break;
        case 4:
          System.out.print("Punto 1: " + punto1.coordenadas());
          break;
        case 5:
          System.out.print("Punto 2: " + punto2.coordenadas());
          break;
        case 6:
          System.out.println("¡Hasta luego!");
          break;
        default:
          System.out.println("Opción inválida. Intente nuevamente.");
      }

      System.out.println("\n");

    } while (opcion != 6);
    teclado.close();
  }
}
