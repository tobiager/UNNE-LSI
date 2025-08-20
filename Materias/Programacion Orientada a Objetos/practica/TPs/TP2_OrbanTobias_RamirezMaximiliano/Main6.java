import java.util.Scanner;

/**
 * Clase principal que contiene el método main para interactuar con la clase Punto.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Main6 {

    /**
     * Método principal que solicita al usuario las coordenadas de un punto y un desplazamiento, luego muestra las coordenadas resultantes.
     * @param args Los argumentos pasados a través de la línea de comandos.
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Solicitar las coordenadas iniciales del punto
        System.out.print("Ingrese la coordenada X del punto: ");
        double x = scanner.nextDouble();

        System.out.print("Ingrese la coordenada Y del punto: ");
        double y = scanner.nextDouble();

        // Crear un objeto Punto con las coordenadas dadas
        Punto punto2 = new Punto(x, y);
        punto2.mostrar();

        // Solicitar el desplazamiento en las coordenadas X e Y
        System.out.print("Ingrese el desplazamiento en X: ");
        double dx = scanner.nextDouble();

        System.out.print("Ingrese el desplazamiento en Y: ");
        double dy = scanner.nextDouble();

        // Desplazar el punto y mostrar las nuevas coordenadas
        punto2.desplazar(dx, dy);
        punto2.mostrar();

        // Mostrar las coordenadas en formato (X, Y)
        System.out.println("Coordenadas del punto: " + punto2.coordenadas());

        // Cerrar el scanner
        scanner.close();
    }
}


