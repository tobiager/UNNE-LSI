
/**
 * Write a description of class Cargo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.time.LocalDate;

/**
 * La clase Cargo representa un cargo académico, que incluye
 * información sobre el nombre del cargo, sueldo básico,
 * año de ingreso y horas de docencia.
 */
public class Cargo {
    private String nombreCargo;
    private double sueldoBasico;
    private int anioIngreso;
    private int horasDeDocencia;

    /**
     * Constructor para crear un objeto de tipo Cargo.
     * 
     * @param p_nombreCargo El nombre del cargo.
     * @param p_sueldoBasico El sueldo básico asociado al cargo.
     * @param p_anioIngreso El año en que se ingresó al cargo.
     * @param p_horasDeDocencia Las horas de docencia asignadas.
     */
    public Cargo(String p_nombreCargo, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia) {
        this.setNCargo(p_nombreCargo);
        this.setSBasico(p_sueldoBasico);
        this.setAnioIngreso(p_anioIngreso);
        this.setHoras(p_horasDeDocencia);
    }

    /**
     * Establece el nombre del cargo.
     * 
     * @param p_nombreCargo El nombre del cargo a establecer.
     */
    public void setNCargo(String p_nombreCargo) {
        this.nombreCargo = p_nombreCargo;
    }

    /**
     * Establece el sueldo básico del cargo.
     * 
     * @param p_sueldoBasico El sueldo básico a establecer.
     */
    public void setSBasico(double p_sueldoBasico) {
        this.sueldoBasico = p_sueldoBasico;
    }

    /**
     * Establece el año de ingreso al cargo.
     * 
     * @param p_anioIngreso El año de ingreso a establecer.
     */
    public void setAnioIngreso(int p_anioIngreso) {
        this.anioIngreso = p_anioIngreso;
    }

    /**
     * Establece las horas de docencia del cargo.
     * 
     * @param p_horasDeDocencia Las horas de docencia a establecer.
     */
    public void setHoras(int p_horasDeDocencia) {
        this.horasDeDocencia = p_horasDeDocencia;
    }

    /**
     * Obtiene el nombre del cargo.
     * 
     * @return El nombre del cargo.
     */
    public String getNCargo() {
        return this.nombreCargo;
    }

    /**
     * Obtiene el sueldo básico del cargo.
     * 
     * @return El sueldo básico.
     */
    public double getSBasico() {
        return this.sueldoBasico;
    }

    /**
     * Obtiene el año de ingreso al cargo.
     * 
     * @return El año de ingreso.
     */
    public int getAnioIngreso() {
        return this.anioIngreso;
    }

    /**
     * Obtiene las horas de docencia del cargo.
     * 
     * @return Las horas de docencia.
     */
    public int getHoras() {
        return this.horasDeDocencia;
    }

    /**
     * Calcula la antigüedad del cargo en años.
     * 
     * @return La antigüedad en años.
     */
    public int antiguedad() {
        LocalDate fechaActual = LocalDate.now();
        int año = fechaActual.getYear();
        
        return año - this.getAnioIngreso();
    }

    /**
     * Calcula el adicional por antigüedad.
     * 
     * @return El adicional por antigüedad.
     */
    private double adicionalXantiguedad() {
        return this.getSBasico() * 0.01 * this.antiguedad();
    }

    /**
     * Calcula el sueldo total del cargo, incluyendo
     * el adicional por antigüedad.
     * 
     * @return El sueldo total del cargo.
     */
    public double sueldoDelCargo() {
        return this.getSBasico() + this.adicionalXantiguedad();
    }

    /**
     * Muestra la información del cargo, incluyendo
     * el sueldo básico, el sueldo total y la antigüedad.
     */
    public void mostrarCargo() {
        System.out.println(this.getNCargo() + "- sueldo basico: " + this.getSBasico()
                + "- sueldo Cargo: " + this.sueldoDelCargo() + "- antigüedad: " +
                this.antiguedad()); 
        System.out.println("horas docencia: " + this.getHoras());
    }
}


