
/**
 * Clase que representa una cuenta de ahorro, que hereda de CuentaBancaria.
 */
public class CajaDeAhorro extends CuentaBancaria {
    private int extraccionesPosibles = 10;

    /**
     * Constructor de CajaDeAhorro.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     */
    public CajaDeAhorro(int p_nroCuenta, Persona p_titular) {
        super(p_nroCuenta, p_titular);
    }

    /**
     * Constructor de CajaDeAhorro con saldo inicial.
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     * @param p_saldo el saldo inicial de la cuenta
     */
    public CajaDeAhorro(int p_nroCuenta, Persona p_titular, double p_saldo) {
        super(p_nroCuenta, p_titular, p_saldo);
    }

    @Override
    public boolean puedeExtraer(double p_importe) {
        if (extraccionesPosibles == 0) {
            System.out.println("No tiene habilitadas más extracciones!");
            return false;
        }
        if (p_importe > this.getSaldo()) {
            System.out.println("No puede extraer más que el saldo!");
            return false;
        }
        return true;
    }

    @Override
    public double extraer(double p_importe) {
        if (puedeExtraer(p_importe)) {
            this.setSaldo(this.getSaldo() - p_importe);
            extraccionesPosibles--;
        }
        return this.getSaldo();
    }

    @Override
    public void mostrar() {
        super.mostrar();
        System.out.printf("Extracciones posibles: %d%n", extraccionesPosibles);
    }
}


