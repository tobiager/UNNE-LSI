import java.util.ArrayList;
import java.util.Scanner;

/**
 * La clase Administracion es responsable de la interacción del usuario 
 * para la creación de un jardín con figuras geométricas, como rectángulos 
 * y elipses. Permite al usuario ingresar las coordenadas y dimensiones 
 * de las figuras que se añadirán al jardín.
 * 
 * @author (tu nombre)
 * @version (número de versión o fecha)
 */
public class Administracion {
    
    /** Lista que almacena las figuras geométricas en el jardín. */
    static ArrayList<figuraGeometrica> figuras = new ArrayList<>();

    /**
     * Método principal que inicia la aplicación y gestiona la entrada 
     * del usuario para crear un jardín y añadir figuras geométricas.
     * 
     * @param args Argumentos de línea de comandos (no se utilizan en esta aplicación).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Ingreso nombre del jardín
        System.out.println("\n ingrese nombre del jardin:");
        String nombre = scanner.nextLine();
        
        // Agrego un rectángulo
        System.out.println("ingrese coordenada x:");
        double x = scanner.nextDouble();
        
        System.out.println("ingrese coordenada y:");
        double y = scanner.nextDouble();
        
        Punto pu = new Punto(x, y);
        
        System.out.println("ingrese ancho del rectángulo:");
        double ancho = scanner.nextDouble();
        
        System.out.println("ingrese alto del rectángulo:");
        double alto = scanner.nextDouble();
        scanner.nextLine();
        
        Rectangulo rec = new Rectangulo(pu, ancho, alto);
        Jardin ja = new Jardin(nombre, figuras, rec);
        
        // Agrego una elipse
        System.out.println("ingrese segunda coordenada x:");
        double x2 = scanner.nextDouble();
        
        System.out.println("ingrese segunda coordenada y:");
        double y2 = scanner.nextDouble();
        
        Punto pu2 = new Punto(x2, y2);
        
        System.out.println("ingrese semieje mayor del Elipse:");
        double semiEjeMa = scanner.nextDouble();
        
        System.out.println("ingrese semieje menor del Elipse:");
        double semiEjeMe = scanner.nextDouble();
        scanner.nextLine();
        
        Elipse el = new Elipse(semiEjeMa, semiEjeMe, pu2);   
        Jardin ja2 = new Jardin(nombre, figuras, el);
        
        ja2.detalleFiguras();
    }
}

