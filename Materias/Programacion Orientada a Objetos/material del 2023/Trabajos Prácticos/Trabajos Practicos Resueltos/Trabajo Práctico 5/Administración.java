
// * Como está en el pdf...
// public class Administración {
//   public static void main(String[] args) {
//     Jardin jardin = new Jardin("Bichito de Luz");
//     Cuadrado cuadrado = new Cuadrado(new Punto(), 5);
//     Triangulo triangulo = new Triangulo(new Punto(), 4, 0.64);
//     Circulo circulo = new Circulo(2, new Punto());
//     Elipse elipse = new Elipse(5, 3, new Punto());
//     jardin.agregarFigura(cuadrado);
//     jardin.agregarFigura(triangulo);
//     jardin.agregarFigura(circulo);
//     jardin.agregarFigura(elipse);
//     jardin.detalleFiguras();
//   }
// }
import java.util.Scanner;

public class Administración {
  public static void main(String[] args) {
    Jardin jardin = new Jardin("Bichito de Luz");
    Scanner scanner = new Scanner(System.in);
    int opcion = 0;

    do {
      System.out.println("\nMenú:");
      System.out.println("1. Agregar Cuadrado");
      System.out.println("2. Agregar Triángulo");
      System.out.println("3. Agregar Círculo");
      System.out.println("4. Agregar Elipse");
      System.out.println("5. Mostrar Detalle de Figuras");
      System.out.println("6. Salir");
      System.out.print("Seleccione una opción: ");

      opcion = scanner.nextInt();

      switch (opcion) {
        case 1:
          System.out.print("Ingrese el lado del cuadrado: ");
          double ladoCuadrado = scanner.nextDouble();
          Cuadrado cuadrado = new Cuadrado(new Punto(), ladoCuadrado);
          jardin.agregarFigura(cuadrado);
          break;
        case 2:
          System.out.print("Ingrese la base del triángulo: ");
          double baseTriangulo = scanner.nextDouble();
          System.out.print("Ingrese la altura del triángulo: ");
          double alturaTriangulo = scanner.nextDouble();
          Triangulo triangulo = new Triangulo(new Punto(), baseTriangulo,
              alturaTriangulo);
          jardin.agregarFigura(triangulo);
          break;
        case 3:
          System.out.print("Ingrese el radio del círculo: ");
          double radioCirculo = scanner.nextDouble();
          Circulo circulo = new Circulo(radioCirculo, new Punto());
          jardin.agregarFigura(circulo);
          break;
        case 4:
          System.out.print("Ingrese el semieje mayor de la elipse: ");
          double semiejeMayor = scanner.nextDouble();
          System.out.print("Ingrese el semieje menor de la elipse: ");
          double semiejeMenor = scanner.nextDouble();
          Elipse elipse = new Elipse(semiejeMayor, semiejeMenor, new Punto());
          jardin.agregarFigura(elipse);
          break;
        case 5:
          jardin.detalleFiguras();
          break;
        case 6:
          System.out.println("Saliendo del programa. ¡Hasta luego!");
          System.exit(0);
        default:
          System.out.println("Opción no válida. Intente de nuevo.");
          break;
      }
    } while (opcion != 6);
    scanner.close();
  }
}