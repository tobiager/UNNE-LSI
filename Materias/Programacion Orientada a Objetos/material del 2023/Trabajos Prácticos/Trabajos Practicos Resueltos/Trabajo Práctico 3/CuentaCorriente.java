/**
 * Ejercicio 7, clase CuentaCorriente.
 * 
 * @author Olivarez Alexis E.
 */
public class CuentaCorriente {
  private int nroCuenta;
  private double saldo;
  private double limiteDescubierto;
  private Persona titular;

  /**
   * Constructor de la clase CuentaCorriente.
   * 
   * @param pNroCuenta El número de cuenta de la persona titular de la
   *                   cuenta.
   * @param pTitular   Persona titular de la cuenta.
   */
  CuentaCorriente(int pNroCuenta, Persona pTitular) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(0);
    this.setLimiteDescubierto(500);
  }

  /**
   * Constructor de la clase CuentaCorriente.
   * 
   * @param pNroCuenta El número de cuenta de la persona titular de la
   *                   cuenta.
   * @param pSaldo     Saldo al iniciar la cuenta.
   * @param pTitular   Persona titular de la cuenta.
   */
  CuentaCorriente(int pNroCuenta, double pSaldo, Persona pTitular) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(pSaldo);
    this.setLimiteDescubierto(500);
  }

  /**
   * El método establece el valor de la variable "nroCuenta" proporcionado del
   * valor "pNroCuenta".
   * 
   * @param pNroCuenta Es un valor doble que representa el nuevo valor de la
   *                   variable "nroCuenta".
   */
  private void setNroCuenta(int pNroCuenta) {
    this.nroCuenta = pNroCuenta;
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
   * El método establece el valor de la variable "limiteDescubierto" proporcionado
   * del valor
   * "pLimiteDescubierto".
   * 
   * @param pLimiteDescubierto // ?
   */
  private void setLimiteDescubierto(double pLimiteDescubierto) {
    this.limiteDescubierto = pLimiteDescubierto;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "limiteDescubierto".
   */
  public double getLimiteDescubierto() {
    return this.limiteDescubierto;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nroCuenta".
   */
  public int getNroCuenta() {
    return this.nroCuenta;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "saldo".
   */
  public double getSaldo() {
    return this.saldo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "titular".
   */
  public Persona getTitular() {
    return this.titular;
  }

  /**
   * El método "puedeExtraer" verifica si el monto dado se puede retirar de la
   * cuenta sin
   * exceder el límite de saldo.
   *
   * @param pImporte Representa la cantidad de dinero que el usuario desea retirar
   *                 de su cuenta.
   * @return El método devuelve un valor booleano.
   */
  private Boolean puedeExtraer(double pImporte) {
    return pImporte < this.getSaldo() + this.getLimiteDescubierto();
  }

  /**
   * 
   * @param pImporte Nuevo valor que se deposita en la cuenta del banco.
   * @return El nuevo saldo después del deposito en la cuenta del banco.
   */
  public void depositar(double pImporte) {
    this.setSaldo(this.getSaldo() + pImporte);
  }

  /**
   * 
   * @param pImporte Valor que se extraerá en la cuenta del banco.
   */
  public void extraer(double pImporte) {
    this.extraccion(pImporte);
  }

  /**
   * El método "extracción" resta un monto determinado del saldo, de lo contrario
   * imprime un mensaje de error.
   *
   * @param pImporte Representa la cantidad de dinero que
   *                 se está retirando de la cuenta.
   */
  private void extraccion(double pImporte) {
    if (this.puedeExtraer(pImporte)) {
      this.setSaldo(this.getSaldo() - pImporte);
    } else {
      System.out.println("El importe de extraccion sobrepasa el limite de descubierto!");
    }
  }

  /**
   * El método "mostrar" imprime el número de cuenta, el saldo, el titular, su
   * descubierto de la cuenta bancaria.
   */
  public void mostrar() {
    System.out.println("- Cuenta Corriente -");
    System.out.println("Nro. Cuenta: " + this.getNroCuenta() + " - Saldo: " + this.getSaldo());
    System.out.println("Titular: " + this.getTitular().nomYApe());
    System.out.println("Descubierto: " + this.getLimiteDescubierto());
  }
}
