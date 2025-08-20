
/**
 * Clase que representa una cuenta corriente, que hereda de CuentaBancaria.
 */
public class CuentaCorriente extends CuentaBancaria {
    private final double limiteDescubierto = 500.0;

    /**
     * Constructor de CuentaCorriente.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     */
    public CuentaCorriente(int p_nroCuenta, Persona p_titular) {
        super(p_nroCuenta, p_titular);
    }

    /**
     * Constructor de CuentaCorriente con saldo inicial.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     * @param p_saldo el saldo inicial de la cuenta
     */
    public CuentaCorriente(int p_nroCuenta, Persona p_titular, double p_saldo) {
        super(p_nroCuenta, p_titular, p_saldo);
    }

    @Override
    public boolean puedeExtraer(double p_importe) {
        return p_importe <= (this.getSaldo() + this.limiteDescubierto);
    }

    @Override
    public double extraer(double p_importe) {
        if (puedeExtraer(p_importe)) {
            this.setSaldo(this.getSaldo() - p_importe);
        } else {
            System.out.println("El importe de extracción sobrepasa el límite de descubierto!");
        }
        return this.getSaldo();
    }

    @Override
    public void mostrar() {
        super.mostrar();
        System.out.printf("Descubierto: %.2f%n", limiteDescubierto);
    }
}


