public class Lavarropas extends ArtefactoHogar {
  private int programas;
  private float kilos;
  private boolean automatico;

  /**
   * @param p_marca      La marca del lavarropas (String).
   * @param p_precio     El precio del lavarropas (float).
   * @param p_stock      La cantidad de lavarropas que hay en stock (int).
   * @param p_programas  La cantidad de programas del lavarropas (int).
   * @param p_kilos      La cantidad de kilos del lavarropas (float).
   * @param p_automatico Si es automatico o no el lavarropas (boolean).
   */
  public Lavarropas(String p_marca, float p_precio, int p_stock, int p_programas, float p_kilos, boolean p_automatico) {
    super(p_marca, p_precio, p_stock);
    this.setProgramas(p_programas);
    this.setKilos(p_kilos);
    this.setAutomatico(p_automatico);
  }

  /**
   * Establece los programas del lavarropas.
   *
   * @param p_programas Los programas del lavarropas (int).
   */
  private void setProgramas(int p_programas) {
    this.programas = p_programas;
  }

  /**
   * Establece los kilos del lavarropas.
   *
   * @param p_kilos Los kilos del lavarropas (float).
   */
  private void setKilos(float p_kilos) {
    this.kilos = p_kilos;
  }

  /**
   * Establece si es automático o no el lavarropas.
   *
   * @param p_automatico Si es automático o no (boolean).
   */
  private void setAutomatico(boolean p_automatico) {
    this.automatico = p_automatico;
  }

  /**
   * Obtiene la cantidad de programas que tiene el lavarropas.
   *
   * @return La cantidad de programas del lavarropas (int).
   */
  public int getProgramas() {
    return this.programas;
  }

  /**
   * Obtiene la cantidad de kilos que tiene el lavarropas.
   *
   * @return La cantidad de kilos del lavarropas (int).
   */
  public float getKilos() {
    return this.kilos;
  }

  /**
   * Obtiene si es automático o no el lavarropas.
   *
   * @return Si es automático o no el lavarropas (boolean).
   */
  public boolean isAutomatico() {
    return this.automatico;
  }

  /**
   * Imprime por pantalla el nombre, la marca, el precio y el stock del lavarropas
   * y sus caracteristicas (programas, kilos y si es automático).
   */
  @Override
  public void imprimir() {
    System.out.println("**** Lavarropas ****");
    super.imprimir();
    System.out.format("Programas: %s\n", this.getProgramas());
    System.out.format("Kilos: %s\n", this.getKilos());
    System.out.format("Automatico: %s\n", this.isAutomatico() ? "Si" : "No");
  }

  /**
   * Calcula la cuota mensual de un crédito para el lavarropas con un 2% de
   * descuento.
   *
   * @param p_cuotas  El número de cuotas en las que se dividirá el crédito (int).
   * @param p_interes El interés aplicado al crédito (float).
   * @return Devuelve la cuota mensual a pagar del crédito (float).
   */
  @Override
  public float creditoConAdicional(int p_cuotas, float p_interes) {
    float valorCuota = super.cuotaCredito(p_cuotas, p_interes);
    if (!this.isAutomatico()) {
      valorCuota -= valorCuota * 0.02;
    }
    return valorCuota;
  }
}