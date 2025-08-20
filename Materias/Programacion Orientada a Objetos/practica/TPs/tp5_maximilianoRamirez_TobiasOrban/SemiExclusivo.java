
/**
 * Write a description of class semiExclusivo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase SemiExclusivo representa un cargo académico semi-exclusivo,
 * que extiende la clase Cargo. Esta clase incluye información
 * sobre las horas de investigación del cargo.
 */
public class SemiExclusivo extends Cargo {
    
    private int horasInvestigacion;

    /**
     * Constructor para crear un objeto de tipo SemiExclusivo.
     * 
     * @param p_nombreCargo El nombre del cargo.
     * @param p_sueldoBasico El sueldo básico asociado al cargo.
     * @param p_anioIngreso El año en que se ingresó al cargo.
     * @param p_horasDeDocencia Las horas de docencia asignadas.
     * @param p_hInvestigacion Las horas de investigación asignadas.
     */
    public SemiExclusivo(String p_nombreCargo, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia, int p_hInvestigacion) {
        super(p_nombreCargo, p_sueldoBasico, p_anioIngreso, p_horasDeDocencia);
        this.setHorasInvestigacion(p_hInvestigacion);
    }

    /**
     * Establece las horas de investigación.
     * 
     * @param p_hInvestigacion Las horas de investigación a establecer.
     */
    public void setHorasInvestigacion(int p_hInvestigacion) {
        this.horasInvestigacion = p_hInvestigacion;
    }

    /**
     * Obtiene las horas de investigación.
     * 
     * @return Las horas de investigación.
     */
    public int getHorasInvestigacion() {
        return this.horasInvestigacion;
    }

    /**
     * Muestra la información del cargo semi-exclusivo, incluyendo
     * las horas de investigación.
     */
    public void mostrarCargo() {
        super.mostrarCargo();
        System.out.println("---Cargo de caracter semiExclusivo---");
        System.out.println("horas de investigacion: " + this.getHorasInvestigacion());
    }
}

