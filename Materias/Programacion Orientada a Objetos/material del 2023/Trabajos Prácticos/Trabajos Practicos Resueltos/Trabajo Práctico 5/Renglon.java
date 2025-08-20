public class Renglon {
  private int cantidad;
  private double importe;
  private Etiqueta item;

  /**
   * @param p_cantidad La cantidad de etiquetas (int).
   * @param p_item     El tipo de etiqueta (Etiqueta).
   */
  public Renglon(int p_cantidad, Etiqueta p_item) {
    this.setCantidad(p_cantidad);
    this.setItem(p_item);
    this.setImporte(p_item.precio(p_cantidad));
  }

  /**
   * Establece la cantidad de etiquetas.
   * 
   * @param p_cantidad La cantidad de etiquetas (int).
   */
  private void setCantidad(int p_cantidad) {
    this.cantidad = p_cantidad;
  }

  /**
   * Establece el importe a pagar de todas las etiquetas.
   * 
   * @param p_importe El importe a pagar de todas las etiquetas (double).
   */
  private void setImporte(double p_importe) {
    this.importe = p_importe;
  }

  /**
   * Establece la etiqueta de un solo tipo.
   * 
   * @param p_item La etiqueta de un solo tipo (Etiqueta).
   */
  private void setItem(Etiqueta p_item) {
    this.item = p_item;
  }

  /**
   * Obtiene la cantidad de etiquetas.
   *
   * @return La cantidad de etiquetas (int).
   */
  public int getCantidad() {
    return this.cantidad;
  }

  /**
   * Obtiene el importe a pagar de todas las etiquetas.
   *
   * @return El importe a pagar de todas las etiquetas (int).
   */
  public double getImporte() {
    return this.importe;
  }

  /**
   * Obtiene la etiquetas de un solo tipo.
   *
   * @return El importe a pagar de todas las etiquetas (int).
   */
  public Etiqueta getItem() {
    return this.item;
  }

  /**
   * Imprime por pantalla la cantidad de etiquetas el tipo de etiqueta y el costo
   * por unidad.
   */
  public void mostrar() {
    System.out.format("%s Etiquetas de %s\n", this.getCantidad(), this.getItem().toString());
  }
}