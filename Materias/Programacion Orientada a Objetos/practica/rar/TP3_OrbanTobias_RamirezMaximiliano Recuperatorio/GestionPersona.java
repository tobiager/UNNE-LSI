
import java.util.Scanner;

public class GestionPersona {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Crear una instancia de Persona usando el método crearPersona
        Persona persona = Persona.crearPersona(scanner);

        // Mostrar los datos de la persona
        persona.mostrar();

        scanner.close();
    }
}

