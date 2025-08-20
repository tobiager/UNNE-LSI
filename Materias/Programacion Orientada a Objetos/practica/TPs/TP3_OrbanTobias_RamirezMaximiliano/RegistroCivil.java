import java.util.Scanner;

/**
 * Clase principal para manejar el registro civil, incluyendo el matrimonio y divorcio entre personas.
 */
public class RegistroCivil {
    /**
     * Método principal para ejecutar el programa de registro civil.
     * @param args Argumentos de línea de comandos (no utilizados).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Ingresar datos de la mujer
        System.out.print("Ingrese el nombre de la mujer: ");
        String nombreMujer = scanner.nextLine();
        System.out.print("Ingrese el apellido de la mujer: ");
        String apellidoMujer = scanner.nextLine();
        System.out.print("Ingrese la edad de la mujer: ");
        int edadMujer = scanner.nextInt();
        scanner.nextLine();  // Consumir la nueva línea
        System.out.print("Ingrese el estado civil de la mujer (Soltera/Casada/Divorciada): ");
        String estadoCivilMujer = scanner.nextLine();

        Mujer mujer = new Mujer(nombreMujer, apellidoMujer, edadMujer);
        mujer.setEstadoCivi(estadoCivilMujer);  // Seteamos el estado civil ingresado

        // Ingresar datos del hombre
        System.out.print("Ingrese el nombre del hombre: ");
        String nombreHombre = scanner.nextLine();
        System.out.print("Ingrese el apellido del hombre: ");
        String apellidoHombre = scanner.nextLine();
        System.out.print("Ingrese la edad del hombre: ");
        int edadHombre = scanner.nextInt();
        scanner.nextLine();  // Consumir la nueva línea
        System.out.print("Ingrese el estado civil del hombre (Soltero/Casado/Divorciado): ");
        String estadoCivilHombre = scanner.nextLine();

        Hombre hombre = new Hombre(nombreHombre, apellidoHombre, edadHombre);
        hombre.setEstadoCivil(estadoCivilHombre);  // Seteamos el estado civil ingresado

        // Preguntar si desean casarse
        System.out.print("¿Desean casarse? (si/no): ");
        String deseaCasarse = scanner.nextLine();

        if (deseaCasarse.equalsIgnoreCase("si")) {
            // Verificar si ambos están solteros
            if (mujer.getEstadoCivi().equalsIgnoreCase("Soltera") && hombre.getEstadoCivil().equalsIgnoreCase("Soltero")) {
                mujer.casarseCon(hombre);

                // Mostrar el estado civil después del matrimonio
                mujer.mostrarEstadoCivil();
                hombre.mostrarEstadoCivil();

                // Mostrar con quién está casado cada uno
                mujer.casadaCon();
                hombre.casadoCon();

                // Preguntar si desean divorciarse
                System.out.print("¿Desean divorciarse? (si/no): ");
                String deseaDivorciarse = scanner.nextLine();

                if (deseaDivorciarse.equalsIgnoreCase("si")) {
                    mujer.divorcio();
                    hombre.divorcio();

                    // Mostrar el estado civil después del divorcio
                    mujer.mostrarEstadoCivil();
                    hombre.mostrarEstadoCivil();
                }
            } else {
                System.out.println("No pueden casarse porque uno o ambos no están solteros.");
            }
        } else {
            System.out.println("Decidieron no casarse.");
        }

        scanner.close();
    }
}


