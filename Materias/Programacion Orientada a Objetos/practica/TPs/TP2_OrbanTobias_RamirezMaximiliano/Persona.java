
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * La clase Persona representa a una persona con DNI, nombre, apellido y año de nacimiento.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Persona {
    private int nroDni;
    private String nombre;
    private String apellido;
    private int anioNacimiento;

    /**
     * Constructor de la clase Persona.
     * @param p_dni Número de DNI de la persona.
     * @param p_nombre Nombre de la persona.
     * @param p_apellido Apellido de la persona.
     * @param p_anio Año de nacimiento de la persona.
     */
    public Persona(int p_dni, String p_nombre, String p_apellido, int p_anio) {
        this.nroDni = p_dni;
        this.nombre = p_nombre;
        this.apellido = p_apellido;
        this.anioNacimiento = p_anio;
    }

    /**
     * Establece el número de DNI de la persona.
     * @param p_dni Nuevo número de DNI.
     */
    public void setDNI(int p_dni) {
        this.nroDni = p_dni;
    }

    /**
     * Establece el nombre de la persona.
     * @param p_nombre Nuevo nombre de la persona.
     */
    public void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Establece el apellido de la persona.
     * @param p_apellido Nuevo apellido de la persona.
     */
    public void setApellido(String p_apellido) {
        this.apellido = p_apellido;
    }

    /**
     * Establece el año de nacimiento de la persona.
     * @param p_anio Nuevo año de nacimiento.
     */
    public void setAnioNacimiento(int p_anio) {
        this.anioNacimiento = p_anio;
    }

    /**
     * Retorna el número de DNI de la persona.
     * @return Número de DNI.
     */
    public int getDNI() {
        return this.nroDni;
    }

    /**
     * Retorna el nombre de la persona.
     * @return Nombre de la persona.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Retorna el apellido de la persona.
     * @return Apellido de la persona.
     */
    public String getApellido() {
        return this.apellido;
    }

    /**
     * Retorna el año de nacimiento de la persona.
     * @return Año de nacimiento.
     */
    public int getAnioNacimiento() {
        return this.anioNacimiento;
    }

    /**
     * Calcula y retorna la edad actual de la persona basada en el año de nacimiento.
     * @return Edad actual de la persona.
     */
    public int edad() {
        Calendar fechaHoy = new GregorianCalendar();
        int anioHoy = fechaHoy.get(Calendar.YEAR);
        return anioHoy - anioNacimiento;
    }

    /**
     * Retorna el nombre y apellido de la persona en formato "Nombre Apellido".
     * @return Nombre y apellido en formato "Nombre Apellido".
     */
    public String nomYApe() {
        return nombre + " " + apellido;
    }

    /**
     * Retorna el apellido y nombre de la persona en formato "Apellido, Nombre".
     * @return Apellido y nombre en formato "Apellido, Nombre".
     */
    public String apeYNom() {
        return apellido + ", " + nombre;
    }

    /**
     * Muestra la información de la persona en la consola.
     */
    public void mostrar() {
        System.out.println("Nombre y Apellido: " + nomYApe());
        System.out.println("DNI: " + nroDni);
        System.out.println("Edad: " + edad() + " años");
    }
}

