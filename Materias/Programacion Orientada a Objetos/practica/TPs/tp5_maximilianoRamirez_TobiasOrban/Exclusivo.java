
/**
 * Write a description of class exclusivo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase Exclusivo representa un cargo académico exclusivo,
 * que extiende la clase Cargo. Esta clase incluye información
 * sobre las horas de investigación y horas de extensión del cargo.
 */
public class Exclusivo extends Cargo {
    
    private int horasInvestigacion;
    private int horasExtension;

    /**
     * Constructor para crear un objeto de tipo Exclusivo.
     * 
     * @param p_nombreCargo El nombre del cargo.
     * @param p_sueldoBasico El sueldo básico asociado al cargo.
     * @param p_anioIngreso El año en que se ingresó al cargo.
     * @param p_horasDeDocencia Las horas de docencia asignadas.
     * @param p_hInvestigacion Las horas de investigación asignadas.
     * @param p_horasExtension Las horas de extensión asignadas.
     */
    public Exclusivo(String p_nombreCargo, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia, int p_hInvestigacion, int p_horasExtension) {
        super(p_nombreCargo, p_sueldoBasico, p_anioIngreso, p_horasDeDocencia);
        this.setHorasInvestigacion(p_hInvestigacion);
        this.setHorasExtencion(p_horasExtension);
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
     * Establece las horas de extensión.
     * 
     * @param p_horasExtencion Las horas de extensión a establecer.
     */
    public void setHorasExtencion(int p_horasExtencion) {
        this.horasExtension = p_horasExtencion;
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
     * Obtiene las horas de extensión.
     * 
     * @return Las horas de extensión.
     */
    public int getHorasExtension() {
        return this.horasExtension;
    }

    /**
     * Muestra la información del cargo exclusivo, incluyendo
     * las horas de investigación y de extensión.
     */
    public void mostrarCargo() {
        super.mostrarCargo();
        System.out.println("---Cargo de caracter exclusivo---");
        System.out.println("horas de investigacion: " + this.getHorasInvestigacion());
        System.out.println("horas extension: " + this.getHorasExtension());
    }
}

