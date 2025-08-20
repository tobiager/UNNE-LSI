// Crear una clase denominada TrianguloRectangulo, en la que se determine si un triangulo es rectángulo (Teorema de Pitágoras → h² = cateto1²+ cateto2²). Los lados se deben ingresar 
// por teclado, utilizando el argumento del main().

public class TrianguloRectangulo {
  public static void main(String[] args) {
    double lados, h, cateto1, cateto2;
    h = Double.parseDouble(args[0]);
    cateto1 = Double.parseDouble(args[1]);
    cateto2 = Double.parseDouble(args[2]);
    lados = Math.pow(cateto1, 2) + Math.pow(cateto2, 2);
    System.out.println(Math.pow(h, 2) + " == " + lados);
  }
}
