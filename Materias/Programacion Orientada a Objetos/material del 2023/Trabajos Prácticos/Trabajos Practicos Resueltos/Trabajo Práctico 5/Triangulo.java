public class Triangulo extends FiguraGeometrica {
  private double base;
  private double altura;

  /**
   * Crea un nuevo objeto Triangulo con el origen, base y altura especificado.
   *
   * @param p_origen El punto de origen del triangulo (Punto).
   * @param p_base   La base del triangulo (double).
   * @param p_altura La altura del triangulo (double).
   */
  public Triangulo(Punto p_origen, double p_base, double p_altura) {
    super(p_origen);
    this.setBase(p_base);
    this.setAltura(p_altura);
  }

  /**
   * Establece la altura del triangulo.
   * 
   * @param p_altura La altura del triangulo (double).
   */
  private void setAltura(double p_altura) {
    this.altura = p_altura;
  }

  /**
   * Establece la base del triangulo.
   * 
   * @param p_base La base del triangulo (double).
   */
  private void setBase(double p_base) {
    this.base = p_base;
  }

  /**
   * Obtiene la altura del triangulo.
   *
   * @return La altura del triangulo (double).
   */
  public double getAltura() {
    return this.altura;
  }

  /**
   * Obtiene la base del triangulo.
   *
   * @return La base del triangulo (double).
   */
  public double getBase() {
    return this.base;
  }

  /**
   * @return Un String del nombre de la figura "Triangulo" (String).
   */
  @Override
  public String nombreFigura() {
    return "****** Triángulo ******";
  }

  /**
   * Calcula la superficie del triangulo.
   * Superficie = (Base * Altura) / 2
   *
   * @return La superficie del triangulo (double).
   */
  @Override
  public double superficie() {
    return (this.getBase() * this.getAltura()) / 2;
  }
}
