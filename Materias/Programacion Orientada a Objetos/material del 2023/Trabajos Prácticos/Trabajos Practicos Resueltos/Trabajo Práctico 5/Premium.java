public class Premium extends Etiqueta {
  private int colores;

  /**
   * @param p_costo   El precio por unidad de la etiqueta premium (double).
   * @param p_colores La cantidad de colores de la etiqueta premium (double).
   */
  public Premium(double p_costo, int p_colores) {
    super(p_costo);
    this.setColores(p_colores);
  }

  /**
   * Establece la cantidad de colores de la etiqueta.
   * 
   * @param p_colores La cantidad de colores de la etiqueta (double).
   */
  private void setColores(int p_colores) {
    this.colores = p_colores;
  }

  /**
   * Obtiene la cantidad de colores de la etiqueta.
   *
   * @return La cantidad de colores de la etiqueta (int).
   */
  public int getColores() {
    return this.colores;
  }

  /**
   * @param q La cantidad de unidades de etiquetas (int).
   * @return El precio final que deberá pagar con el adicional (double).
   */
  @Override
  public double precio(int q) {
    return (super.getCosto() + this.adicional()) * q;
  }

  /**
   * @return Un String del nombre de la etiqueta "Premium" (String).
   */
  @Override
  protected String tipo() {
    return "Premium";
  }

  /**
   * @return Una cadena de caracteres que contiene el tipo de etiqueta, costo por
   *         unidad y la cantidad de colores (String).
   */
  @Override
  public String toString() {
    return super.toString() + "- Colores: " + this.getColores();
  }

  /**
   * Adicional por cantidad de colores.
   * 
   * @return Devuelve el adicional (double).
   */
  private double adicional() {
    double adicional = 0;
    int cantidadColores = this.getColores();
    if (cantidadColores == 2) {
      adicional = super.getCosto() * 0.05;
    } else if (cantidadColores == 3) {
      adicional = super.getCosto() * 0.07;
    } else if (cantidadColores > 3) {
      adicional = super.getCosto() * 0.03 * cantidadColores;
    }
    return adicional;
  }
}