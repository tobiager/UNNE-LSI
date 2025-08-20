public class CuentaBancaria {
  private int nroCuenta;
  private Persona titular;
  private double saldo;

  /**
   * Constructor de la clase CuentaBancaria.
   * 
   * @param p_nroCuenta Es el número de cuenta del banco.
   * @param p_titular   Es la persona titular de la cuenta.
   * @param p_saldo     Saldo de la cuenta bancaria.
   */
  public CuentaBancaria(int p_nroCuenta, Persona p_titular, double p_saldo) {
    this.setNroCuenta(p_nroCuenta);
    this.setTitular(p_titular);
    this.setSaldo(p_saldo);
  }

  /**
   * Constructor de la clase CuentaBancaria.
   * 
   * @param p_nroCuenta Es el número de cuenta del banco.
   * @param p_titular   Es la persona titular de la cuenta.
   */
  public CuentaBancaria(int p_nroCuenta, Persona p_titular) {
    this.setNroCuenta(p_nroCuenta);
    this.setTitular(p_titular);
    this.setSaldo(0);
  }

  /**
   * Establece el valor de la variable "nroCuenta" proporcionado del
   * valor
   * "p_nroCuenta".
   * 
   * @param p_nroCuenta Es un valor doble que representa el nuevo valor de la
   *                    variable "nroCuenta".
   */
  private void setNroCuenta(int p_nroCuenta) {
    this.nroCuenta = p_nroCuenta;
  }

  /**
   * Establece el valor de la variable "titular" proporcionado del valor
   * "p_titular".
   * 
   * @param p_titular Es un valor doble que representa el nuevo valor de la
   *                  variable "titular".
   */
  private void setTitular(Persona p_titular) {
    this.titular = p_titular;
  }

  /**
   * Establece el valor de la variable "saldo" proporcionado del valor
   * "p_saldo".
   * 
   * @param p_saldo Es un valor doble que representa el nuevo valor de la variable
   *                "saldo".
   */
  protected void setSaldo(double p_saldo) {
    this.saldo = p_saldo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nroCuenta".
   */
  public int getNroCuenta() {
    return this.nroCuenta;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "titular".
   */
  public Persona getTitular() {
    return this.titular;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "saldo".
   */
  public double getSaldo() {
    return this.saldo;
  }

  /**
   * @param p_importe Valor que se extraerá en la cuenta del banco.
   * @return Si se pudo extraer o no (boolean).
   */
  public boolean extraer(double p_importe) {
    this.setSaldo(this.getSaldo() - p_importe);
    return true;
  }

  /**
   * 
   * @param p_importe Nuevo valor que se deposita en la cuenta del banco.
   * @return El nuevo saldo después del deposito en la cuenta del banco.
   */
  public double depositar(double p_importe) {
    this.setSaldo(this.getSaldo() + p_importe);
    return this.getSaldo();
  }

  /**
   * Imprime el nombre, edad y saldo del titular de la cuenta
   * bancaria.
   */
  public void mostrar() {
    System.out.println("Titular: " + this.getTitular().nomYApe() + " (" + this.getTitular().edad() + " Años)");
    System.out.println("Saldo: " + this.getSaldo());
  }
}