import java.util.Random;
import java.util.Scanner;

/**
 * La clase CreaFigura permite crear, manipular y comparar círculos y rectángulos.
 * Se solicita al usuario que ingrese datos para los círculos y luego se crean rectángulos
 * con dimensiones aleatorias. Se calculan distancias entre figuras y se determinan
 * cuáles son mayores según su área.
 */
public class CreaFigura {

    /**
     * Método principal que ejecuta la creación y manipulación de figuras geométricas (círculos y rectángulos).
     * 
     * @param args Argumentos de la línea de comandos (no utilizados en este programa).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        // Solicitar datos para el primer círculo
        System.out.println("Ingrese el radio del primer círculo:");
        double radio1 = scanner.nextDouble();
        System.out.println("Ingrese las coordenadas del centro del primer círculo (x y):");
        double x1 = scanner.nextDouble();
        double y1 = scanner.nextDouble();

        // Crear el primer círculo con los datos ingresados
        Circulo circulo1 = new Circulo(radio1, new Punto(x1, y1));

        // Solicitar datos para el segundo círculo
        System.out.println("Ingrese el radio del segundo círculo:");
        double radio2 = scanner.nextDouble();
        System.out.println("Ingrese las coordenadas del centro del segundo círculo (x y):");
        double x2 = scanner.nextDouble();
        double y2 = scanner.nextDouble();

        // Crear el segundo círculo con los datos ingresados
        Circulo circulo2 = new Circulo(radio2, new Punto(x2, y2));

        // Solicitar el desplazamiento para el primer círculo
        System.out.println("Ingrese el desplazamiento para el primer círculo (dx dy):");
        double dx = scanner.nextDouble();
        double dy = scanner.nextDouble();

        // Desplazar el primer círculo
        circulo1.desplazar(dx, dy);

        // Mostrar las características del primer círculo
        System.out.println(" ");
        System.out.println("Características del primer círculo:");
        circulo1.caracteristicas();

        // Mostrar las características del segundo círculo
        System.out.println(" ");
        System.out.println("Características del segundo círculo:");
        circulo2.caracteristicas();

        // Mostrar el mayor de los dos círculos
        System.out.println(" ");
        Circulo mayorCirculo = circulo1.elMayor(circulo2);
        System.out.println("El mayor de los dos círculos es:");
        mayorCirculo.caracteristicas();

        // Mostrar la distancia entre los dos círculos
        double distanciaCirculos = circulo1.distanciaA(circulo2);
        System.out.printf("La distancia entre los dos círculos es: %.2f unidades.%n", distanciaCirculos);

        // Crear el primer rectángulo con dimensiones aleatorias
        double ancho1 = random.nextDouble() * 100; // Ancho aleatorio entre 0 y 100
        double alto1 = random.nextDouble() * 100;  // Alto aleatorio entre 0 y 100
        Rectangulo rect1 = new Rectangulo(ancho1, alto1);

        // Desplazar el primer rectángulo
        rect1.desplazar(40, 20);

        // Mostrar las características del primer rectángulo
        System.out.println(" ");
        System.out.println(" ");
        System.out.println("Características del primer rectángulo:");
        rect1.caracteristicas();

        // Crear el segundo rectángulo con origen en el punto (7.4, 4.5) y dimensiones aleatorias
        double ancho2 = random.nextDouble() * 100; // Ancho aleatorio entre 0 y 100
        double alto2 = random.nextDouble() * 100;  // Alto aleatorio entre 0 y 100
        Punto origen2 = new Punto(7.4, 4.5);
        Rectangulo rect2 = new Rectangulo(origen2, ancho2, alto2);

        // Mostrar las características del segundo rectángulo
        System.out.println(" ");
        System.out.println("Características del segundo rectángulo:");
        rect2.caracteristicas();

        // Determinar el mayor rectángulo y mostrar características
        Rectangulo mayorRectangulo = rect1.elMayor(rect2);
        System.out.println(" ");
        System.out.println("El mayor de los dos rectángulos es:");
        mayorRectangulo.caracteristicas();

        // Calcular y mostrar la distancia entre los dos rectángulos
        double distanciaRectangulos = rect1.distanciaA(rect2);
        System.out.printf("La distancia entre los dos rectángulos es: %.2f unidades.%n", distanciaRectangulos);

        // Cerrar el scanner
        scanner.close();
    }
}





