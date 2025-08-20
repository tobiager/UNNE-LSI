
/**
 * La clase Docente representa a un docente con nombre, grado, sueldo básico y asignación familiar.
 * Proporciona métodos para calcular el sueldo total y obtener información sobre el docente.
 */
public class Docente {
    private String nombre;
    private String grado;
    private double sueldoBasico;
    private double asignacionFamiliar;

    /**
     * Constructor que inicializa un docente con nombre, grado, sueldo básico y asignación familiar.
     *
     * @param nombre El nombre del docente.
     * @param grado El grado del docente.
     * @param sueldoBasico El sueldo básico del docente.
     * @param asignacionFamiliar La asignación familiar del docente.
     */
    public Docente(String p_nombre, String p_grado, double p_sueldoBasico, double p_asignacionFamiliar) {
        this.setNombre(p_nombre);
        this.setGrado(p_grado);
        this.setSueldoBasico(p_sueldoBasico);
        this.setAsignacionFamiliar(p_asignacionFamiliar);
    }

    /**
     * Método accesor para obtener el nombre del docente.
     *
     * @return El nombre del docente.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Método accesor para establecer el nombre del docente.
     *
     * @param nombre El nuevo nombre del docente.
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Método accesor para obtener el grado del docente.
     *
     * @return El grado del docente.
     */
    public String getGrado() {
        return this.grado;
    }

    /**
     * Método accesor para establecer el grado del docente.
     *
     * @param grado El nuevo grado del docente.
     */
    public void setGrado(String grado) {
        this.grado = grado;
    }

    /**
     * Método accesor para obtener el sueldo básico del docente.
     *
     * @return El sueldo básico del docente.
     */
    public double getSueldoBasico() {
        return this.sueldoBasico;
    }

    /**
     * Método accesor para establecer el sueldo básico del docente.
     *
     * @param sueldoBasico El nuevo sueldo básico del docente.
     */
    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    /**
     * Método accesor para obtener la asignación familiar del docente.
     *
     * @return La asignación familiar del docente.
     */
    public double getAsignacionFamiliar() {
        return this.asignacionFamiliar;
    }

    /**
     * Método accesor para establecer la asignación familiar del docente.
     *
     * @param asignacionFamiliar La nueva asignación familiar del docente.
     */
    public void setAsignacionFamiliar(double p_asignacionFamiliar) {
        this.asignacionFamiliar = p_asignacionFamiliar;
    }

    /**
     * Calcula el sueldo total del docente sumando el sueldo básico y la asignación familiar.
     *
     * @return El sueldo total del docente.
     */
    public double calcularSueldo() {
        return this.getSueldoBasico() + this.getAsignacionFamiliar();
    }
}


