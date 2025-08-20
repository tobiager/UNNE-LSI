public class MainCuadrado {
  public static void main(String[] args) {
    Punto puntoOrigen = new Punto(5.0, 3.0);
    double ladoCuadrado = 72.99;
    Cuadrado cuadrado = new Cuadrado(puntoOrigen, ladoCuadrado);
    cuadrado.características();
  }
}
