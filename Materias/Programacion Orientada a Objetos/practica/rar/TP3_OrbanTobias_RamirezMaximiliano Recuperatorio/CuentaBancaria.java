
import java.util.Scanner;

/**
 * La clase CuentaBancaria modela una cuenta bancaria con un número de cuenta,
 * saldo y titular. Proporciona métodos para realizar depósitos, extracciones y 
 * mostrar la información de la cuenta.
 */
public class CuentaBancaria {
    private int nroCuenta;
    private double saldo;
    private Persona titular;

    /**
     * Constructor que inicializa la cuenta bancaria con un número de cuenta y un titular.
     * El saldo inicial es 0.
     *
     * @param p_nroCuenta El número de cuenta bancaria.
     * @param p_titular   El titular de la cuenta.
     */
    public CuentaBancaria(int p_nroCuenta, Persona p_titular) {
        this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(0.0);// Saldo inicial es 0
    }

    /**
     * Constructor que inicializa la cuenta bancaria con un número de cuenta, un titular 
     * y un saldo inicial.
     *
     * @param p_nroCuenta El número de cuenta bancaria.
     * @param p_titular   El titular de la cuenta.
     * @param p_saldo     El saldo inicial de la cuenta.
     */
    public CuentaBancaria(int p_nroCuenta, Persona p_titular, double p_saldo) {
        this.setNroCuenta(p_nroCuenta);
        this.setTitular(p_titular);
        this.setSaldo(p_saldo);
    }

    /**
     * Método accesor para obtener el número de cuenta.
     *
     * @return El número de cuenta bancaria.
     */
    public int getNroCuenta() {
        return nroCuenta;
    }

    /**
     * Método accesor para establecer el número de cuenta.
     *
     * @param nroCuenta El nuevo número de cuenta.
     */
    public void setNroCuenta(int nroCuenta) {
        this.nroCuenta = nroCuenta;
    }

    /**
     * Método accesor para obtener el saldo actual de la cuenta bancaria.
     *
     * @return El saldo actual.
     */
    public double getSaldo() {
        return this.saldo;
    }

    /**
     * Método accesor para establecer un nuevo saldo en la cuenta bancaria.
     *
     * @param saldo El nuevo saldo.
     */
    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    /**
     * Método accesor para obtener el titular de la cuenta bancaria.
     *
     * @return El titular de la cuenta.
     */
    public Persona getTitular() {
        return titular;
    }

    /**
     * Método accesor para establecer el titular de la cuenta bancaria.
     *
     * @param titular El nuevo titular de la cuenta.
     */
    public void setTitular(Persona titular) {
        this.titular = titular;
    }

    /**
     * Método para depositar una cantidad de dinero en la cuenta.
     *
     * @param p_importe El importe a depositar.
     * @return El nuevo saldo después del depósito.
     */
    public double depositar(double p_importe) {
        saldo += p_importe;
        return saldo;
    }

    /**
     * Método para extraer una cantidad de dinero de la cuenta si hay suficiente saldo.
     *
     * @param p_importe El importe a extraer.
     * @return El nuevo saldo después de la extracción o el mismo saldo si no había fondos suficientes.
     */
    public double extraer(double p_importe) {
        if (p_importe <= this.getSaldo()) {
            this.saldo -= p_importe;
        } else {
            System.out.println("Fondos insuficientes");
        }
        return saldo;
    }

    /**
     * Muestra la información de la cuenta bancaria, incluyendo el titular, edad y saldo.
     */
    public void mostrar() {
        System.out.println("- Cuenta Bancaria -");
        System.out.println("Titular: " + titular.nomYApe() + " (" + titular.edad() + " años)");
        System.out.printf("Saldo: %.2f%n", this.getSaldo());
    }

    /**
     * Convierte la información de la cuenta bancaria en una cadena tabulada con el número de cuenta, titular y saldo.
     *
     * @return Una cadena tabulada que contiene el número de cuenta, el nombre del titular y el saldo.
     */
    @Override
    public String toString() {
        return String.format("%d\t%s\t%.2f", this.getNroCuenta(), titular.nomYApe(), this.getSaldo());
    }

    /**
     * Método estático para crear una instancia de CuentaBancaria a partir de la entrada del usuario.
     *
     * @param scanner El objeto Scanner utilizado para leer los datos de entrada del usuario.
     * @return Una nueva instancia de CuentaBancaria con los datos ingresados.
     */
    public static CuentaBancaria crearCuentaBancaria(Scanner scanner) {
        // Crear persona
        Persona persona = Persona.crearPersona(scanner);

        // Ingresar datos para la cuenta bancaria
        System.out.print("Ingrese el número de cuenta: ");
        int nroCuenta = scanner.nextInt();
        System.out.print("Ingrese el saldo inicial (puede ser 0): ");
        double saldoInicial = scanner.nextDouble();

        return new CuentaBancaria(nroCuenta, persona, saldoInicial);
    }

    /**
     * Método principal para probar la clase CuentaBancaria.
     *
     * @param args Los argumentos de la línea de comandos.
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Crear cuenta bancaria
        CuentaBancaria cuenta = crearCuentaBancaria(scanner);

        // Mostrar la información de la cuenta bancaria
        cuenta.mostrar();

        // Ingresar y realizar un depósito
        System.out.print("Ingrese el importe a depositar: ");
        double importeDeposito = scanner.nextDouble();
        cuenta.depositar(importeDeposito);
        System.out.println("Después del depósito:");
        cuenta.mostrar();

        // Ingresar y realizar una extracción
        System.out.print("Ingrese el importe a extraer: ");
        double importeExtraccion = scanner.nextDouble();
        cuenta.extraer(importeExtraccion);
        System.out.println("Después de la extracción:");
        cuenta.mostrar();

        // Mostrar la representación en cadena tabulada
        System.out.println("Información tabulada:");
        System.out.println(cuenta.toString());

        // Cerrar el scanner
        scanner.close();
    }
}


