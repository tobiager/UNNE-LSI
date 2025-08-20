import java.text.DecimalFormat;

/**
 * Ejercicio 4 del Tp3, clase Rectangulo.
 * 
 * @author Olivarez Alexis E.
 */
public class Rectangulo {
  private Punto origen;
  private double ancho;
  private double alto;

  /**
   * Crea un nuevo objeto Rectangulo con el origen, ancho y alto especificados.
   *
   * @param pOrigen El punto de origen del rectángulo.
   * @param pAncho  El ancho del rectángulo.
   * @param pAlto   El alto del rectángulo.
   */
  Rectangulo(Punto pOrigen, double pAncho, double pAlto) {
    this.setOrigen(pOrigen);
    this.setAncho(pAncho);
    this.setAlto(pAlto);
  }

  /**
   * Crea un nuevo objeto Rectangulo con el ancho y alto especificados.
   *
   * @param pAncho El ancho del rectángulo.
   * @param pAlto  El alto del rectángulo.
   */
  Rectangulo(double pAncho, double pAlto) {
    this.setAncho(pAncho);
    this.setAlto(pAlto);
  }

  /**
   * Establece el punto de origen del rectángulo.
   *
   * @param pOrigen El punto de origen del rectángulo.
   */
  public void setOrigen(Punto pOrigen) {
    this.origen = pOrigen;
  }

  /**
   * Establece el ancho del rectangulo.
   *
   * @param pAncho El ancho del rectángulo.
   */
  private void setAncho(double pAncho) {
    this.ancho = pAncho;
  }

  /**
   * Establece el alto del rectangulo.
   *
   * @param pAlto El alto del rectángulo.
   */
  private void setAlto(double pAlto) {
    this.alto = pAlto;
  }

  /**
   * Obtiene el punto de origen del rectángulo.
   *
   * @return El punto de origen del rectángulo.
   */
  public Punto getOrigen() {
    return this.origen;
  }

  /**
   * Obtiene el ancho del rectángulo.
   *
   * @return La anchura del rectángulo.
   */
  public double getAncho() {
    return this.ancho;
  }

  /**
   * Obtiene el alto del rectángulo.
   *
   * @return La altura del rectángulo.
   */
  public double getAlto() {
    return this.alto;
  }

  /**
   * Desplaza el centro del rectangulo por las cantidades dadas en las coordenadas X
   * e Y.
   *
   * @param pX La cantidad en la que el rectangulo debe moverse horizontalmente.
   * @param pY La cantidad en la que el rectangulo debe moverse verticalmente.
   */
  public void desplazar(double pDx, double pDy) {
    this.getOrigen().desplazar(pDx, pDy);
  }

  /**
   * Calcula la superficie del rectangulo.
   * Superficie = PI * Radio²
   *
   * @return La superficie del rectangulo.
   */
  public double superficie() {
    return this.getAlto() * this.getAncho();
  }

  /**
   * Calcula el perímetro del rectangulo.
   * Perimetro = (Alto + Ancho) * 2
   *
   * @return El perímetro del rectangulo.
   */
  public double perimetro() {
    return (this.getAlto() + this.getAncho()) * 2;
  }

  /**
   * Muestra las características del rectangulo, incluyendo su centro, alto, ancho,
   * superficie y perímetro.
   */
  public void caracteristicas() {
    DecimalFormat df = new DecimalFormat("#.##");
    System.out.println("****** Rectangulo ******");
    System.out.println(
        "Centro: " + this.getOrigen().coordenadas() + " - Alto: " + this.getAlto() + "- Ancho: " + this.getAncho());
    System.out.println("Superficie: " + df.format(this.superficie()) + " - Perimetro: " + df.format(this.perimetro()));
  }

  /**
   * Calcula la distancia entre el centro de este rectangulo y el centro de otro
   * rectangulo dado.
   * Distancia = √(x1 - x2)² + (y1 - y2)²
   *
   * @param otroRectangulo El otro rectangulo con el que se calculará la
   *                       distancia.
   * @return La distancia entre los centros de los rectangulos.
   */
  public double distanciaA(Rectangulo otroRectangulo) {
    double x = Math.pow(this.getOrigen().getX() - otroRectangulo.getOrigen().getX(), 2);
    double y = Math.pow(this.getOrigen().getY() - otroRectangulo.getOrigen().getY(), 2);
    return Math.sqrt(x + y);
  }

  /**
   * Determina cuál de los dos rectangulos tiene una superficie mayor.
   *
   * @param otroRectangulo El otro rectangulo con el que se comparará la
   *                       superficie.
   * @return El rectangulo con la mayor superficie.
   */
  public Rectangulo elMayor(Rectangulo otroRectangulo) {
    return this.superficie() > otroRectangulo.superficie() ? this : otroRectangulo;
  }
}
