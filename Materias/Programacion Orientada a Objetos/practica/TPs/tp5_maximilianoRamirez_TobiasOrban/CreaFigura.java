import java.util.ArrayList;
import java.util.Scanner;

/**
 * La clase CreaFigura permite crear, manipular y comparar círculos y rectángulos.
 * Se solicita al usuario que ingrese datos para los círculos y luego se crean rectángulos
 * con dimensiones aleatorias. Se calculan distancias entre figuras y se determinan
 * cuáles son mayores según su área.
 */
public class CreaFigura {
    static ArrayList<Rectangulo> figuras=new ArrayList<>();
    static ArrayList<Elipse> figuras2=new ArrayList<>();
    /**
     * Método principal que ejecuta la creación y manipulación de figuras geométricas (círculos y rectángulos).
     * 
     * @param args Argumentos de la línea de comandos (no utilizados en este programa).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("ingrese coordenada x:");
        double x=scanner.nextDouble();
        
        System.out.println("ingrese coordenada y:");
        double y=scanner.nextDouble();
        
        Punto pu=new Punto(x, y);
        
        System.out.println("ingrese ancho del rectangulo:");
        double ancho=scanner.nextDouble();
        
        System.out.println("ingrese alto del rectangulo:");
        double alto=scanner.nextDouble();
        scanner.nextLine();
        
        Rectangulo rec= new Rectangulo(pu, ancho, alto);
        figuras.add(rec);
        
        System.out.println("ingrese segunda coordenada x:");
        double x2=scanner.nextDouble();
        
        System.out.println("ingrese segunda coordenada y:");
        double y2=scanner.nextDouble();
        
        Punto pu2=new Punto(x2, y2);
        
        System.out.println("ingrese lado del cuadrado:");
        double lado=scanner.nextDouble();
        scanner.nextLine();
        
        Cuadrado cuadrado= new Cuadrado(pu2, lado);
        figuras.add(cuadrado);
        
        for (Rectangulo figura : figuras) {
            figura.caracteristicas();
            System.out.println(); // Espacio entre figuras
        }
        
        System.out.println("ingrese tercera coordenada x:");
        double x3=scanner.nextDouble();
        
        System.out.println("ingrese tercera coordenada y:");
        double y3=scanner.nextDouble();
        
        Punto pu3=new Punto(x2, y2);
        
        System.out.println("ingrese semieje mayor del Elipse:");
        double semiEjeMa=scanner.nextDouble();
        
        System.out.println("ingrese semieje menor del Elipse:");
        double semiEjeMe=scanner.nextDouble();
        scanner.nextLine();
        
        Elipse el=new Elipse(semiEjeMa, semiEjeMe, pu3);   
        figuras2.add(el);
        
        System.out.println("ingrese cuarta coordenada x:");
        double x4=scanner.nextDouble();
        
        System.out.println("ingrese cuarta coordenada y:");
        double y4=scanner.nextDouble();
        
        Punto pu4=new Punto(x2, y2);
        
        System.out.println("ingrese radio del circulo:");
        double radio=scanner.nextDouble();
        scanner.nextLine();
        
        Circulo cir=new Circulo(radio, pu4);
        figuras2.add(cir);
        
        for (Elipse figura : figuras2) {
            figura.caracteristicas();
            System.out.println(); // Espacio entre figuras
        }
        scanner.close();
    }
    
}





