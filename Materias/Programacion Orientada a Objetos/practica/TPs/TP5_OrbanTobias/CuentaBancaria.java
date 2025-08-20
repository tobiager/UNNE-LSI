
/**
 * Clase abstracta que representa una cuenta bancaria.
 */
public abstract class CuentaBancaria {
    private int nroCuenta;
    private double saldo;
    private Persona titular;

    /**
     * Constructor de CuentaBancaria.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     */
    public CuentaBancaria(int p_nroCuenta, Persona p_titular) {
        this.nroCuenta = p_nroCuenta;
        this.titular = p_titular;
        this.saldo = 0.0;
    }

    /**
     * Constructor de CuentaBancaria con saldo inicial.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     * @param p_saldo el saldo inicial de la cuenta
     */
    public CuentaBancaria(int p_nroCuenta, Persona p_titular, double p_saldo) {
        this.nroCuenta = p_nroCuenta;
        this.titular = p_titular;
        this.saldo = p_saldo;
    }

    /**
     * Método abstracto que determina si se puede extraer un importe.
     * @param p_importe el importe a extraer
     * @return true si se puede extraer, false en caso contrario
     */
    public abstract boolean puedeExtraer(double p_importe);

    /**
     * Deposita un importe en la cuenta.
     * @param p_importe el importe a depositar
     * @return el saldo actual después del depósito
     */
    public double depositar(double p_importe) {
        saldo += p_importe;
        return this.getSaldo();
    }

    /**
     * Método abstracto para extraer un importe de la cuenta.
     * @param p_importe el importe a extraer
     * @return el saldo actual después de la extracción
     */
    public abstract double extraer(double p_importe);

    /**
     * Muestra la información de la cuenta.
     */
    public void mostrar() {
        System.out.printf("Nro. Cuenta: %d - Saldo: %.2f%nTitular: %s%n", 
                          this.getNroCuenta(), this.getSaldo(), titular.nomYApe());
    }

    // Getters and Setters
    public int getNroCuenta() {
        return nroCuenta;
    }

    public void setNroCuenta(int nroCuenta) {
        this.nroCuenta = nroCuenta;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public Persona getTitular() {
        return titular;
    }

    public void setTitular(Persona titular) {
        this.titular = titular;
    }
}


