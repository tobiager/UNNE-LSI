public class Comun extends Etiqueta {
  private double plus;

  /**
   * @param p_costo El precio por unidad de la etiqueta común (double).
   * @param p_plus  El plus por diseño de la etiqueta común (double).
   */
  public Comun(double p_costo, double p_plus) {
    super(p_costo);
    this.setPlus(p_plus);
  }

  /**
   * Establece el plus por diseño de la etiqueta.
   * 
   * @param p_plus El plus por diseño de la etiqueta (double).
   */
  private void setPlus(double p_plus) {
    this.plus = p_plus;
  }

  /**
   * Obtiene el plus por diseño de la etiqueta.
   *
   * @return El plus por diseño de la etiqueta (double).
   */
  public double getPlus() {
    return this.plus;
  }

  /**
   * @param q La cantidad de unidades de etiquetas (int).
   * @return El precio final que deberá pagar con el descuento y con el plus de
   *         diseño de la etiqueta (double).
   */
  @Override
  public double precio(int q) {
    return (super.getCosto() * q) + this.getPlus() - this.descuento(q);
  }

  /**
   * @return Un String del nombre de la etiqueta "Común" (String).
   */
  @Override
  protected String tipo() {
    return "Común";
  }

  /**
   * @return Una cadena de caracteres que contiene el tipo de etiqueta, costo por
   *         unidad y el plus de diseño (String).
   */
  @Override
  public String toString() {
    return super.toString() + "- Diseño: $" + this.getPlus();
  }

  /**
   * Descuento por cantidad de unidades.
   * 
   * @param q La cantidad de unidades de etiquetas (int).
   * @return Devuelve el descuento.
   */
  private double descuento(int q) {
    double descuento = 0;
    if (q > 11) {
      if (q < 50) {
        descuento = this.getCosto() * q * 0.02;
      } else if (q < 100) {
        descuento = this.getCosto() * q * 0.05;
      } else {
        descuento = this.getCosto() * q * 0.01 * (int) (q / 10);
      }
    }
    // if (q > 11 && q < 50) {
    // descuento = super.getCosto() * q * 0.02;
    // } else if (q > 51 && q < 100) {
    // descuento = super.getCosto() * q * 0.05;
    // } else if (q > 100) {
    // descuento = super.getCosto() * q * 0.01 * (int) (q / 10);
    // }
    return descuento;
  }
}