import java.util.Scanner;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Random;

public class AplicacionBanco {
  public static void main(String[] args) {
    Scanner teclado = new Scanner(System.in);
    Localidad localidad = new Localidad("Corrientes", "Corrientes");

    System.out.print("Ingrese el cuil del empleado: ");
    int cuil1 = teclado.nextInt();
    teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
    System.out.print("Ingrese el apellido del empleado: ");
    String apellido1 = teclado.nextLine();
    System.out.print("Ingrese el nombre del empleado: ");
    String nombre1 = teclado.nextLine();
    System.out.print("Ingrese el sueldo basico del empleado: $");
    double sueldoBasico1 = teclado.nextDouble();
    Calendar fecha1 = Calendar.getInstance();

    Banco banco = new Banco("Santander Rio", localidad, 3,
        new Empleado(cuil1, apellido1, nombre1, sueldoBasico1, fecha1));

    int opcion = 0;
    do {
      System.out.println("\n****** Menú ******");
      System.out.println("1. Agregar empleado");
      System.out.println("2. Mostrar lista de sueldos");
      System.out.println("3. Despedir un empleado");
      System.out.println("4. Agregar cuenta bancaria");
      System.out.println("5. Mostrar resumen");
      System.out.println("6. Quitar una cuenta bancaria");
      System.out.println("7. Salir");
      System.out.print("Seleccione una opción: ");

      opcion = teclado.nextInt();
      teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.

      switch (opcion) {
        case 1:
          System.out.println("Ingrese la cantidad de empleados que desea agregar: ");
          int nEmpleados = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          for (int i = 0; i < nEmpleados; i++) {
            System.out.format("Ingrese los datos del empleado %s\n", i + 1);
            System.out.print("Ingrese el cuil del empleado: ");
            int cuil = teclado.nextInt();
            teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
            System.out.print("Ingrese el apellido del empleado: ");
            String apellido = teclado.nextLine();
            System.out.print("Ingrese el nombre del empleado: ");
            String nombre = teclado.nextLine();
            System.out.print("Ingrese el sueldo basico del empleado: $");
            double sueldoBasico = teclado.nextDouble();
            teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
            Calendar fecha = Calendar.getInstance();
            banco.agregarEmpleado(new Empleado(cuil, apellido, nombre, sueldoBasico, fecha));
          }
          break;
        case 2:
          banco.listarSueldos();
          break;
        case 3:
          if (banco.getEmpleados().size() == 1) {
            System.out.println("\nNo se pueden eliminar más empleados porque en el banco debe tener un empleado.");
            break;
          }
          System.out.println("\nIngrese el cuil del empleado a despedir: ");
          long cuil = teclado.nextLong();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          boolean encontrado = false;
          for (Empleado empleado : banco.getEmpleados()) {
            if (empleado.getCuil() == cuil) {
              System.out.format("Empleado eliminado %s.\n", empleado.apeYNom());
              encontrado = banco.quitarEmpleado(empleado);
              break; // Sale del bucle una vez que se encuentra y elimina el empleado
            }
          }
          if (!encontrado) {
            System.out.println("Empleado no encontrado...");
          }
          break;
        case 4:
          System.out.println("\nIngrese los datos de la cuenta: ");
          System.out.print("Ingrese su dni: ");
          int dni = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          System.out.println("Ingrese su fecha de nacimiento: ");
          System.out.print("Ingrese su dia de nacimiento: ");
          int dia = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          System.out.print("Ingrese su mes de nacimiento (número): ");
          int mes = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          System.out.print("Ingrese su año de nacimiento: ");
          int anio = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          Calendar fecha2 = new GregorianCalendar(anio, mes - 1, dia);
          System.out.print("Ingrese su apellido: ");
          String apellido2 = teclado.nextLine();
          System.out.print("Ingrese su nombre: ");
          String nombre2 = teclado.nextLine();
          Persona titular = new Persona(dni, nombre2, apellido2, fecha2);
          Random n = new Random();
          int numCuenta = n.nextInt(1000000000);
          System.out.print("Ingrese saldo a depositar: ");
          int saldo = teclado.nextInt();
          System.out.format("Nro de cuenta: %s.\n", numCuenta);
          banco.agregarCuentaBancaria(new CuentaBancaria(numCuenta, titular, saldo >= 0 ? saldo : 0));
          break;
        case 5:
          banco.mostrar();
          break;
        case 6:
          System.out.format("\nIngrese el N° Cuenta a quitar: ");
          int nCuenta = teclado.nextInt();
          teclado.nextLine(); // Limpia el buffer cuando se haga algo con números.
          boolean encontrado2 = false;
          for (CuentaBancaria cuenta : banco.getCuentaBancaria()) {
            if (cuenta.getNroCuenta() == nCuenta) {
              System.out.format("Cuenta %s eliminada.\n", cuenta.getNroCuenta());
              encontrado2 = banco.quitarCuentaBancaria(cuenta);
              break; // Sale del bucle una vez que se encuentra y elimina la cuenta
            }
          }
          if (!encontrado2) {
            System.out.println("\nCuenta no encontrada...");
          }
          break;
        case 7:
          System.out.println("Saliendo del programa.");
          break;
        default:
          System.out.println("Opción inválida.");
      }
    } while (opcion != 7);
    teclado.close();
  }
}