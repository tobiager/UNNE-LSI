import java.util.Scanner;
import java.util.Calendar;

public class CuentaMain {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    Persona titular = new Persona(
        44542230,
        "Juan",
        "Perez",
        1989);

    CuentaBancaria cuenta = new CuentaBancaria(
        1249,
        titular,
        155.25);
        
    boolean salir = false;

    while (!salir) {
      System.out.println("\nMenú de Cuenta Bancaria");
      System.out.println("1. Mostrar información de la cuenta");
      System.out.println("2. Depositar dinero");
      System.out.println("3. Mostrar representación en cadena de la cuenta");
      System.out.println("4. Salir");
      System.out.print("Seleccione una opción: ");

      int opcion = scanner.nextInt();

      switch (opcion) {
        case 1:
          cuenta.mostrar();
          break;
        case 2:
          System.out.print("Ingrese la cantidad a depositar: ");
          double cantidadDeposito = Double.parseDouble(scanner.next());
          cuenta.depositar(cantidadDeposito);
          System.out.println("Depósito exitoso.");
          break;
        case 3:
          System.out.println(cuenta.toStrinf());
          break;
        case 4:
          salir = true;
          System.out.println("Saliendo del programa.");
          break;
        default:
          System.out.println("Opción no válida. Por favor, seleccione una opción válida.");
      }
    }

    scanner.close();
  }
}