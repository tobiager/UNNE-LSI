public class CajaDeAhorro extends CuentaBancaria {
  private int extraccionesPosibles;

  /**
   * Constructor de la clase CuentaDeAhorro.
   * 
   * @param p_nroCuenta El número de cuenta de la persona titular de la
   *                    cuenta de ahorro.
   * @param p_titular   Persona titular de la cuenta de ahorro.
   */
  public CajaDeAhorro(int p_nroCuenta, Persona p_titular) {
    super(p_nroCuenta, p_titular);
    this.setSaldo(0);
    this.setExtraccionesPosibles(10);
  }

  /**
   * Constructor de la clase CuentaDeAhorro.
   * 
   * @param p_nroCuenta El número de cuenta de la persona titular de la
   *                    cuenta de ahorro.
   * @param p_saldo     Saldo al iniciar la cuenta de ahorro.
   * @param p_titular   Persona titular de la cuenta de ahorro.
   */
  public CajaDeAhorro(int p_nroCuenta, double p_saldo, Persona p_titular) {
    super(p_nroCuenta, p_titular, p_saldo);
    this.setExtraccionesPosibles(10);
  }

  /**
   * Establece el valor de la variable "extraccionesPosibles" proporcionado del
   * valor "p_extraccionesPosibles".
   * 
   * @param p_extraccionesPosibles Es un valor doble que representa el nuevo valor
   *                               de la variable "extraccionesPosibles".
   */
  private void setExtraccionesPosibles(int p_extraccionesPosibles) {
    this.extraccionesPosibles = p_extraccionesPosibles;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "extraccionesPosibles".
   */
  public int getExtraccionesPosibles() {
    return this.extraccionesPosibles;
  }

  /**
   * Verifica si el monto dado se puede retirar de la cuenta sin exceder el límite
   * de saldo.
   *
   * @param p_importe Representa la cantidad de dinero que el usuario desea
   *                  retirar
   *                  de su cuenta.
   * @return Devuelve un valor booleano.
   */
  private boolean puedeExtraer(double p_importe) {
    return p_importe < this.getSaldo() && this.getExtraccionesPosibles() > 0;
  }

  /**
   * @param p_importe Valor que se extraerá en la cuenta del banco.
   * @return Si se pudo extraer o no (boolean).
   */
  @Override
  public boolean extraer(double p_importe) {
    boolean puedeExtraer = false;
    if (this.puedeExtraer(p_importe)) {
      this.setExtraccionesPosibles(this.getExtraccionesPosibles() - 1);
      puedeExtraer = super.extraer(p_importe);
    }
    return puedeExtraer;
  }

  /**
   * Imprime el número de cuenta, el saldo, el titular y sus extracciones
   * disponibles de la cuenta bancaria.
   */
  @Override
  public void mostrar() {
    System.out.println("- Caja de Ahorro -");
    super.mostrar();
    System.out.println("Extracciones Posibles: " + this.getExtraccionesPosibles());
  }

  /**
   * @param p_importe Valor que se extraerá en la cuenta del banco.
   * @return Un String que avisa si puede extraer o no.
   */
  public String xQNoPuedeExtraer(double p_importe) {
    String mensaje;
    if (this.puedeExtraer(p_importe)) {
      mensaje = "Si puede extraer\n";
    } else if (this.getExtraccionesPosibles() == 0) {
      mensaje = "No tiene habilitadas más extracciones!\n";
    } else {
      mensaje = "No puede extraer más que el saldo!\n";
    }
    return mensaje;
  }
}
