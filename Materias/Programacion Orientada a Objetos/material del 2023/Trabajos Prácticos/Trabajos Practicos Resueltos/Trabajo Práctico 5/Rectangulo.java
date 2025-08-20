public class Rectangulo extends FiguraGeometrica {
  private Punto origen;
  private double ancho;
  private double alto;

  /**
   * Crea un nuevo objeto Rectangulo con el origen, ancho y alto especificados.
   *
   * @param p_origen El punto de origen del rectángulo.
   * @param p_ancho  El ancho del rectángulo.
   * @param p_alto   El alto del rectángulo.
   */
  public Rectangulo(Punto p_origen, double p_ancho, double p_alto) {
    super(p_origen);
    this.setAncho(p_ancho);
    this.setAlto(p_alto);
  }

  /**
   * Crea un nuevo objeto Rectangulo con el ancho y alto especificados.
   *
   * @param p_ancho El ancho del rectángulo.
   * @param p_alto  El alto del rectángulo.
   */
  public Rectangulo(double p_ancho, double p_alto) {
    super(new Punto());
    this.setAncho(p_ancho);
    this.setAlto(p_alto);
  }

  /**
   * Establece el punto de origen del rectángulo.
   *
   * @param p_origen El punto de origen del rectángulo.
   */
  public void setOrigen(Punto p_origen) {
    this.origen = p_origen;
  }

  /**
   * Establece el ancho del rectangulo.
   *
   * @param p_ancho El ancho del rectángulo.
   */
  private void setAncho(double p_ancho) {
    this.ancho = p_ancho;
  }

  /**
   * Establece el alto del rectangulo.
   *
   * @param p_alto El alto del rectángulo.
   */
  private void setAlto(double p_alto) {
    this.alto = p_alto;
  }

  /**
   * Obtiene el punto de origen del rectángulo.
   *
   * @return El punto de origen del rectángulo (Punto).
   */
  public Punto getOrigen() {
    return this.origen;
  }

  /**
   * Obtiene el ancho del rectángulo.
   *
   * @return La anchura del rectángulo (double).
   */
  public double getAncho() {
    return this.ancho;
  }

  /**
   * Obtiene el alto del rectángulo.
   *
   * @return La altura del rectángulo (double).
   */
  public double getAlto() {
    return this.alto;
  }

  /**
   * Desplaza el centro del rectangulo por las cantidades dadas en las coordenadas
   * X
   * e Y.
   *
   * @param p_x La cantidad en la que el rectangulo debe moverse horizontalmente.
   * @param p_y La cantidad en la que el rectangulo debe moverse verticalmente.
   */
  public void desplazar(double p_dx, double p_dy) {
    this.getOrigen().desplazar(p_dx, p_dy);
  }

  /**
   * Calcula la superficie del rectangulo.
   * Superficie = PI * Radio²
   *
   * @return La superficie del rectangulo (double).
   */
  @Override
  public double superficie() {
    return this.getAlto() * this.getAncho();
  }

  /**
   * Calcula el perímetro del rectangulo.
   * Perimetro = (Alto + Ancho) * 2
   *
   * @return El perímetro del rectangulo (double).
   */
  public double perimetro() {
    return (this.getAlto() + this.getAncho()) * 2;
  }

  /**
   * Muestra las características del rectangulo, incluyendo su centro, alto,
   * ancho, superficie y perímetro.
   */
  public void caracteristicas() {
    System.out.println(this.nombreFigura());
    System.out.println(
        "Centro: " + this.getOrigen().coordenadas() + " - Alto: " + this.getAlto() + " - Ancho: " + this.getAncho());
    System.out.format("Superficie: %.2f - Perimetro: %.2f\n", this.superficie(), this.perimetro());
  }

  /**
   * Calcula la distancia entre el centro de este rectangulo y el centro de otro
   * rectangulo dado.
   * Distancia = √(x1 - x2)² + (y1 - y2)²
   *
   * @param p_otroRectangulo El otro rectangulo con el que se calculará la
   *                         distancia.
   * @return La distancia entre los centros de los rectangulos (double).
   */
  public double distanciaA(Rectangulo p_otroRectangulo) {
    double x = Math.pow(this.getOrigen().getX() - p_otroRectangulo.getOrigen().getX(), 2);
    double y = Math.pow(this.getOrigen().getY() - p_otroRectangulo.getOrigen().getY(), 2);
    return Math.sqrt(x + y);
  }

  /**
   * Determina cuál de los dos rectangulos tiene una superficie mayor.
   *
   * @param p_otroRectangulo El otro rectangulo con el que se comparará la
   *                         superficie.
   * @return El rectangulo con la mayor superficie (Rectangulo).
   */
  public Rectangulo elMayor(Rectangulo p_otroRectangulo) {
    return this.superficie() > p_otroRectangulo.superficie() ? this : p_otroRectangulo;
  }

  /**
   * @return Un String del nombre de la figura "Rectangulo" (String).
   */
  @Override
  public String nombreFigura() {
    return "****** Rectangulo ******";
  }
}