import java.util.Scanner;

public class GestionStock {
  public static void main(String[] args) {
    Scanner teclado = new Scanner(System.in);

    Laboratorio laboratorio = new Laboratorio(
        "Colgate S.A.",
        "Scalabrini Ortiz 5524",
        "54-11-4239-8447");
    Producto producto = new Producto(
        0,
        "Perfumeria",
        "Jabon Deluxe",
        5.25,
        laboratorio);

    int opcion = 0;

    do {
      System.out.println("-------- Menú --------");
      System.out.println("1. Ajustar stock positivo");
      System.out.println("2. Ajustar stock negativo");
      System.out.println("3. Mostrar información del producto");
      System.out.println("4. Mostrar precio Lista");
      System.out.println("5. Mostrar precio Contado");
      System.out.println("6. Salir");
      System.out.print("Seleccione una opción: ");

      opcion = teclado.nextInt();

      switch (opcion) {
        case 1:
          System.out.print("Ingrese la cantidad a ajustar: ");
          int ajustePositivo = teclado.nextInt();
          producto.ajuste(ajustePositivo);
          break;
        case 2:
          System.out.print("Ingrese la cantidad a ajustar: ");
          int ajusteNegativo = teclado.nextInt();
          producto.ajuste(-ajusteNegativo);
          break;
        case 3:
          producto.mostrar();
          break;
        case 4:
          System.out.println("Precio Lista: $" + producto.precioLista());
          break;
        case 5:
          System.out.println("Precio Contado: $" + producto.precioContado());
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