import java.util.Scanner;

/**
 * Write a description of class Circunferencia here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Circunferencia {
    public static void main(String[] args) {
        Scanner texto = new Scanner(System.in);
  
        System.out.print("Escriba el radio del circulo: ");
         
        double radio =  texto.nextDouble();
        
        
        while (radio > 0){
        double perimetro = 2 * Math.PI * radio;

                
        System.out.println("El radio de la circunferencia es: " + radio);
        System.out.println("El perímetro de la circunferencia es: " + perimetro);
            
        radio = radio-1;
    }
  } 
}

