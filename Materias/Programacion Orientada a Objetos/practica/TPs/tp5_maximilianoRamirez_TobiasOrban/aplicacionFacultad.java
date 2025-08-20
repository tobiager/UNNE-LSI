
/**
 * Write a description of class executable here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.ArrayList;

/**
 * La clase aplicacionFacultad contiene el método principal
 * para ejecutar la aplicación de gestión de facultades,
 * profesores y cargos.
 */
public class aplicacionFacultad {
    
    /**
     * Método principal que inicia la aplicación de gestión de facultades.
     * 
     * @param args Argumentos de línea de comandos (no utilizados).
     */
    public static void aplicacionBanco(String[] args) {
        ArrayList<Cargo> cargos = new ArrayList<>();
        
        // Crear una persona
        Persona per1 = new Persona(3654214, "Fabian", "Fernandez", 2002);
        
        // Crear un cargo
        Cargo car1 = new Cargo("Inglés Técnico", 50000.0, 2010, 10);
        cargos.add(car1);
        
        // Crear un profesor
        Profesor pro1 = new Profesor(3654214, "Fabian", "Fernandez", 2002, "Licenciatura en Sistemas", car1, cargos);
        
        // Crear una facultad y listar los profesores y cargos
        Facultad facu = new Facultad("Facultad de Lomas de Zamora", pro1);
        facu.listarProfesoresCargos();
    }
}

