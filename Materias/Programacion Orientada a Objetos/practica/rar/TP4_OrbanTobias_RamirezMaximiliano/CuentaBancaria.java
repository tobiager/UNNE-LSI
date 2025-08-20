

public class CuentaBancaria {
  private int nroCuenta;
  private Persona titular;
  private double saldo;

  /**
   * Constructor de la clase CuentaBancaria.
   * 
   * @param pNroCuenta Es el número de cuenta del banco.
   * @param pTitular   Es la persona titular de la cuenta.
   * @param pSaldo     Saldo de la cuenta bancaria.
   */
  public CuentaBancaria(int pNroCuenta, Persona pTitular, double pSaldo) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(pSaldo);
  }

  /**
   * Constructor de la clase CuentaBancaria.
   * 
   * @param pNroCuenta Es el número de cuenta del banco.
   * @param pTitular   Es la persona titular de la cuenta.
   */
  public CuentaBancaria(int pNroCuenta, Persona pTitular) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(0);
  }

  /**
   * El método establece el valor de la variable "nroCuenta" proporcionado del
   * valor
   * "pNroCuenta".
   * 
   * @param pNroCuenta Es un valor doble que representa el nuevo valor de la
   *                   variable "nroCuenta".
   */
  private void setNroCuenta(int pNroCuenta) {
    this.nroCuenta = pNroCuenta;
  }

  /**
   * El método establece el valor de la variable "titular" proporcionado del valor
   * "pTitular".
   * 
   * @param pTitular Es un valor doble que representa el nuevo valor de la
   *                 variable "titular".
   */
  private void setTitular(Persona pTitular) {
    this.titular = pTitular;
  }

  /**
   * El método establece el valor de la variable "saldo" proporcionado del valor
   * "pSaldo".
   * 
   * @param pSaldo Es un valor doble que representa el nuevo valor de la variable
   *               "saldo".
   */
  private void setSaldo(double pSaldo) {
    this.saldo = pSaldo;
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
   * 
   * @param pImporte Nuevo valor que se deposita en la cuenta del banco.
   * @return El nuevo saldo después del deposito en la cuenta del banco.
   */
  public double depositar(double pImporte) {
    this.setSaldo(this.getSaldo() + pImporte);
    return this.getSaldo();
  }

  /**
   * 
   * @param pImporte Valor que se extraerá en la cuenta del banco.
   * @return El nuevo saldo después de la extraccion en la cuenta del banco.
   */
  public double extraer(double pImporte) {
    this.setSaldo(this.getSaldo() - pImporte);
    return this.getSaldo();
  }

  /**
   * El método "mostrar" imprime el nombre, edad y saldo del titular de la cuenta
   * bancaria.
   */
  public void mostrar() {
    System.out.println("- Cuenta Bancaria -");
    System.out.println("Titular: " + this.getTitular().nomYApe() + " (" + this.getTitular().edad() + " Años)");
    System.out.println("Saldo: " + this.getSaldo());
  }

  /**
   * @return El método devuelve una representación de cadena del número de cuenta,
   *         nombre del titular de la cuenta y saldo.
   */
  public String toStrinf() {
    return this.getNroCuenta() + "\t" + this.getTitular().nomYApe() + "\t" + this.getSaldo();
  }
}
