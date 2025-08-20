public class Punto {
  private double x;
  private double y;

  /**
   * Constructor de la clase Punto.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pX Inicializa la coordenadas "x"
   * @param pY Inicializa la coordenadas "y"
   */
  public Punto(double pX, double pY) {
    this.setX(pX);
    this.setY(pY);
  }

  /**
   * Constructor de la clase Punto.
   * Inicializa las coordenadas "x" e "y" del punto en 0.
   */
  public Punto() {
    this.setX(0.0);
    this.setY(0.0);
  }

  /**
   * El método establece el valor de la variable "x" proporcionado del valor
   * "pX".
   * 
   * @param pX Es un valor doble que representa el nuevo valor de la variable "x".
   */
  private void setX(double pX) {
    this.x = pX;
  }

  /**
   * El método establece el valor de la variable "y" proporcionado del valor
   * "pY".
   * 
   * @param pY Es un valor doble que representa el nuevo valor de la variable "y".
   */
  private void setY(double pY) {
    this.y = pY;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "x".
   */
  public double getX() {
    return this.x;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "y".
   */
  public double getY() {
    return this.y;
  }

  /**
   * El método "desplazar" Actualiza las coordenadas de las variables "x" e "y"
   * sumando los valores pasados como parámetros.
   *
   * @param pX La cantidad en la que el objeto debe moverse horizontalmente.
   * @param pY La cantidad en la que el objeto debe moverse verticalmente.
   */
  public void desplazar(double pX, double pY) {
    this.setX(this.getX() + pX);
    this.setY(this.getY() + pY);
  }

  /**
   * El método "coordenadas" Devuelve una cadena de caracteres de las coordenadas
   * (x, y).
   *
   * @return Devuelve una cadena de caracteres de las coordenadas en el formato
   *         "(x, y)".
   */
  public String coordenadas() {
    return "(" + this.getX() + ", " + this.getY() + ")";
  }

  /**
   * El método "mostrar" Muestra las coordenadas "x" e "y" del punto.
   */
  public void mostrar() {
    System.out.println("Punto. X: " + this.getX() + ", Y: " + this.getY());
  }

  /**
   * Calcula la distancia entre este punto y otro punto dado.
   * Distancia = √(x1 - x2)² + (y1 - y2)²
   *
   * @param pPunto El punto con el que se calculará la distancia.
   * @return Devuelve la distancia entre el punto actual y el punto pasado como
   *         parámetro.
   */
  public double distanciaA(Punto pPunto) {
    double x = Math.pow(pPunto.getX() - this.getX(), 2.0);
    double y = Math.pow(pPunto.getY() - this.getY(), 2.0);
    return Math.sqrt(x + y);
  }
}
