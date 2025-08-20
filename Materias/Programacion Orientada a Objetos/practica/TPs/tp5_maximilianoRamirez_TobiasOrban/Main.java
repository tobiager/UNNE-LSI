import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Elipse> figuras = new ArrayList<>();
        int opcion;

        do {
            System.out.println("Menú:");
            System.out.println("1. Agregar Círculo");
            System.out.println("2. Agregar Elipse");
            System.out.println("3. Mostrar Figuras");
            System.out.println("4. Quitar Figura");
            System.out.println("5. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    System.out.print("Ingrese el radio del círculo: ");
                    double radio = scanner.nextDouble();
                    System.out.print("Ingrese las coordenadas del centro (x, y): ");
                    double xCirculo = scanner.nextDouble();
                    double yCirculo = scanner.nextDouble();
                    figuras.add(new Circulo(radio, new Punto(xCirculo, yCirculo)));
                    break;

                case 2:
                    System.out.print("Ingrese el semieje mayor de la elipse: ");
                    double semiejeMayor = scanner.nextDouble();
                    System.out.print("Ingrese el semieje menor de la elipse: ");
                    double semiejeMenor = scanner.nextDouble();
                    System.out.print("Ingrese las coordenadas del centro (x, y): ");
                    double xElipse = scanner.nextDouble();
                    double yElipse = scanner.nextDouble();
                    figuras.add(new Elipse(semiejeMayor, semiejeMenor, new Punto(xElipse, yElipse)));
                    break;

                case 3:
                    if (figuras.isEmpty()) {
                        System.out.println("No hay figuras para mostrar.");
                    } else {
                        for (int i = 0; i < figuras.size(); i++) {
                            System.out.printf("%d: ", i + 1);
                            figuras.get(i).caracteristicas();
                        }
                    }
                    break;

                case 4:
                    if (figuras.isEmpty()) {
                        System.out.println("No hay figuras para quitar.");
                    } else {
                        System.out.println("Seleccione el número de la figura a quitar:");
                        for (int i = 0; i < figuras.size(); i++) {
                            System.out.printf("%d: ", i + 1);
                            figuras.get(i).caracteristicas();
                        }
                        int index = scanner.nextInt() - 1; // Restar 1 para ajustar el índice
                        if (index >= 0 && index < figuras.size()) {
                            figuras.remove(index);
                            System.out.println("Figura quitada exitosamente.");
                        } else {
                            System.out.println("Número de figura no válido.");
                        }
                    }
                    break;

                case 5:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opción no válida. Intente nuevamente.");
            }
            System.out.println();
        } while (opcion != 5);

        scanner.close();
    }
}




