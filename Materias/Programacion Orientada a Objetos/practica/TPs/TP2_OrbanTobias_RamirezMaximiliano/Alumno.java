/**
 * Clase que representa a un Alumno con su LU, nombre, apellido, y notas.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Alumno {
    private int lu;
    private String nombre;
    private String apellido;
    private double nota1;
    private double nota2;

    /**
     * Constructor que inicializa los atributos del alumno.
     * @param p_lu Número de LU del alumno.
     * @param p_nombre Nombre del alumno.
     * @param p_apellido Apellido del alumno.
     */
    public Alumno(int p_lu, String p_nombre, String p_apellido) {    
       this.lu = p_lu;
       this.nombre = p_nombre;
       this.apellido = p_apellido;
    }

    // Observadores (Getters)
    public int getLu() {
        return this.lu;
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    public double getNota1() {
        return this.nota1;
    }

    public double getNota2() {
        return this.nota2;
    }

    // Mutadores (Setters)
    public void setLu(int p_lu) {
        this.lu = p_lu;
    }

    public void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    public void setApellido(String p_apellido) {
        this.apellido = p_apellido;
    }

    public void setNota1(double p_nota1) {
        this.nota1 = p_nota1;
    }

    public void setNota2(double p_nota2) {
        this.nota2 = p_nota2;
    }

    /**
     * Método que calcula si el alumno aprueba basado en sus notas.
     * @return true si el alumno aprueba, false en caso contrario.
     */
    public boolean aprueba() {
        return (((this.nota1 >= 6) && (this.nota2 >= 6)) && (this.promedio() >= 7));
    }

    /**
     * Método privado que retorna la leyenda de aprobación.
     * @return "APROBADO" si el alumno aprueba, "DESAPROBADO" en caso contrario.
     */
    private String leyendaAprueba() {
        return this.aprueba() ? "APROBADO" : "DESAPROBADO";
    }

    /**
     * Método que calcula el promedio de las notas del alumno.
     * @return El promedio de las dos notas.
     */
    public double promedio() {
        return (this.nota1 + this.nota2) / 2;
    }

    /**
     * Método que retorna el nombre y apellido del alumno.
     * @return Una cadena con el nombre y apellido.
     */
    public String nomYape() {
        return this.nombre + " " + this.apellido;
    }

    /**
     * Método que retorna el apellido y nombre del alumno.
     * @return Una cadena con el apellido y nombre.
     */
    public String apeYnom() {
        return this.apellido + " " + this.nombre;
    }

    /**
     * Método que muestra la información del alumno.
     */
    public void mostrar() {
        System.out.println("Nombre y Apellido: " + nomYape());
        System.out.println("LU: " + lu + "  Notas: " + nota1 + " - " + nota2);
        System.out.println("Promedio: " + promedio() + " - " + leyendaAprueba());
    }
}

