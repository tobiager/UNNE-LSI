import java.time.LocalDate;
import java.util.Scanner;


public class GestionComercio {
  public static void main(String[] args) {
    Comercio comercio = new Comercio("Avanti SRL");
     LocalDate fechaIngreso = LocalDate.now(); 
    Empleado juan = new Empleado( "Juan", "Gonzalez", 53231321, 120000,fechaIngreso);
    Empleado mercedes = new Empleado("Mercedes", "Martinez", 43213432, 100000,fechaIngreso);
    Empleado virginia = new Empleado("Virginia", "Gomez", 33432123, 150000,fechaIngreso);
    comercio.altaEmpleado(juan);
    comercio.altaEmpleado(mercedes);
    comercio.altaEmpleado(virginia);
    Scanner teclado = new Scanner(System.in);
    int opcion;

    do {
      System.out.println("\n**** Menú de Comercio ****");
      System.out.println("1. Agregar empleado");
      System.out.println("2. Dar de baja empleado");
      System.out.println("3. Ver cantidad de empleados");
      System.out.println("4. Ver si un empleado existe");
      System.out.println("5. Calcular sueldo neto de un empleado");
      System.out.println("6. Ver nómina de empleados");
      System.out.println("7. Salir");
      System.out.print("Ingrese la opción deseada: ");

      opcion = teclado.nextInt();

      switch (opcion) {
        case 1:
          teclado.nextLine(); // Limpia el buffer
          System.out.print("Ingrese el CUIL del empleado: ");
          long cuilEmpleado = teclado.nextLong();
          teclado.nextLine(); // Limpia el buffer
          System.out.print("Ingrese el apellido del empleado: ");
          String apellidoEmpleado = teclado.nextLine();
          System.out.print("Ingrese el nombre del empleado: ");
          String nombreEmpleado = teclado.nextLine();
          System.out.print("Ingrese el sueldo básico del empleado: ");
          double sueldoBasicoEmpleado = teclado.nextDouble();
          LocalDate fechaIngresoEmpleado = LocalDate.now();
          Empleado nuevoEmpleado = new Empleado(nombreEmpleado, apellidoEmpleado, cuilEmpleado, sueldoBasicoEmpleado,fechaIngresoEmpleado);
          comercio.altaEmpleado(nuevoEmpleado);
          System.out.println("Empleado agregado con éxito.");
          break;

        case 2:
          System.out.print("Ingrese el CUIL del empleado a dar de baja: ");
          long cuilBaja = teclado.nextLong();
          Empleado empleadoBaja = comercio.bajaEmpleado(cuilBaja);
          if (empleadoBaja != null) {
            System.out.println("Empleado dado de baja: " + empleadoBaja.getNombre());
          } else {
            System.out.println("No se encontró ningún empleado con el CUIL ingresado.");
          }
          break;
        case 3:
          int cantidadEmpleados = comercio.cantidadDeEmpleados();
          System.out.println("Cantidad de empleados: " + cantidadEmpleados);
          break;
        case 4:
          System.out.print("Ingrese el CUIL del empleado a verificar: ");
          long cuilVerificar = teclado.nextLong();
          boolean esEmpleado = comercio.esEmpleado(cuilVerificar);
          if (esEmpleado) {
            System.out.println("El empleado existe.");
          } else {
            System.out.println("El empleado no existe.");
          }
          break;
        case 5:
          System.out.print("Ingrese el CUIL del empleado para calcular su sueldo neto: ");
          long cuilSueldoNeto = teclado.nextLong();
          comercio.sueldoNeto(cuilSueldoNeto);
          break;
        case 6:
          comercio.nomina();
          break;
        case 7:
          System.out.println("Saliendo del programa.");
          break;
        default:
          System.out.println("Opción no válida. Por favor, seleccione una opción válida.");
      }
    } while (opcion != 7);

    teclado.close();
  }
}
