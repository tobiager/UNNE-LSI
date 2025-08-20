/**
 * Representa una cuenta corriente en un banco.
 */
public class CuentaCorriente {
    private int nroCuenta;
    private double saldo;
    private final double limiteDescubierto = 500.0;
    private Persona titular;

    /**
     * Crea una nueva cuenta corriente con saldo inicial en 0.
     * 
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     */
    public CuentaCorriente(int p_nroCuenta, Persona p_titular) {
         this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(0.0); // Saldo inicial en 0
    }

    /**
     * Crea una nueva cuenta corriente con el saldo especificado.
     * 
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     * @param p_saldo el saldo inicial de la cuenta
     */
    public CuentaCorriente(int p_nroCuenta, Persona p_titular, double p_saldo) {
         this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(p_saldo);
    }

    /**
     * Verifica si se puede extraer el importe solicitado.
     * 
     * @param p_importe el importe a extraer
     * @return true si el importe es menor o igual al saldo más el límite de descubierto, false en caso contrario
     */
    public boolean puedeExtraer(double p_importe) {
        return p_importe <= (this.getSaldo() + this.limiteDescubierto);
    }

    /**
     * Realiza la extracción del importe solicitado.
     * 
     * @param p_importe el importe a extraer
     */
    private void extraccion(double p_importe) {
        this.saldo -= p_importe;
    }

    /**
     * Extrae el importe solicitado si es posible.
     * 
     * @param p_importe el importe a extraer
     * @return el saldo después de la extracción
     */
    public double extraer(double p_importe) {
        if (puedeExtraer(p_importe)) {
            extraccion(p_importe);
            return this.getSaldo();
        } else {
            System.out.println("El importe de extracción sobrepasa el límite de descubierto!");
            return this.getSaldo();
        }
    }

    /**
     * Deposita el importe especificado en la cuenta.
     * 
     * @param p_importe el importe a depositar
     * @return el saldo después del depósito
     */
    public double depositar(double p_importe) {
        this.saldo += p_importe;
        return this.getSaldo();
    }

    /**
     * Muestra la información de la cuenta corriente.
     */
    public void mostrar() {
        System.out.printf("- Cuenta Corriente -%nNro. Cuenta: %d - Saldo: %.2f%nTitular: %s%nDescubierto: %.2f%n",
                this.getNroCuenta(), this.getSaldo(), titular.nomYApe(), this.limiteDescubierto);
    }

    // Getters y Setters

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

    public double getLimiteDescubierto() {
        return limiteDescubierto;
    }

    public Persona getTitular() {
        return titular;
    }

    public void setTitular(Persona titular) {
        this.titular = titular;
    }
}




