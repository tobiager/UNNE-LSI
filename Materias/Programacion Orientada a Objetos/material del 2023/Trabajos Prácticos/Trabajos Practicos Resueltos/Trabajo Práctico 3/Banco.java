import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Scanner;

public class Banco {
  public static void main(String[] args) {
    Calendar fechaNacimiento = new GregorianCalendar();
    fechaNacimiento.set(2000, Calendar.SEPTEMBER, 8);

    Persona cliente = new Persona(44, "Juan", "Perez", fechaNacimiento);
    CuentaCorriente cuenta = new CuentaCorriente(1, 1500, cliente);
    CajaDeAhorro caja = new CajaDeAhorro(1, 1500, cliente);

    if (cliente.esCumpleanios()) {
      System.out.println("¡Feliz cumpleaños, " + cliente.apeYNom() + "!");
    }

    Scanner scanner = new Scanner(System.in);

    boolean salir = false;

    while (!salir) {
      System.out.println("\nMenú de Cuenta Bancaria");
      System.out.println("1. Mostrar información de la Cuenta Corriente");
      System.out.println("2. Realizar extracción en la Cuenta Corriente");
      System.out.println("3. Realizar deposito en la Cuenta Corriente");
      System.out.println("4. Mostrar información de la Caja de Ahorro");
      System.out.println("5. Realizar extracción en la Caja de Ahorro");
      System.out.println("6. Realizar deposito en la Caja de Ahorro");
      System.out.println("7. Salir");
      System.out.print("Seleccione una opción: ");

      int opcion = scanner.nextInt();

      switch (opcion) {
        case 1:
          cuenta.mostrar();
          break;
        case 2:
          System.out.print("Ingrese la cantidad a extraer de la Cuenta Corriente: ");
          double cantidadExtraccion = Double.parseDouble(scanner.next());
          cuenta.extraer(cantidadExtraccion);
          break;
        case 3:
          System.out.print("Ingrese la cantidad a depositar en Cuenta Corriente: ");
          double cantidadDeposito = Double.parseDouble(scanner.next());
          cuenta.depositar(cantidadDeposito);
          break;
        case 4:
          caja.mostrar();
          break;
        case 5:
          System.out.print("Ingrese la cantidad a extraer de la Caja de Ahorro: ");
          double cantidadExtraccionCaja = Double.parseDouble(scanner.next());
          caja.extraer(cantidadExtraccionCaja);
          break;
        case 6:
          System.out.print("Ingrese la cantidad a depositar en Caja de Ahorro: ");
          double cantidadDepositoCaja = Double.parseDouble(scanner.next());
          caja.depositar(cantidadDepositoCaja);
          break;
        case 7:
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
