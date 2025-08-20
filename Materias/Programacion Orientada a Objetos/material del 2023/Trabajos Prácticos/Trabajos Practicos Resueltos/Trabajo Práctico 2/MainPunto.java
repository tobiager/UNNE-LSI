public class MainPunto {
  public static void main(String[] args) {
    Punto punto = new Punto(7.5, 0.5);
    punto.mostrar();
    String string = punto.coordenadas();
    System.out.println(string);
    punto.desplazar(1, 1);
    punto.mostrar();
  }
}
