public class Cocina extends ArtefactoHogar {
  private int hornallas;
  private int calorias;
  private String dimensiones;

  /**
   * @param p_marca       La marca de la cocina (String).
   * @param p_precio      El precio de la cocina (float).
   * @param p_stock       La cantidad de cocinas que hay en stock (int).
   * @param p_hornallas   La cantidad de hornallas de la cocina (int).
   * @param p_calorias    La cantidad de calorias de la cocina (int).
   * @param p_dimensiones Las dimensiones de la cocina (String).
   */
  public Cocina(String p_marca, float p_precio, int p_stock, int p_hornallas, int p_calorias, String p_dimensiones) {
    super(p_marca, p_precio, p_stock);
    this.setHornallas(p_hornallas);
    this.setCalorias(p_calorias);
    this.setDimensiones(p_dimensiones);
  }

  /**
   * Establece la cantidad de hornallas de la cocina.
   *
   * @param p_hornallas La cantidad de hornallas de la cocina (int).
   */
  private void setHornallas(int p_hornallas) {
    this.hornallas = p_hornallas;
  }

  /**
   * Establece las calorias de la cocina.
   *
   * @param p_calorias Las calorias de la cocina (int).
   */
  private void setCalorias(int p_calorias) {
    this.calorias = p_calorias;
  }

  /**
   * Establece las dimensiones de la cocina.
   *
   * @param p_dimensiones Las dimensiones de la cocina (String).
   */
  private void setDimensiones(String p_dimensiones) {
    this.dimensiones = p_dimensiones;
  }

  /**
   * Obtiene la cantidad de hornallas de la cocina.
   *
   * @return La cantidad de hornallas de la cocina (int).
   */
  public int getHornallas() {
    return this.hornallas;
  }

  /**
   * Obtiene las calorias de la cocina
   *
   * @return Las calorias de la cocina (int).
   */
  public int getCalorias() {
    return this.calorias;
  }

  /**
   * Obtiene las dimensiones de la cocina
   *
   * @return Las dimensiones de la cocina (int).
   */
  public String getDimensiones() {
    return this.dimensiones;
  }

  /**
   * Imprime por pantalla "Cocina", la marca, el precio, la cantidad de cocinas
   * disponibles y las caracteristicas de la cocina (Hornallas, Calorias,
   * Dimensiones).
   */
  @Override
  public void imprimir() {
    System.out.println("**** Cocina ****");
    super.imprimir();
    System.out.format("Hornallas: %s\n", this.getHornallas());
    System.out.format("Calorias: %s\n", this.getCalorias());
    System.out.format("Dimensiones: %s\n", this.getDimensiones());
  }

  /**
   * Calcula la cuota mensual de un crédito para una Cocina.
   *
   * @param p_cuotas  El número de cuotas en las que se dividirá el crédito (int).
   * @param p_interes El interés aplicado al crédito (float).
   * @return Devuelve la cuota mensual a pagar del crédito con Adicional
   *         (float).
   */
  public float creditoConAdicional(int p_cuotas, float p_interes) {
    return super.cuotaCredito(p_cuotas, p_interes);
  }
}