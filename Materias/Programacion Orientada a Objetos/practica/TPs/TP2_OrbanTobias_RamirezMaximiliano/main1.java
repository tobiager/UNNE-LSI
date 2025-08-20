import java.util.GregorianCalendar;
import java.util.Calendar;

/**
 * Clase principal que contiene el método main para interactuar con la clase Persona.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class main1 {

    /**
     * Método principal que crea una instancia de la clase Persona, muestra su información, y muestra el año actual.
     * @param args Los argumentos pasados a través de la línea de comandos.
     */
    public static void main(String[] args) {
        
        // Crear una instancia de la clase Persona
        Persona persona = new Persona(35123456, "Juan", "Perez", 2001);

        // Mostrar la información de la persona
        persona.mostrar();

        // Obtener y mostrar el año actual
        Calendar fechaHoy = new GregorianCalendar();
        int anioHoy = fechaHoy.get(Calendar.YEAR);
        System.out.print("El año actual es: " + anioHoy);
    }
}



