
import java.util.Scanner;
import java.util.ArrayList;

public class Banco {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Persona> personas = new ArrayList<>();
        ArrayList<CuentaCorriente> cuentasCorrientes = new ArrayList<>();
        ArrayList<CajaDeAhorro> cuentasAhorro = new ArrayList<>();
        int opcion;

        do {
            System.out.println("Menú:");
            System.out.println("1. Agregar Persona y Cuentas");
            System.out.println("2. Eliminar Persona y Cuentas");
            System.out.println("3. Mostrar Personas y Cuentas");
            System.out.println("4. Depositar en Cuenta");
            System.out.println("5. Extraer de Cuenta");
            System.out.println("6. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    // Pedir información de la persona
                    System.out.print("Ingrese el DNI de la persona: ");
                    int dni = scanner.nextInt();
                    System.out.print("Ingrese el nombre de la persona: ");
                    String nombre = scanner.next();
                    System.out.print("Ingrese el apellido: ");
                    String apellido = scanner.next();
                    System.out.print("Ingrese el año de nacimiento: ");
                    int anioNacimiento = scanner.nextInt();

                    // Crear objeto Persona
                    Persona persona = new Persona(dni, nombre, apellido, anioNacimiento);
                    personas.add(persona);

                    // Crear cuentas para la persona
                    System.out.print("Ingrese el número de cuenta corriente: ");
                    int nroCuentaCorriente = scanner.nextInt();
                    System.out.print("Ingrese el número de caja de ahorro: ");
                    int nroCuentaAhorro = scanner.nextInt();

                    // Asociar las cuentas a la persona
                    CuentaCorriente cuentaCorriente = new CuentaCorriente(nroCuentaCorriente, persona);
                    CajaDeAhorro cuentaAhorro = new CajaDeAhorro(nroCuentaAhorro, persona);

                    cuentasCorrientes.add(cuentaCorriente);
                    cuentasAhorro.add(cuentaAhorro);

                    System.out.println("Persona y cuentas agregadas correctamente.");
                    break;

                case 2:
                    System.out.print("Ingrese el nombre de la persona a eliminar: ");
                    String nombreEliminar = scanner.next();
                    boolean encontrado = false;

                    for (int i = 0; i < personas.size(); i++) {
                        if (personas.get(i).getNombre().equals(nombreEliminar)) {
                            personas.remove(i);
                            cuentasCorrientes.remove(i); // Asumimos que las cuentas están en el mismo índice
                            cuentasAhorro.remove(i);
                            encontrado = true;
                            System.out.println("Persona y cuentas eliminadas.");
                            break;
                        }
                    }

                    if (!encontrado) {
                        System.out.println("Persona no encontrada.");
                    }
                    break;

                case 3:
                    System.out.println("Personas y Cuentas:");
                    for (int i = 0; i < personas.size(); i++) {
                        System.out.println("Persona: " + personas.get(i).nomYApe());
                        cuentasCorrientes.get(i).mostrar();
                        cuentasAhorro.get(i).mostrar();
                    }
                    break;

                case 4:
                    System.out.print("Ingrese el número de cuenta para depositar: ");
                    int nroCuentaDeposito = scanner.nextInt();
                    boolean cuentaEncontrada = false;

                    // Buscar en cuentas corrientes
                    for (CuentaCorriente cuenta : cuentasCorrientes) {
                        if (cuenta.getNroCuenta() == nroCuentaDeposito) {
                            System.out.print("Ingrese el monto a depositar: ");
                            double monto = scanner.nextDouble();
                            cuenta.depositar(monto);
                            System.out.println("Nuevo saldo: " + cuenta.getSaldo());
                            cuentaEncontrada = true;
                            break;
                        }
                    }

                    // Buscar en cajas de ahorro
                    if (!cuentaEncontrada) {
                        for (CajaDeAhorro cuenta : cuentasAhorro) {
                            if (cuenta.getNroCuenta() == nroCuentaDeposito) {
                                System.out.print("Ingrese el monto a depositar: ");
                                double monto = scanner.nextDouble();
                                cuenta.depositar(monto);
                                System.out.println("Nuevo saldo: " + cuenta.getSaldo());
                                cuentaEncontrada = true;
                                break;
                            }
                        }
                    }

                    if (!cuentaEncontrada) {
                        System.out.println("Cuenta no encontrada.");
                    }
                    break;

                case 5:
                    System.out.print("Ingrese el número de cuenta para extraer: ");
                    int nroCuentaExtraccion = scanner.nextInt();
                    cuentaEncontrada = false;

                    // Buscar en cuentas corrientes
                    for (CuentaCorriente cuenta : cuentasCorrientes) {
                        if (cuenta.getNroCuenta() == nroCuentaExtraccion) {
                            System.out.print("Ingrese el monto a extraer: ");
                            double monto = scanner.nextDouble();
                            cuenta.extraer(monto);
                            System.out.println("Nuevo saldo: " + cuenta.getSaldo());
                            cuentaEncontrada = true;
                            break;
                        }
                    }

                    // Buscar en cajas de ahorro
                    if (!cuentaEncontrada) {
                        for (CajaDeAhorro cuenta : cuentasAhorro) {
                            if (cuenta.getNroCuenta() == nroCuentaExtraccion) {
                                System.out.print("Ingrese el monto a extraer: ");
                                double monto = scanner.nextDouble();
                                cuenta.extraer(monto);
                                System.out.println("Nuevo saldo: " + cuenta.getSaldo());
                                cuentaEncontrada = true;
                                break;
                            }
                        }
                    }

                    if (!cuentaEncontrada) {
                        System.out.println("Cuenta no encontrada.");
                    }
                    break;

                case 6:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opción no válida. Intente nuevamente.");
            }
            System.out.println();
        } while (opcion != 6);

        scanner.close();
    }
}



