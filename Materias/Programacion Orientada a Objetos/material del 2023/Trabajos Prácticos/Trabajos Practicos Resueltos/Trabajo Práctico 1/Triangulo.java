// Crear clase ejecutable “Triangulo”, declarar las variables a, b y c de tipo double, 
// que corresponden a los lados de un triángulo. Los valores deben ser ingresados por teclado
// como argumentos del método main(). Calcular y mostrar el semiperímetro y el área del triángulo.
//  semiperimetro= (a+b+c)/2 
//  area= raíz cuadrada(semiperimetro*(semiperimetro-a)*(semiperimetro-b)*(semiperimetro-c))

public class Triangulo {
  public static void main(String[] args) {
    if (args.length != 3) {
      System.out.println("Debe ingresar tres argumentos válidos: los lados del triángulo.");
      return;
    }
    double a, b, c;
    a = Double.parseDouble(args[0]);
    b = Double.parseDouble(args[1]);
    c = Double.parseDouble(args[2]);

    if (a <= 0 || b <= 0 || c <= 0) {
      System.out.println("Los lados del triángulo deben ser valores positivos.");
      return;
    }
    double semiperimetro = (a + b + c) / 2;
    double area = calcularAreaTriangulo(semiperimetro, a, b, c);

    System.out.println("El semiperímetro del triángulo es: " + semiperimetro);
    System.out.println("El área del triángulo es: " + area);
  }

  public static double calcularAreaTriangulo(double pSemiPerimetro, double pLadoA, double pLadoB, double pLadoC) {
    return Math
        .sqrt((pSemiPerimetro * (pSemiPerimetro - pLadoA) * (pSemiPerimetro - pLadoB) * (pSemiPerimetro - pLadoC)));
  }
}
