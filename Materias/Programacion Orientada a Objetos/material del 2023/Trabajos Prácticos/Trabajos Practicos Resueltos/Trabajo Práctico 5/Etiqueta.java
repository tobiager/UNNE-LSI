public abstract class Etiqueta {
  private double costo;

  public abstract double precio(int q);

  protected abstract String tipo();

  /**
   * @param p_costo El precio de la etiqueta (int).
   */
  public Etiqueta(double p_costo) {
    this.setCosto(p_costo);
  }

  /**
   * Establece el precio de la etiqueta.
   *
   * @param p_costo El precio de la etiqueta (int).
   */
  private void setCosto(double p_costo) {
    this.costo = p_costo;
  }

  /**
   * Obtiene el precio de la etiqueta.
   *
   * @return El precio de la etiqueta (int).
   */
  public double getCosto() {
    return this.costo;
  }

  /**
   * @return Una cadena de caracteres que contiene el tipo de etiqueta y costo por
   *         unidad (String).
   */
  public String toString() {
    return String.format("tipo %s - Costo: $%s ", this.tipo(), this.getCosto());
  }
}
