
/**
 * Write a description of class Empresa here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Scanner;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 * La clase Empresa gestiona la información de los empleados,
 * permitiendo agregar y quitar empleados de una lista.
 */
public class Empresa {
    static ArrayList<Empleado> empleados = new ArrayList<>();

    /**
     * Método principal que se ejecuta al iniciar la aplicación.
     * Permite ingresar información sobre un empleado y agregarlo
     * a la lista de empleados.
     *
     * @param args Argumentos de línea de comandos (no utilizados).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Ingrese el DNI: ");
        int dni = scanner.nextInt();
        scanner.nextLine(); // Consumir el salto de línea

        System.out.print("Ingrese el nombre: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el año de nacimiento: ");
        int year = scanner.nextInt();

        System.out.print("dni ingresado:" + dni + " -Ingrese el Cuil: ");
        long cuil = scanner.nextLong();

        System.out.print("Ingrese sueldo básico: ");
        double sueldoB = scanner.nextDouble();

        System.out.print("Ingrese el año de ingreso al trabajo: ");
        int anio = scanner.nextInt();

        System.out.print("Ingrese el mes de ingreso al trabajo (1-12): ");
        int mes = scanner.nextInt();

        System.out.print("Ingrese el día de ingreso al trabajo: ");
        int dia = scanner.nextInt();
        scanner.nextLine();

        LocalDate fechaIngre = LocalDate.of(anio, mes, dia);

        Persona em;
        Empleado Per;

        em = new Persona(dni, nombre, apellido, year);
        Per = new Empleado(dni, nombre, apellido, year, cuil, sueldoB, fechaIngre);
        System.out.println("\n");
        agregarEmpleado(Per);
        // Muestra la información de todos los empleados
        for (Empleado emple : empleados) {
            Per.mostrar();
    
        }
    
    }

    /**
     * Agrega un empleado a la lista de empleados.
     *
     * @param p_empleado El empleado a agregar.
     * @return true si el empleado se agregó correctamente, false en caso contrario.
     */
    public static boolean agregarEmpleado(Empleado p_empleado) {
        return empleados.add(p_empleado);
    }

    /**
     * Quita un empleado de la lista de empleados.
     *
     * @param p_empleado El empleado a quitar.
     * @return true si el empleado se quitó correctamente, false en caso contrario.
     */
    public static boolean quitarEmpleado(Empleado p_empleado) {
        return empleados.remove(p_empleado);
    }
}

