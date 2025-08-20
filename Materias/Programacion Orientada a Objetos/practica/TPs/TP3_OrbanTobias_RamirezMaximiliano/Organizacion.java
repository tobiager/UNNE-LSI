import java.util.Calendar;
import java.util.Scanner;

public class Organizacion {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Datos del Gerente General
        System.out.print("Ingrese el CUIL del Gerente General: ");
        long cuilGerente = scanner.nextLong();
        scanner.nextLine(); // Consumir nueva línea

        System.out.print("Ingrese el apellido del Gerente General: ");
        String apellidoGerente = scanner.nextLine();

        System.out.print("Ingrese el nombre del Gerente General: ");
        String nombreGerente = scanner.nextLine();

        System.out.print("Ingrese el sueldo básico del Gerente General: ");
        double sueldoGerente = scanner.nextDouble();

        Calendar fechaIngresoGerente = Calendar.getInstance();
        System.out.print("Ingrese el año de ingreso del Gerente General: ");
        fechaIngresoGerente.set(Calendar.YEAR, scanner.nextInt());
        fechaIngresoGerente.set(Calendar.MONTH, 0); 
        fechaIngresoGerente.set(Calendar.DAY_OF_MONTH, 1);

        EmpleadoConJefe gerenteGeneral = new EmpleadoConJefe(cuilGerente, apellidoGerente, nombreGerente, sueldoGerente, fechaIngresoGerente);

        // Datos del empleado
        System.out.print("Ingrese el CUIL del empleado: ");
        long cuilEmpleado = scanner.nextLong();
        scanner.nextLine(); 

        System.out.print("Ingrese el apellido del empleado: ");
        String apellidoEmpleado = scanner.nextLine();

        System.out.print("Ingrese el nombre del empleado: ");
        String nombreEmpleado = scanner.nextLine();

        System.out.print("Ingrese el sueldo básico del empleado: ");
        double sueldoEmpleado = scanner.nextDouble();

        Calendar fechaIngresoEmpleado = Calendar.getInstance();
        System.out.print("Ingrese el año de ingreso del empleado: ");
        fechaIngresoEmpleado.set(Calendar.YEAR, scanner.nextInt());
        fechaIngresoEmpleado.set(Calendar.MONTH, 0); 
        fechaIngresoEmpleado.set(Calendar.DAY_OF_MONTH, 1);

        EmpleadoConJefe empleado = new EmpleadoConJefe(cuilEmpleado, apellidoEmpleado, nombreEmpleado, sueldoEmpleado, fechaIngresoEmpleado, gerenteGeneral);

        // Mostrar menú de opciones
        int opcion;
        do {
            System.out.println("\n--- Menú de opciones ---");
            System.out.println("1. Mostrar información del Gerente General");
            System.out.println("2. Mostrar información del Empleado");
            System.out.println("3. Emitir permiso de salida");
            System.out.println("4. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    gerenteGeneral.mostrarPantalla();
                    break;
                case 2:
                    empleado.mostrarPantalla();
                    break;
                case 3:
                    System.out.println(empleado.emitirPermisoSalida());
                    break;
                case 4:
                    System.out.println("Saliendo del programa...");
                    break;
                default:
                    System.out.println("Opción no válida, intente de nuevo.");
            }
        } while (opcion != 4);

        scanner.close();
    }
}


