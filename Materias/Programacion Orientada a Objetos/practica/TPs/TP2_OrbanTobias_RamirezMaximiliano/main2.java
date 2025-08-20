
/**
 * Clase principal que contiene el método main para ejecutar el programa.
 * Crea una instancia de la clase Laboratorio y muestra su información.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class main2 {
    
    /**
     * Método principal que se ejecuta al iniciar el programa.
     * Crea un objeto Laboratorio y muestra su información.
     *
     * @param args Argumentos pasados por línea de comandos (no se utilizan en este programa).
     */
    public static void main(String[] args) {
        
        // Creación de un objeto Laboratorio con valores de ejemplo.
        Laboratorio lab1 = new Laboratorio("Colgate S.A.", "Junín 5204 ", "54-11-4239-8447", 1000, 7);
        
        // Muestra la información del laboratorio.
        System.out.println(lab1.mostrar());
    }
}

