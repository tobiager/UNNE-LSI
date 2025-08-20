
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class Empresa {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        // Ingreso de datos del empleado
        System.out.print("Ingrese el nombre del empleado: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido del empleado: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el CUIL del empleado: ");
        long cuil = scanner.nextLong();

        System.out.print("Ingrese el sueldo básico del empleado: ");
        double sueldoBasico = scanner.nextDouble();

        scanner.nextLine(); // Consumir la nueva línea

        System.out.print("Ingrese la fecha de ingreso (dd/MM/yyyy): ");
        String fechaIngresoStr = scanner.nextLine();
        LocalDate fechaIngreso = LocalDate.parse(fechaIngresoStr, formatter);

        // Crear objeto Empleado
        Empleado empleado = new Empleado(nombre, apellido, cuil, sueldoBasico, fechaIngreso);

        // Mostrar información del empleado
        empleado.mostrar();

        // Verificar si es aniversario de ingreso
        if (empleado.esAniversario()) {
            System.out.println("¡Felicidades! Hoy es el aniversario de ingreso de " + empleado.getNombre() + ".");
        } else {
            System.out.println("Hoy no es el aniversario de ingreso de " + empleado.getNombre() + ".");
        }

        scanner.close();
    }
}

