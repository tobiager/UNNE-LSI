// Crear una clase ejecutable denominada “Circunferencia”, en la que se calcule el 
// perímetro de una circunferencia, ingresando el radio de tipo entero a través del
// argumento del main().

public class Circunferencia3 {
  public static void main(String[] args) {
    int radio = Integer.parseInt(args[0]);
    System.out.println(radio * 2 * Math.PI);
    // Ejecutar asi => java Circunferencia.java 12
  }
}
