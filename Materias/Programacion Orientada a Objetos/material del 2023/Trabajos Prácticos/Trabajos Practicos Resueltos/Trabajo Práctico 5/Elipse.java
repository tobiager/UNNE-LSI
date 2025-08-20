public class Elipse extends FiguraGeometrica {
  private double sEjeMayor;
  private double sEjeMenor;

  public Elipse(double p_sEjeMayor, double p_sEjeMenor, Punto p_centro) {
    super(p_centro);
    this.setsEjeMayor(p_sEjeMayor);
    this.setsEjeMenor(p_sEjeMenor);
  }

  /**
   * Establece el eje mayor del elipse.
   * 
   * @param p_sEjeMayor El eje mayor del elipse (double).
   */
  private void setsEjeMayor(double p_sEjeMayor) {
    this.sEjeMayor = p_sEjeMayor;
  }

  /**
   * Establece el eje menor del elipse.
   * 
   * @param p_sEjeMenor El eje menor del elipse (double).
   */
  private void setsEjeMenor(double p_sEjeMenor) {
    this.sEjeMenor = p_sEjeMenor;
  }

  /**
   * Obtiene el valor del eje mayor de la elipse.
   *
   * @return El valor del eje mayor de la elipse (double).
   */
  public double getsEjeMayor() {
    return this.sEjeMayor;
  }

  /**
   * Obtiene el valor del eje menor de la elipse.
   *
   * @return El valor del eje menor de la elipse (double).
   */
  public double getsEjeMenor() {
    return this.sEjeMenor;
  }

  /**
   * @return Un String del nombre de la figura "Elipse" (String).
   */
  @Override
  public String nombreFigura() {
    return "****** Elipse ******";
  }

  /**
   * Muestra las características del rectangulo, incluyendo su centro, semieje
   * mayor, semieje menor y superficie.
   */
  public void caracteristicas() {
    System.out.format("%s\n", this.nombreFigura());
    System.out.format("Centro: %s - Semieje Mayor: %.2f - Semieje Menor: %.2f\n", super.getOrigen().coordenadas(),
        this.getsEjeMayor(),
        this.getsEjeMenor());
    System.out.format("Superficie: %.2f", this.superficie());
  }

  /**
   * Calcula la superficie del círculo.
   * Superficie = PI * EjeMayor * EjerMenor
   *
   * @return La superficie de una Elipse (double).
   */
  @Override
  public double superficie() {
    return Math.PI * this.getsEjeMayor() * this.getsEjeMenor();
  }

  /**
   * Se desplaza la Elipse en los valores pasados como parámetros.
   *
   * @param p_x La cantidad en la que el objeto debe moverse horizontalmente.
   * @param p_y La cantidad en la que el objeto debe moverse verticalmente.
   */
  public void desplazar(double p_dx, double p_dy) {
    this.getOrigen().desplazar(p_dx, p_dy);
  }

  /**
   * Calcula la distancia entre el centro de este elipse y el centro de otro
   * elipse dado.
   * Distancia = √(x1 - x2)² + (y1 - y2)²
   *
   * @param p_otroCirculo El otro elipse con el que se calculará la distancia.
   * @return La distancia entre los centros de los elipses (double).
   */
  public double distanciaA(Elipse p_otraElipse) {
    double dx = this.getOrigen().getX() - p_otraElipse.getOrigen().getX();
    double dy = this.getOrigen().getY() - p_otraElipse.getOrigen().getY();
    return Math.sqrt(dx * dx + dy * dy);
  }

  /**
   * Determina cuál de las dos elipses tiene una superficie mayor.
   *
   * @param p_otraElipse La otra Elipse con el que se comparará la superficie.
   * @return La elipse con la mayor superficie (Elipse).
   */
  public Elipse elMayor(Elipse p_otraElipse) {
    return this.superficie() > p_otraElipse.superficie() ? this : p_otraElipse;
  }
}