import java.util.Random;

public class CreaFigura2 {
  public static void main(String[] args) {
    Random unNumero = new Random();

    double alto = unNumero.nextDouble() * 100.0;
    double ancho = unNumero.nextDouble() * 100.0;
    Punto punto1 = new Punto();

    Rectangulo rectangulo = new Rectangulo(punto1, ancho, alto);

    rectangulo.desplazar(40, -20);
    rectangulo.caracteristicas();

    double alto2 = unNumero.nextDouble() * 100.0;
    double ancho2 = unNumero.nextDouble() * 100.0;
    Punto punto2 = new Punto(Double.parseDouble(args[0]), Double.parseDouble(args[1]));

    Rectangulo rectangulo2 = new Rectangulo(punto2, ancho2, alto2);

    rectangulo2.caracteristicas();

    Rectangulo mayor = rectangulo.elMayor(rectangulo2);
    System.out.println("Mayor Rectangulo: ");
    mayor.caracteristicas();

    rectangulo.distanciaA(rectangulo2);
  }
}
