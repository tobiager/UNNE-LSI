import java.text.DecimalFormat;

/**
 * Ejercicio 3 del Tp3, clase Circulo.
 * 
 * @author Olivarez Alexis E.
 */
public class Circulo {
  private double radio;
  private Punto centro;

  /**
   * Crea un nuevo objeto Circulo con el radio y centro especificados.
   * 
   * @param pRadio  El radio del círculo.
   * @param pCentro El centro del círculo.
   */
  Circulo(double pRadio, Punto pCentro) {
    this.setRadio(pRadio);
    this.setCentro(pCentro);
  }

  /**
   * El método establece el valor de la variable "radio" proporcionado del valor
   * "pRadio".
   * 
   * @param pRadio Es un valor doble que representa el nuevo valor de la variable
   *               "radio".
   */
  private void setRadio(double pRadio) {
    this.radio = pRadio;
  }

  /**
   * El método establece el valor de la variable "centro" proporcionado del valor
   * "pCentro".
   * 
   * @param pCentro Es un valor Objeto Punto que representa el nuevo valor de la
   *                variable "centro".
   */
  private void setCentro(Punto pCentro) {
    this.centro = pCentro;
  }

  /**
   * Obtiene el radio del círculo.
   *
   * @return El radio del círculo.
   */
  public double getRadio() {
    return this.radio;
  }

  /**
   * Obtiene el centro del círculo.
   *
   * @return El centro del círculo.
   */
  public Punto getCentro() {
    return this.centro;
  }

  /**
   * Calcula la superficie del círculo.
   * Superficie = PI * Radio²
   *
   * @return La superficie del círculo.
   */
  public double superficie() {
    return Math.PI * Math.pow(this.getRadio(), 2);
  }

  /**
   * Calcula el perímetro del círculo.
   * Perimetro = Radio * 2 * PI
   *
   * @return El perímetro del círculo.
   */
  public double perimetro() {
    return this.getRadio() * 2 * Math.PI;
  }

  /**
   * Muestra las características del círculo, incluyendo su centro, radio,
   * superficie y perímetro.
   */
  public void caracteristicas() {
    DecimalFormat df = new DecimalFormat("#.##");
    System.out.println("****** Circulo ******");
    System.out.println("Centro: " + this.getCentro().coordenadas() + " - Radio: " + this.getRadio());
    System.out.println("Superficie: " + df.format(this.superficie()) + " - Perimetro: " + df.format(this.perimetro()));
  }

  /**
   * Desplaza el centro del círculo por las cantidades dadas en las coordenadas X
   * e Y.
   *
   * @param pX La cantidad en la que el objeto debe moverse horizontalmente.
   * @param pY La cantidad en la que el objeto debe moverse verticalmente.
   */
  public void desplazar(double pX, double pY) {
    this.getCentro().desplazar(pX, pY);
  }

  /**
   * Calcula la distancia entre el centro de este círculo y el centro de otro
   * círculo dado.
   * Distancia = √(x1 - x2)² + (y1 - y2)²
   *
   * @param otroCirculo El otro círculo con el que se calculará la distancia.
   * @return La distancia entre los centros de los círculos.
   */
  public double distanciaA(Circulo otroCirculo) {
    double x = Math.pow(this.getCentro().getX() - otroCirculo.getCentro().getX(), 2);
    double y = Math.pow(this.getCentro().getY() - otroCirculo.getCentro().getY(), 2);
    return Math.sqrt(x + y);
  }

  /**
   * Determina cuál de los dos círculos tiene una superficie mayor.
   *
   * @param otroCirculo El otro círculo con el que se comparará la superficie.
   * @return El círculo con la mayor superficie.
   */
  public Circulo elMayor(Circulo otroCirculo) {
    return this.superficie() > otroCirculo.superficie() ? this : otroCirculo;
  }
}