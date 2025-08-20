public abstract class FiguraGeometrica {
  private Punto origen;

  public abstract String nombreFigura();

  public abstract double superficie();

  /**
   * Constructor de FiguraGeometrica que establece el punto de origen de la
   * figura.
   *
   * @param p_origen El punto de origen de la figura.
   */
  public FiguraGeometrica(Punto p_origen) {
    this.setOrigen(p_origen);
  }

  /**
   * Establece el punto de origen de la figura.
   *
   * @param p_origen El punto de origen de la figura.
   */
  private void setOrigen(Punto p_origen) {
    this.origen = p_origen;
  }

  /**
   * Obtiene el punto de origen de la figura.
   *
   * @return El punto de origen de la figura.
   */
  public Punto getOrigen() {
    return this.origen;
  }

  /**
   * Muestra información sobre la figura, incluyendo su nombre y superficie.
   */
  public void mostrarSuperficie() {
    System.out.println("\n" + this.nombreFigura());
    System.out.format("Superficie: %.2f\n", this.superficie());
  }
}
