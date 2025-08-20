
import java.time.LocalDate;
import java.util.Scanner;

/**
 * Clase principal que contiene el método main para crear y mostrar un objeto Empleado.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Main5 {
    /**
     * Método principal que pide al usuario los datos de un empleado, los utiliza para crear un objeto Empleado, y luego muestra la información del empleado.
     * @param args Los argumentos pasados a través de la línea de comandos.
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Solicitar datos al usuario
        System.out.print("Ingrese el nombre del empleado: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido del empleado: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el CUIL del empleado (sin guiones ni puntos): ");
        long cuil = scanner.nextLong();

        System.out.print("Ingrese el sueldo básico del empleado: ");
        double sueldoBasico = scanner.nextDouble();

        System.out.print("Ingrese el año de ingreso del empleado: ");
        int anio = scanner.nextInt();

        System.out.print("Ingrese el mes de ingreso del empleado (1-12): ");
        int mes = scanner.nextInt();

        System.out.print("Ingrese el día de ingreso del empleado: ");
        int dia = scanner.nextInt();

        LocalDate fechaIngreso = LocalDate.of(anio, mes, dia);

        // Crear un objeto Empleado con los datos proporcionados
        Empleado empleado = new Empleado(nombre, apellido, cuil, sueldoBasico, fechaIngreso);

        // Mostrar la información del empleado
        empleado.mostrar();
        System.out.println(empleado.mostrarLinea());

        // Cerrar el scanner
        scanner.close();
    }
}


