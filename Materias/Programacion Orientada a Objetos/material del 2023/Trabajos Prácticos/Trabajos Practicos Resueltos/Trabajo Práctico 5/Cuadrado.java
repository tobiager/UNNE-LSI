public class Cuadrado extends Rectangulo {
  private double lado;

  /**
   * Crea un nuevo objeto Cuadrado con el origen y lado especificado.
   *
   * @param p_origen El punto de origen del cuadrado (Punto).
   * @param p_lado   La longitud del lado del cuadrado (double).
   */
  public Cuadrado(Punto p_origen, double p_lado) {
    super(p_origen, p_lado, p_lado);
    this.setLado(p_lado);
  }

  /**
   * Establece la longitud del lado del cuadrado.
   *
   * @param p_lado La longitud del lado del cuadrado (double).
   */
  private void setLado(double p_lado) {
    this.lado = p_lado;
  }

  /**
   * Obtiene la longitud del lado del cuadrado.
   *
   * @return La longitud del lado del cuadrado (double).
   */
  public double getLado() {
    return this.lado;
  }

  /**
   * @return Un String del nombre de la figura "Cuadrado" (String).
   */
  @Override
  public String nombreFigura() {
    return "****** Cuadrado ******";
  }

  /**
   * Muestra las características del cuadrado, incluyendo su nombre, origen, lado,
   * superficie y perímetro.
   */
  public void características() {
    System.out.format("%s\n", this.nombreFigura());
    System.out.format("Origen: %s - Lado: %s\n", super.getOrigen().coordenadas(), this.getLado());
    System.out.format("Superficie: %.2f - Perímetro: %s\n", super.superficie(), super.perimetro());
  }
}
