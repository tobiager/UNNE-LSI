/**
 * Clase que representa a un Alumno con su LU, nombre, apellido, y notas.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
import java.util.Calendar;
import java.util.GregorianCalendar;

public class Alumno extends Persona {
    
    private int lu;
    private double nota1;
    private double nota2;

    /**
     * Constructor que inicializa los atributos del alumno.
     * @param p_lu Número de LU del alumno.
     * @param p_nombre Nombre del alumno.
     * @param p_apellido Apellido del alumno.
     */
    public Alumno(int p_lu, int p_dni, String p_nombre, String p_apellido, int p_anio) {   
       super(p_dni, p_nombre, p_apellido, p_anio);
       this.setLu(p_lu);
       this.setNota1(0);
       this.setNota2(0);
    }

    // Observadores (Getters)
    public int getLu() {
        return this.lu;
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
     * Método que muestra la información del alumno.
     */
    public void mostrar() {
        super.mostrar();
        System.out.println("LU: " + lu + "  Notas: " + nota1 + " - " + nota2);
        System.out.println("Promedio: " + promedio() + " - " + leyendaAprueba());
    }
}

