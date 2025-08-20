//  Crear una clase denominada “Ecuación” que calcule las raíces reales de una
// ecuación de segundo grado. Los valores de los coeficientes a, b y c se ingresarán
// por teclado como argumentos del método main(). Considerar que si el discriminante > 0
// se deben calcular las 2 raíces, si el discriminante = 0 se debe calcular una sola raíz,
// especificando por pantalla que x1 = x2. En caso de ser negativo, mostrar un mensaje indicando
// que se encuentra frente a una solución compleja (numero imaginario).

public class Ecuacion {
  public static void main(String[] args) {
    double a, b, c;
    a = Double.parseDouble(args[0]);
    b = Double.parseDouble(args[1]);
    c = Double.parseDouble(args[2]);
    double discriminante = b * b - 4 * a * c;

    if (discriminante > 0) {
      double x1 = (-b + Math.sqrt(discriminante)) / (2 * a);
      double x2 = (-b - Math.sqrt(discriminante)) / (2 * a);
      System.out.println("x1 = " + x1 + " y x2 = " + x2);
    } else if (discriminante == 0) {
      double x1 = (-b + Math.sqrt(discriminante)) / (2 * a);
      System.out.println("x1 = x2 => " + x1);
    } else if (discriminante < 0) {
      System.out.println("La ecuación tiene solución compleja");
    }
  }
}
