import java.util.Scanner;

/**
 * Clase principal para manejar las operaciones del banco.
 */
public class Banco {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Ingreso de datos para la persona
        Persona titular = Persona.crearPersona(scanner);

        // Verificar y mostrar mensaje de cumpleaños
        if (titular.esCumpleaños()) {
            System.out.println("¡Feliz cumpleaños, " + titular.getNombre() + " " + titular.getApellido() + "!");
        }

        // Ingreso de datos para la Caja de Ahorro
        System.out.print("Ingrese el número de la Caja de Ahorro: ");
        int nroCajaAhorro = scanner.nextInt();

        System.out.print("Ingrese el saldo inicial de la Caja de Ahorro (0 si no tiene): ");
        double saldoCajaAhorro = scanner.nextDouble();

        CajaDeAhorro cajaAhorro;
        if (saldoCajaAhorro > 0) {
            cajaAhorro = new CajaDeAhorro(nroCajaAhorro, titular, saldoCajaAhorro);
        } else {
            cajaAhorro = new CajaDeAhorro(nroCajaAhorro, titular);
        }

        // Ingreso de datos para la Cuenta Corriente
        System.out.print("Ingrese el número de la Cuenta Corriente: ");
        int nroCuentaCorriente = scanner.nextInt();

        System.out.print("Ingrese el saldo inicial de la Cuenta Corriente (0 si no tiene): ");
        double saldoCuentaCorriente = scanner.nextDouble();

        CuentaCorriente cuentaCorriente;
        if (saldoCuentaCorriente > 0) {
            cuentaCorriente = new CuentaCorriente(nroCuentaCorriente, titular, saldoCuentaCorriente);
        } else {
            cuentaCorriente = new CuentaCorriente(nroCuentaCorriente, titular);
        }

        // Depósitos y extracciones
        System.out.print("Ingrese un importe a depositar en la Caja de Ahorro: ");
        double depositoCajaAhorro = scanner.nextDouble();
        cajaAhorro.depositar(depositoCajaAhorro);
        cajaAhorro.mostrar();

        System.out.print("Ingrese un importe a extraer de la Caja de Ahorro: ");
        double extraccionCajaAhorro = scanner.nextDouble();
        cajaAhorro.extraer(extraccionCajaAhorro);
        cajaAhorro.mostrar();

        System.out.print("Ingrese un importe a depositar en la Cuenta Corriente: ");
        double depositoCuentaCorriente = scanner.nextDouble();
        cuentaCorriente.depositar(depositoCuentaCorriente);
        cuentaCorriente.mostrar();

        System.out.print("Ingrese un importe a extraer de la Cuenta Corriente: ");
        double extraccionCuentaCorriente = scanner.nextDouble();
        cuentaCorriente.extraer(extraccionCuentaCorriente);
        cuentaCorriente.mostrar();

        scanner.close();
    }
}





