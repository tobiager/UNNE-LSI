/**
 * Representa una caja de ahorro en un banco.
 */
public class CajaDeAhorro {
    private int nroCuenta;
    private double saldo;
    private int extraccionesPosibles = 10;
    private Persona titular;

    /**
     * Crea una nueva caja de ahorro con saldo inicial en 0.
     * 
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     */
    public CajaDeAhorro(int p_nroCuenta, Persona p_titular) {
        this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(0.0); // Saldo inicial en 0
    }

    /**
     * Crea una nueva caja de ahorro con el saldo especificado.
     * 
     * @param p_nroCuenta el número de cuenta
     * @param p_titular el titular de la cuenta
     * @param p_saldo el saldo inicial de la cuenta
     */
    public CajaDeAhorro(int p_nroCuenta, Persona p_titular, double p_saldo) {
        this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(p_saldo);
    }

    /**
     * Verifica si se puede extraer el importe solicitado.
     * 
     * @param p_importe el importe a extraer
     * @return true si el importe es menor o igual al saldo y aún hay extracciones posibles, false en caso contrario
     */
    public boolean puedeExtraer(double p_importe) {
        if (extraccionesPosibles == 0) {
            System.out.println("No tiene habilitadas más extracciones!");
            return false;
        }
        if (p_importe > saldo) {
            System.out.println("No puede extraer más que el saldo!");
            return false;
        }
        return true;
    }

    /**
     * Realiza la extracción del importe solicitado.
     * 
     * @param p_importe el importe a extraer
     */
    private void extraccion(double p_importe) {
        this.saldo -= p_importe;
        extraccionesPosibles--;
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
        }
        return this.getSaldo();
    }

    /**
     * Deposita el importe especificado en la cuenta.
     * 
     * @param p_importe el importe a depositar
     * @return el saldo después del depósito
     */
    public double depositar(double p_importe) {
        saldo += p_importe;
        return this.getSaldo();
    }

    /**
     * Muestra la información de la caja de ahorro.
     */
    public void mostrar() {
        System.out.printf("- Caja de Ahorro -%nNro. Cuenta: %d - Saldo: %.2f%nTitular: %s%nExtracciones posibles: %d%n",
                this.getNroCuenta() , this.getSaldo(), titular.nomYApe(), this.extraccionesPosibles);
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

    public int getExtraccionesPosibles() {
        return extraccionesPosibles;
    }

    public void setExtraccionesPosibles(int extraccionesPosibles) {
        this.extraccionesPosibles = extraccionesPosibles;
    }

    public Persona getTitular() {
        return titular;
    }

    public void setTitular(Persona titular) {
        this.titular = titular;
    }
}



