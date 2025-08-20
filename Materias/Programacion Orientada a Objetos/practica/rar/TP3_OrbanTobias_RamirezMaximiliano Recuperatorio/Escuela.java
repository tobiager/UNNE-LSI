
import java.util.Scanner;

/**
 * La clase Escuela representa una institución educativa con un nombre, domicilio y director.
 * Proporciona un método para imprimir un recibo de sueldo para un docente.
 */
public class Escuela {
    private String nombre;
    private String domicilio;
    private String director;

    /**
     * Constructor que inicializa la escuela con su nombre, domicilio y director.
     * 
     * @param nombre El nombre de la escuela.
     * @param domicilio El domicilio de la escuela.
     * @param director El nombre del director de la escuela.
     */
    public Escuela(String p_nombre, String p_domicilio, String p_director) {
        this.setNombre(p_nombre);
        this.setDomicilio(p_domicilio);
        this.setDirector(p_director);
    }

    /**
     * Método accesor para obtener el nombre de la escuela.
     *
     * @return El nombre de la escuela.
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Método accesor para establecer el nombre de la escuela.
     *
     * @param nombre El nuevo nombre de la escuela.
     */
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Método accesor para obtener el domicilio de la escuela.
     *
     * @return El domicilio de la escuela.
     */
    public String getDomicilio() {
        return domicilio;
    }

    /**
     * Método accesor para establecer el domicilio de la escuela.
     *
     * @param domicilio El nuevo domicilio de la escuela.
     */
    private void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    /**
     * Método accesor para obtener el nombre del director de la escuela.
     *
     * @return El nombre del director.
     */
    public String getDirector() {
        return director;
    }

    /**
     * Método accesor para establecer el nombre del director de la escuela.
     *
     * @param director El nuevo nombre del director.
     */
    private void setDirector(String director) {
        this.director = director;
    }

    /**
     * Imprime un recibo de sueldo para un docente, mostrando el nombre de la escuela,
     * el domicilio, el director, y el sueldo del docente.
     *
     * @param docente El docente cuyo recibo de sueldo se va a imprimir.
     */
    public void imprimirRecibo(Docente docente) {
        double sueldoTotal = docente.calcularSueldo();
        System.out.println("Escuela: " + this.getNombre() + "  Domicilio: " + this.getDomicilio() + "  Director: " + this.getDirector());
        System.out.println("--------------------------------------------------------------------------------------------------------------");
        System.out.println("Docente: " + docente.getNombre() + ".");
        System.out.println("Sueldo: ……………………………. $ " + sueldoTotal);
        System.out.println("Sueldo Básico…………………. $ " + docente.getSueldoBasico());
        System.out.println("Asignación familiar…………… $ " + docente.getAsignacionFamiliar());
    }
}


