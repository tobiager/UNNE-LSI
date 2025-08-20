import java.util.Calendar;
import java.util.Scanner;

public class Organizacion {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        EmpleadoConJefe gerenteGeneral = null;
        EmpleadoConJefe empleado = null;

        int opcion;
        do {
            System.out.println("\n--- Menú de opciones ---");
            System.out.println("1. Agregar empleado");
            System.out.println("2. Agregar gerente general");
            System.out.println("3. Mostrar información de un empleado");
            System.out.println("4. Mostrar información del gerente general");
            System.out.println("5. Emitir permiso de salida");
            System.out.println("6. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = scanner.nextInt();
            scanner.nextLine(); // Consumir la nueva línea

            switch (opcion) {
                case 1:
    if (empleado != null) {
        System.out.println("Ya existe un empleado.");
    } else if (gerenteGeneral != null) {
        System.out.println("Agregar un empleado (con gerente):");
        System.out.print("Ingrese el CUIL del empleado: ");
        long cuilEmpleado = scanner.nextLong();
        scanner.nextLine();

        System.out.print("Ingrese el apellido del empleado: ");
        String apellidoEmpleado = scanner.nextLine();

        System.out.print("Ingrese el nombre del empleado: ");
        String nombreEmpleado = scanner.nextLine();

        System.out.print("Ingrese el sueldo básico del empleado: ");
        double sueldoEmpleado = scanner.nextDouble();

        System.out.print("Ingrese el día de ingreso del empleado: ");
        int diaIngreso = scanner.nextInt();

        System.out.print("Ingrese el mes de ingreso del empleado (1-12): ");
        int mesIngreso = scanner.nextInt();

        System.out.print("Ingrese el año de ingreso del empleado: ");
        int anioIngreso = scanner.nextInt();

        // Crear instancia de Calendar para la fecha de ingreso
        Calendar fechaIngreso = Calendar.getInstance();
        fechaIngreso.set(anioIngreso, mesIngreso - 1, diaIngreso);

        empleado = new EmpleadoConJefe(cuilEmpleado, apellidoEmpleado, nombreEmpleado, sueldoEmpleado, fechaIngreso, gerenteGeneral);
        System.out.println("Empleado agregado con éxito.");
        } else {
        System.out.println("Agregar un empleado (sin gerente):");
        System.out.print("Ingrese el CUIL del empleado: ");
        long cuilEmpleado = scanner.nextLong();
        scanner.nextLine();

        System.out.print("Ingrese el apellido del empleado: ");
        String apellidoEmpleado = scanner.nextLine();

        System.out.print("Ingrese el nombre del empleado: ");
        String nombreEmpleado = scanner.nextLine();

        System.out.print("Ingrese el sueldo básico del empleado: ");
        double sueldoEmpleado = scanner.nextDouble();

        System.out.print("Ingrese el año de ingreso del empleado: ");
        int anioIngreso = scanner.nextInt();

        empleado = new EmpleadoConJefe(cuilEmpleado, apellidoEmpleado, nombreEmpleado, sueldoEmpleado, anioIngreso);
        System.out.println("Empleado agregado con éxito.");
    }
    break;


                case 2:
                    if (gerenteGeneral != null) {
                        System.out.println("Ya existe un gerente general.");
                    } else {
                        System.out.println("Agregar gerente general:");
                        System.out.print("Ingrese el CUIL del gerente general: ");
                        long cuilGerente = scanner.nextLong();
                        scanner.nextLine();

                        System.out.print("Ingrese el apellido del gerente general: ");
                        String apellidoGerente = scanner.nextLine();

                        System.out.print("Ingrese el nombre del gerente general: ");
                        String nombreGerente = scanner.nextLine();

                        System.out.print("Ingrese el sueldo básico del gerente general: ");
                        double sueldoGerente = scanner.nextDouble();

                        System.out.print("Ingrese el año de ingreso del gerente general: ");
                        int anioIngresoGerente = scanner.nextInt();

                        gerenteGeneral = new EmpleadoConJefe(cuilGerente, apellidoGerente, nombreGerente, sueldoGerente, anioIngresoGerente);
                        System.out.println("Gerente general agregado con éxito.");
                    }
                    break;

                case 3:
                    if (empleado == null) {
                        System.out.println("No hay un empleado registrado.");
                    } else {
                        System.out.println("Información del empleado:");
                        empleado.mostrarPantalla();
                    }
                    break;

                case 4:
                    if (gerenteGeneral == null) {
                        System.out.println("No hay un gerente general registrado.");
                    } else {
                        System.out.println("Información del gerente general:");
                        gerenteGeneral.mostrarPantalla();
                    }
                    break;

                case 5:
                    if (empleado == null) {
                        System.out.println("No hay un empleado registrado para emitir permiso.");
                    } else {
                        System.out.println("Permiso de salida emitido:");
                        System.out.println(empleado.emitirPermisoSalida());
                    }
                    break;

                case 6:
                    System.out.println("Saliendo del programa...");
                    break;

                default:
                    System.out.println("Opción no válida. Intente nuevamente.");
            }
        } while (opcion != 6);

        scanner.close();
    }
}



