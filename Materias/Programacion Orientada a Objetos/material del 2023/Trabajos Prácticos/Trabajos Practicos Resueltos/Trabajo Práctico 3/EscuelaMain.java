import java.util.Scanner;

public class EscuelaMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Escuela escuela = new Escuela("Manuel Belgrano", "Irigoyen 1580", "Leopoldo Juez");
        int opcion = 0;

        while (opcion != 2) {
            System.out.println("\nMenú:");
            System.out.println("1. Imprimir recibo para un docente");
            System.out.println("2. Salir");

            System.out.print("Selecciona una opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    System.out.print("Ingrese el nombre completo del docente: ");
                    scanner.nextLine();
                    String nombre = scanner.nextLine();

                    System.out.print("Ingrese el número de empleado: ");
                    String numeroEmpleado = scanner.nextLine();

                    System.out.print("Ingrese el salario base: ");
                    double salarioBase = scanner.nextDouble();

                    System.out.print("Ingrese la asignacion familiar: ");
                    double bonoAdicional = scanner.nextDouble();

                    Docente docente = new Docente(nombre, numeroEmpleado, salarioBase, bonoAdicional);
                    escuela.imprimirRecibo(docente);
                    break;
                case 2:
                    System.out.println("Saliendo del programa.");
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("Opción no válida. Por favor, seleccione una opción válida.");
                    break;
            }
        }
    }
}
