
import java.util.ArrayList;
import java.util.Scanner;

public class Comercio {

    public static void main(String[] args) {
        ArrayList<ArtefactoHogar> artefactos = new ArrayList<>();
        Scanner scanner = new Scanner(System.in);

        int opcion = 0;

        do {
            // Mostrar menú
            System.out.println("***** Bienvenido a la tienda *****");
            System.out.println("Seleccione una opción:");
            System.out.println("1. Ingresar nuevo artefacto");
            System.out.println("2. Quitar artefacto");
            System.out.println("3. Mostrar todos los artefactos");
            System.out.println("4. Calcular cuotas");
            System.out.println("5. Salir");
            System.out.print("Opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    // Opción para ingresar un nuevo artefacto
                    ingresarArtefacto(artefactos, scanner);
                    break;
                case 2:
                    // Opción para quitar un artefacto
                    quitarArtefacto(artefactos, scanner);
                    break;
                case 3:
                    // Opción para mostrar todos los artefactos
                    mostrarArtefactos(artefactos);
                    break;
                case 4:
                    // Opción para calcular cuotas
                    calcularCuotas(artefactos, scanner);
                    break;
                case 5:
                    System.out.println("Saliendo del sistema. ¡Gracias por visitar la tienda!");
                    break;
                default:
                    System.out.println("Opción no válida, por favor elija nuevamente.");
            }
            System.out.println();
        } while (opcion != 5);

        scanner.close();
    }

    // Método para ingresar un nuevo artefacto
    public static void ingresarArtefacto(ArrayList<ArtefactoHogar> artefactos, Scanner scanner) {
        System.out.println("Seleccione el tipo de artefacto a ingresar:");
        System.out.println("1. Cocina");
        System.out.println("2. Heladera");
        System.out.println("3. Lavarropas");
        int tipo = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        System.out.print("Ingrese la marca: ");
        String marca = scanner.nextLine();
        System.out.print("Ingrese el precio: ");
        float precio = scanner.nextFloat();
        System.out.print("Ingrese el stock: ");
        int stock = scanner.nextInt();

        switch (tipo) {
            case 1:
                System.out.print("Ingrese la cantidad de hornallas: ");
                int hornallas = scanner.nextInt();
                System.out.print("Ingrese las calorías: ");
                int calorias = scanner.nextInt();
                scanner.nextLine();
                System.out.print("Ingrese las dimensiones: ");
                String dimensiones = scanner.nextLine();
                artefactos.add(new Cocina(marca, precio, stock, hornallas, calorias, dimensiones));
                break;
            case 2:
                System.out.print("Ingrese la cantidad de pies: ");
                int pies = scanner.nextInt();
                System.out.print("Ingrese la cantidad de puertas: ");
                int puertas = scanner.nextInt();
                System.out.print("¿Tiene compresor? (true/false): ");
                boolean compresor = scanner.nextBoolean();
                artefactos.add(new Heladera(marca, precio, stock, pies, puertas, compresor));
                break;
            case 3:
                System.out.print("Ingrese la cantidad de programas: ");
                int programas = scanner.nextInt();
                System.out.print("Ingrese la capacidad en kilos: ");
                float kilos = scanner.nextFloat();
                System.out.print("¿Es automático? (true/false): ");
                boolean automatico = scanner.nextBoolean();
                artefactos.add(new Lavarropas(marca, precio, stock, programas, kilos, automatico));
                break;
            default:
                System.out.println("Tipo de artefacto no válido.");
        }
        System.out.println("Artefacto ingresado correctamente.");
    }

    // Método para quitar un artefacto
    public static void quitarArtefacto(ArrayList<ArtefactoHogar> artefactos, Scanner scanner) {
        if (artefactos.isEmpty()) {
            System.out.println("No hay artefactos para quitar.");
            return;
        }

        System.out.println("Seleccione el número del artefacto a quitar:");
        mostrarArtefactos(artefactos);

        int indice = scanner.nextInt();
        if (indice > 0 && indice <= artefactos.size()) {
            artefactos.remove(indice - 1);
            System.out.println("Artefacto eliminado correctamente.");
        } else {
            System.out.println("Número inválido.");
        }
    }

    // Método para mostrar todos los artefactos
    public static void mostrarArtefactos(ArrayList<ArtefactoHogar> artefactos) {
        if (artefactos.isEmpty()) {
            System.out.println("No hay artefactos en el sistema.");
        } else {
            for (int i = 0; i < artefactos.size(); i++) {
                System.out.println((i + 1) + ". " + artefactos.get(i).getClass().getSimpleName());
                artefactos.get(i).imprimir();
            }
        }
    }

    // Método para calcular las cuotas
    public static void calcularCuotas(ArrayList<ArtefactoHogar> artefactos, Scanner scanner) {
        if (artefactos.isEmpty()) {
            System.out.println("No hay artefactos en el sistema.");
            return;
        }

        System.out.println("Seleccione el número del artefacto para calcular cuotas:");
        mostrarArtefactos(artefactos);

        int indice = scanner.nextInt();
        if (indice > 0 && indice <= artefactos.size()) {
            ArtefactoHogar seleccionado = artefactos.get(indice - 1);

            System.out.print("Ingrese la cantidad de cuotas: ");
            int cuotas = scanner.nextInt();
            System.out.print("Ingrese el interés (%): ");
            float interes = scanner.nextFloat();

            seleccionado.imprimir();
            float valorCuota = seleccionado.cuotaCredito(cuotas, interes);
            float valorConAdicional = seleccionado.creditoConAdicional(cuotas, interes);
            System.out.println("Cuotas: " + cuotas + " - Interés: " + interes + "%");
            System.out.println("Valor Cuota: " + valorCuota);
            System.out.println("Valor Cuota Con Adicionales: " + valorConAdicional);
        } else {
            System.out.println("Número inválido.");
        }
    }
}


