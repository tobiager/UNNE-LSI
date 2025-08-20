import java.util.Scanner;

/**
 * Write a description of class TrianguloRectangulo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class TrianguloRectangulo{
    public static void main(String args []){
      
    
    Scanner texto = new Scanner(System.in);
  
    System.out.print("Escriba tres lados del triangulo: ");
    double cateto1 = texto.nextDouble();
    double cateto2 = texto.nextDouble();
    double hipotenusa = texto.nextDouble();

    
    if ((hipotenusa * hipotenusa) == ((cateto1 * cateto1)+(cateto2 * cateto2))){
        
    System.out.print("El triangulo es Rectangulo ");
    
    
    }else
     System.out.print("El triangulo no es Rectangulo ");
  } 
}
