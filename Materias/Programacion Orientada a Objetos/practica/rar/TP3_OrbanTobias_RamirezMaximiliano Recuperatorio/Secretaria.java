import java.util.Scanner;

/**
 * La clase Secretaria contiene el método main para interactuar con la consola,
 * permitiendo la creación de una escuela, un docente y la impresión de un recibo de sueldo.
 */
public class Secretaria {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Crear la escuela
        System.out.println("Ingrese el nombre de la escuela:");
        String nombreEscuela = scanner.nextLine();
        System.out.println("Ingrese el domicilio de la escuela:");
        String domicilioEscuela = scanner.nextLine();
        System.out.println("Ingrese el nombre del director de la escuela:");
        String directorEscuela = scanner.nextLine();

        Escuela escuela = new Escuela(nombreEscuela, domicilioEscuela, directorEscuela);

        // Crear el docente
        System.out.println("Ingrese el nombre del docente:");
        String nombreDocente = scanner.nextLine();
        System.out.println("Ingrese el grado del docente:");
        String gradoDocente = scanner.nextLine();
        System.out.println("Ingrese el sueldo básico del docente:");
        double sueldoBasico = scanner.nextDouble();
        System.out.println("Ingrese la asignación familiar del docente:");
        double asignacionFamiliar = scanner.nextDouble();

        Docente docente = new Docente(nombreDocente, gradoDocente, sueldoBasico, asignacionFamiliar);

        // Imprimir recibo
        escuela.imprimirRecibo(docente);

        // Cerrar el scanner
        scanner.close();
    }
}
