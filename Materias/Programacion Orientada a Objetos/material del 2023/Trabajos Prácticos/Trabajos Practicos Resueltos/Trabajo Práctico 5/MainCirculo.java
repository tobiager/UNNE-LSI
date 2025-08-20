public class MainCirculo {
  public static void main(String[] args) {
    Punto punto = new Punto(5.0, 3.0);
    Elipse elipse = new Elipse(20.44, 46.86, punto);
    Circulo circulo = new Circulo(10.0, punto);

    elipse.caracteristicas();

    System.out.println();

    circulo.caracteristicas();

    System.out.println();

    elipse.desplazar(2.0, 2.0);
    circulo.desplazar(2.0, 2.0);

    System.out.println("Después de desplazar:");

    elipse.caracteristicas();

    System.out.println();

    circulo.caracteristicas();
  }
}
