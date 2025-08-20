
/**
 * Write a description of class Triangulo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Triangulo {
    public static void main(String[] args) {
        
        if (args.length == 3) {
            
                
                double a = Double.parseDouble(args[0]);
                double b = Double.parseDouble(args[1]);
                double c = Double.parseDouble(args[2]);

                
                double semiperimetro = (a + b + c) / 2;

                
                double area = Math.sqrt(semiperimetro * (semiperimetro - a) * (semiperimetro - b) * (semiperimetro - c));

                
                System.out.println("El semiperímetro del triángulo es: " + semiperimetro);
                System.out.println("El área del triángulo es: " + area);
            
        } else {
        
               System.out.println("Por favor, ingrese tres números como lados del triángulo.");
        }
    }
}

