import java.util.Scanner;

/**
 * Write a description of class Ecuacion here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Ecuacion{
    public static void main(String[] args){
    if (args.length == 3) {
       
    
    double a = Double.parseDouble(args[0]);
    double b = Double.parseDouble(args[1]);
    double c = Double.parseDouble(args[2]);
    
    double discriminante = ((b * b)- 4 * a * c);
    
    
       
     if (discriminante > 0){
        double raiz1= (-b + Math.sqrt(b * b - 4 * a * c))/2 * a;
        double raiz2= (-b - Math.sqrt(b * b - 4 * a * c))/2 * a;
        System.out.print("La raiz 1 es: "+ raiz1 +" La raiz 2 es:"+ raiz2);
    
     }else if (discriminante == 0){
        System.out.print("La raiz 1 y 2 son: "+ discriminante);
     }else if(discriminante < 0){
      System.out.print("se encuentra frente a una solución compleja (numero imaginario)");
    }
  }else{
    System.out.print("error, ingresar 3 numeros");
 }
}
}