import java.util.ArrayList;
import java.util.Scanner;

public class AplicacionBanco {
    private Banco banco;
    private ArrayList<Empleado> empleados;
    private ArrayList<CuentaBancaria> cuentas;

    public AplicacionBanco(Banco banco) {
        this.banco = banco;
        this.empleados = new ArrayList<>();
        this.cuentas = new ArrayList<>();
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Creating the bank object and the related locality
        Localidad localidad = new Localidad("Saladas", "Corrientes");
        Banco banco = new Banco("Rio", localidad, 3);
        AplicacionBanco app = new AplicacionBanco(banco);

        int option;
        do {
            System.out.println("\nMenú de Aplicación del Banco");
            System.out.println("1. Agregar Empleado");
            System.out.println("2. Quitar Empleado");
            System.out.println("3. Agregar Cuenta Bancaria");
            System.out.println("4. Quitar Cuenta Bancaria");
            System.out.println("5. Emitir Resumen");
            System.out.println("6. Mostrar Empleados");
            System.out.println("7. Salir");
            System.out.print("Seleccione una opción: ");
            option = scanner.nextInt();

            switch (option) {
                case 1:
                    app.agregarEmpleado(scanner);
                    break;
                case 2:
                    app.quitarEmpleado(scanner);
                    break;
                case 3:
                    app.agregarCuentaBancaria(scanner);
                    break;
                case 4:
                    app.quitarCuentaBancaria(scanner);
                    break;
                case 5:
                    app.emitirResumen();
                    break;
                case 6:
                    app.mostrarEmpleados();
                    break;
                case 7:
                    System.out.println("Saliendo del sistema.");
                    break;
                default:
                    System.out.println("Opción no válida.");
            }
        } while (option != 7);

        scanner.close();
    }

    public void agregarEmpleado(Scanner scanner) {
        System.out.print("Ingrese el nombre del empleado: ");
        String nombre = scanner.next();
        System.out.print("Ingrese el apellido del empleado: ");
        String apellido = scanner.next();
        System.out.print("Ingrese el cuil del empleado: ");
        long cuil = scanner.nextLong();
        Empleado empleado = new Empleado(nombre, apellido, cuil);
        empleados.add(empleado);
        System.out.println("Empleado agregado exitosamente.");
    }

    public void quitarEmpleado(Scanner scanner) {
        System.out.print("Ingrese el CUIL del empleado a quitar: ");
        long cuil = scanner.nextInt();
        Empleado empleadoAEliminar = null;
        for (Empleado empleado : empleados) {
            if (empleado.getCuil() == cuil) {
                empleadoAEliminar = empleado;
                break;
            }
        }
        if (empleadoAEliminar != null) {
            empleados.remove(empleadoAEliminar);
            System.out.println("Empleado eliminado.");
        } else {
            System.out.println("Empleado no encontrado.");
        }
    }

    public void agregarCuentaBancaria(Scanner scanner) {
        System.out.print("Ingrese el número de cuenta bancaria: ");
        int pNroCuenta = scanner.nextInt();

        System.out.print("Ingrese el saldo de la cuenta: ");
        double pSaldo = scanner.nextDouble();
        scanner.nextLine(); // Limpiar el buffer después de nextDouble()

        // Datos del titular
        System.out.print("Ingrese el DNI del titular: ");
        int dni = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer después de nextInt()

        System.out.print("Ingrese el nombre del titular: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido del titular: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el año de nacimiento del titular: ");
        int anioNacimiento = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer después de nextInt()

        // Crear el objeto Persona
        Persona pTitular = new Persona(dni, nombre, apellido, anioNacimiento);

        // Crear el objeto CuentaBancaria
        CuentaBancaria cuenta = new CuentaBancaria(pNroCuenta, pTitular, pSaldo);

        // Agregar la cuenta a la lista de cuentas
        cuentas.add(cuenta);

        System.out.println("Cuenta bancaria agregada exitosamente.");
    }

    public void quitarCuentaBancaria(Scanner scanner) {
        System.out.print("Ingrese el número de cuenta bancaria a quitar: ");
        int nroCuenta = scanner.nextInt();
        CuentaBancaria cuentaAEliminar = null;
        for (CuentaBancaria cuenta : cuentas) {
            if (cuenta.getNroCuenta() == nroCuenta) {
                cuentaAEliminar = cuenta;
                break;
            }
        }
        if (cuentaAEliminar != null) {
            cuentas.remove(cuentaAEliminar);
            System.out.println("Cuenta bancaria eliminada.");
        } else {
            System.out.println("Cuenta bancaria no encontrada.");
        }
    }

    public void emitirResumen() {
        int totalCuentas = cuentas.size();
        int cuentasActivas = 0;
        int cuentasSaldoCero = 0;
        ArrayList<CuentaBancaria> cuentasSinSaldo = new ArrayList<>();
        ArrayList<String> clientes = new ArrayList<>();

        for (CuentaBancaria cuenta : cuentas) {
            if (cuenta.getSaldo() > 0) {
                cuentasActivas++;
                clientes.add(cuenta.getTitular().getApellido() + ", " + cuenta.getTitular().getNombre());
            } else {
                cuentasSaldoCero++;
                cuentasSinSaldo.add(cuenta);
            }
        }

        System.out.println("************************************************************");
        System.out.println("Banco: " + banco.getNombre() + " - Sucursal: " + banco.getNroSucursal());
        System.out.println(banco.getLocalidad().mostrar());
        System.out.println("************************************************************");
        System.out.println("RESUMEN DE CUENTAS BANCARIAS");
        System.out.println("************************************************************");
        System.out.println("Número total de Cuentas Bancarias: " + totalCuentas);
        System.out.println("Cuentas Activas: " + cuentasActivas);
        System.out.println("Cuentas Saldo Cero: " + cuentasSaldoCero);
        System.out.println("-------------------------------------------------------------------------------------------");
        System.out.println("Cuentas sin saldo:");
        System.out.println("--- Cuenta -------------------- Apellido y Nombre ---------------");
        for (CuentaBancaria cuenta : cuentasSinSaldo) {
            System.out.println(cuenta.getNroCuenta() + " " + cuenta.getTitular().getApellido() + ", " + cuenta.getTitular().getNombre());
        }
        System.out.println("----------------------------------------------------------------------------------------------------");

        System.out.print("Listado de Clientes: ");
        for (int i = 0; i < clientes.size(); i++) {
            System.out.print(clientes.get(i));
            if (i < clientes.size() - 1) {
                System.out.print("; ");
            }
        }
        System.out.println();
    }

    public void mostrarEmpleados() {
        if (empleados.isEmpty()) {
            System.out.println("No hay empleados registrados.");
        } else {
            System.out.println("************************************************************");
            System.out.println("LISTADO DE EMPLEADOS");
            System.out.println("************************************************************");
            for (Empleado empleado : empleados) {
                System.out.println("Empleado: " + empleado.getApellido() + ", " + empleado.getNombre() + " - CUIL: " + empleado.getCuil());
            }
        }
    }
}




