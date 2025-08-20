// public class MainHospital {
//   public static void main(String[] args) {
//     Hospital hospital = new Hospital("Garrahan", "Leonardo Ruiz");
//     Localidad nacio = new Localidad("Monte Caseros", "Corrientes");
//     Localidad vive = new Localidad("Monte Caseros", "Corrientes");
//     Paciente paciente = new Paciente(578669, "Juan Manuel Ortigoza", "Bulevar 3 de Abril", vive, nacio);
//     hospital.consultaDatosFiliatorios(paciente);

//     System.out.println("\n");

//     Localidad nacio2 = new Localidad("San Cosme", "Corrientes");
//     Localidad vive2 = new Localidad("Capital", "Corrientes");
//     Paciente paciente2 = new Paciente(747831, "Marcos Maidana Jose", "9 de Julio 2973", vive2, nacio2);
//     hospital.consultaDatosFiliatorios(paciente2);
//   }
// }
import java.util.Scanner;

public class MainHospital {
  public static void main(String[] args) {
    Hospital hospital = new Hospital("Garrahan", "Leonardo Ruiz");
    Scanner scanner = new Scanner(System.in);

    int opcion = 0;

    while (opcion != 2) {
      System.out.println("Menú de opciones:");
      System.out.println("1. Ingresar datos de un paciente");
      System.out.println("2. Salir");
      System.out.print("Elija una opción: ");

      opcion = scanner.nextInt();
      scanner.nextLine();

      switch (opcion) {
        case 1:
          System.out.println("Ingrese los datos del paciente:");
          System.out.print("Número de registro: ");
          int numeroRegistro = scanner.nextInt();
          scanner.nextLine();

          System.out.print("Nombre del paciente: ");
          String nombre = scanner.nextLine();

          System.out.print("Dirección: ");
          String direccion = scanner.nextLine();

          System.out.print("Localidad de nacimiento: ");
          String localidadNacimiento = scanner.nextLine();

          System.out.print("Provincia de nacimiento: ");
          String provinciaNacimiento = scanner.nextLine();

          Localidad nacimiento = new Localidad(localidadNacimiento, provinciaNacimiento);

          System.out.print("Localidad de residencia: ");
          String localidadResidencia = scanner.nextLine();

          System.out.print("Provincia de residencia: ");
          String provinciaResidencia = scanner.nextLine();

          Localidad residencia = new Localidad(localidadResidencia, provinciaResidencia);

          Paciente paciente = new Paciente(numeroRegistro, nombre, direccion, residencia, nacimiento);
          hospital.consultaDatosFiliatorios(paciente);
          break;
        case 2:
          System.out.println("Saliendo del programa.");
          scanner.close();
        default:
          System.out.println("Opción no válida. Intente de nuevo.");
      }
    }
  }
}
