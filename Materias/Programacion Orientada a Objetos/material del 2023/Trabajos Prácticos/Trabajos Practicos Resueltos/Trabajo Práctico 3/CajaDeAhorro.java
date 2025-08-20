/**
 * Ejercicio 7, clase CuentaDeAhorro.
 * 
 * @author Olivarez Alexis E.
 */
public class CajaDeAhorro {
  private int nroCuenta;
  private double saldo;
  private int extraccionesPosibles;
  private Persona titular;

  /**
   * Constructor de la clase CuentaDeAhorro.
   * 
   * @param pNroCuenta El número de cuenta de la persona titular de la
   *                   cuenta de ahorro.
   * @param pTitular   Persona titular de la cuenta de ahorro.
   */
  CajaDeAhorro(int pNroCuenta, Persona pTitular) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(0);
    this.setExtraccionesPosibles(10);
  }

  /**
   * Constructor de la clase CuentaDeAhorro.
   * 
   * @param pNroCuenta El número de cuenta de la persona titular de la
   *                   cuenta de ahorro.
   * @param pSaldo     Saldo al iniciar la cuenta de ahorro.
   * @param pTitular   Persona titular de la cuenta de ahorro.
   */
  CajaDeAhorro(int pNroCuenta, double pSaldo, Persona pTitular) {
    this.setNroCuenta(pNroCuenta);
    this.setTitular(pTitular);
    this.setSaldo(pSaldo);
    this.setExtraccionesPosibles(10);
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
   * El método establece el valor de la variable "extraccionesPosibles"
   * proporcionado del valor
   * "pExtraccionesPosibles".
   * 
   * @param pExtraccionesPosibles Es un valor doble que representa el nuevo valor
   *                              de la variable "extraccionesPosibles".
   */
  private void setExtraccionesPosibles(int pExtraccionesPosibles) {
    this.extraccionesPosibles = pExtraccionesPosibles;
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
   * @return Devuelve el valor de la variable de instancia "extraccionesPosibles".
   */
  public int getExtraccionesPosibles() {
    return this.extraccionesPosibles;
  }

  /**
   * El método "extraccion" permite realizar una extracción de fondos desde una
   * cuenta. Si no se puede extraer es porque no tiene el saldo que quiere retirar
   * o porque ya ocupó todas sus extracciónes posibles.
   * 
   * @param pImporte El saldo que se desea extraer de la cuenta de ahorro.
   */
  private void extraccion(double pImporte) {
    if (this.puedeExtraer(pImporte)) {
      this.setSaldo(this.getSaldo() - pImporte);
      this.setExtraccionesPosibles(this.getExtraccionesPosibles() - 1);
    } else {
      if (this.getExtraccionesPosibles() == 0) {
        System.out.println("No tiene habilitadas mas extracciones!");
      } else {
        System.out.println("No puede extraer mas que el saldo!");
      }
    }
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
  private boolean puedeExtraer(double pImporte) {
    return pImporte < this.getSaldo() && this.getExtraccionesPosibles() > 0;
  }

  /**
   * 
   * @param pImporte Nuevo valor que se deposita en la cuenta de ahorro.
   * @return El nuevo saldo después del deposito en la cuenta de ahorro.
   */
  public void depositar(double pImporte) {
    this.setSaldo(this.getSaldo() + pImporte);
  }

  /**
   * 
   * @param pImporte Valor que se extraerá en la cuenta de ahorro.
   */
  public void extraer(double pImporte) {
    this.extraccion(pImporte);
  }

  /**
   * El método "mostrar" imprime el número de cuenta, el saldo, el titular y sus
   * extracciones disponibles de la cuenta bancaria.
   */
  public void mostrar() {
    System.out.println("- Caja de Ahorro -");
    System.out.println("Nro. Cuenta: " + this.getNroCuenta() + " - Saldo: " + this.getSaldo());
    System.out.println("Titular: " + this.getTitular().nomYApe());
    System.out.println("Extracciones Posibles: " + this.getExtraccionesPosibles());
  }
}
