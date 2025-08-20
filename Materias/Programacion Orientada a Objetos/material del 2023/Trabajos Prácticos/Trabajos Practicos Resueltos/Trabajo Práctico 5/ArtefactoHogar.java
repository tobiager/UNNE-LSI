public abstract class ArtefactoHogar {
  private String marca;
  private float precio;
  private int stock;

  public abstract float creditoConAdicional(int p_cuotas, float p_interes);

  /**
   * @param p_marca  La marca del electrodoméstico (String).
   * @param p_precio El precio del electrodoméstico (float).
   * @param p_stock  La cantidad de electrodomésticos que hay en stock (int).
   */
  public ArtefactoHogar(String p_marca, float p_precio, int p_stock) {
    this.setMarca(p_marca);
    this.setPrecio(p_precio);
    this.setStock(p_stock);
  }

  /**
   * Establece el nombre de la marca del electrodoméstico.
   *
   * @param p_marca El nombre de la marca del electrodoméstico (String).
   */
  private void setMarca(String p_marca) {
    this.marca = p_marca;
  }

  /**
   * Establece el precio del electrodoméstico.
   *
   * @param p_precio El precio del electrodoméstico (float).
   */
  private void setPrecio(float p_precio) {
    this.precio = p_precio;
  }

  /**
   * Establece el stock de los electrodomésticos disponibles.
   *
   * @param p_stock El stock de los electrodomésticos disponibles (int).
   */
  private void setStock(int p_stock) {
    this.stock = p_stock;
  }

  /**
   * Obtiene la marca del electrodoméstico.
   *
   * @return La marca del electrodoméstico (String).
   */
  public String getMarca() {
    return this.marca;
  }

  /**
   * Obtiene el precio del electrodoméstico.
   *
   * @return El precio del electrodoméstico (double).
   */
  public float getPrecio() {
    return this.precio;
  }

  /**
   * Obtiene el stock de los electrodomésticos.
   *
   * @return La cantidad de electrodomésticos disponibles (int).
   */
  public int getStock() {
    return this.stock;
  }

  /**
   * Imprime por pantalla la marca, el precio y el stock de un electrodoméstico.
   */
  public void imprimir() {
    System.out.format("Marca: %s  - Precio: %s - Stock: %s\n", this.getMarca(), this.getPrecio(), this.getStock());
  }

  /**
   * Calcula la cuota mensual de un crédito para un electrodoméstico.
   *
   * @param p_cuotas  El número de cuotas en las que se dividirá el crédito (int).
   * @param p_interes El interés aplicado al crédito (float).
   * @return Devuelve la cuota mensual a pagar del crédito (float).
   */
  public float cuotaCredito(int p_cuotas, float p_interes) {
    return (this.getPrecio() + (this.getPrecio() * (p_interes / 100))) / p_cuotas;
  }
}