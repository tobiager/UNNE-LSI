import java.util.Scanner;
// Crear una clase ejecutable denominada “Circunferencia”, en la que se calcule el 
// perímetro de una circunferencia, ingresando el radio de tipo entero a través del
// argumento del main().

public class Circunferencia7 {
  public static void main(String[] args) {
    Scanner teclado = new Scanner(System.in);
    char continuar = 's';

    while (continuar == 's' || continuar == 'S') {
      System.out.print("Ingresa el radio de la circunferencia: ");
      int radio = teclado.nextInt();

      double perimetro = Math.PI * radio * 2;

      System.out.println("El perímetro de la circunferencia es: " + perimetro);
      System.out.print("¿Deseas calcular otro perímetro? (S/n): ");
      continuar = teclado.next().charAt(0);
    }
  }
}
