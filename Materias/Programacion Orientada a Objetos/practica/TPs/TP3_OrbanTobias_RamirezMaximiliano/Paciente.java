/**
 * Representa a un paciente en el sistema de gestión hospitalaria.
 */
public class Paciente {
    private int historiaClinica;
    private String nombre;
    private String domicilio;
    private Localidad localidadNacido;
    private Localidad localidadVive;

    /**
     * Crea un nuevo paciente con los datos especificados.
     * 
     * @param p_historia el número de historia clínica del paciente
     * @param p_nombre el nombre del paciente
     * @param p_domicilio el domicilio del paciente
     * @param p_localidadNacido la localidad de nacimiento del paciente
     * @param p_localidadVive la localidad donde vive el paciente
     */
    public Paciente(int p_historia, String p_nombre, String p_domicilio, Localidad p_localidadNacido, Localidad p_localidadVive) {
        this.setHistoriaClinica(p_historia);
        this.setNombre( p_nombre);
        this.setDomicilio(p_domicilio);
        this.setLocalidadNacido(p_localidadNacido);
        this.setLocalidadVive(p_localidadVive);
    }

    /**
     * Establece la localidad de nacimiento del paciente.
     * 
     * @param p_nacido la localidad de nacimiento
     */
    private void setNacido(Localidad p_nacido) {
        this.localidadNacido = p_nacido;
    }

    /**
     * Establece la localidad donde vive el paciente.
     * 
     * @param p_vive la localidad donde vive
     */
    private void setVive(Localidad p_vive) {
        this.localidadVive = p_vive;
    }

    /**
     * Obtiene la localidad de nacimiento del paciente.
     * 
     * @return la localidad de nacimiento
     */
    public Localidad getNacido() {
        return this.localidadNacido;
    }

    /**
     * Obtiene la localidad donde vive el paciente.
     * 
     * @return la localidad donde vive
     */
    public Localidad getVive() {
        return this.localidadVive;
    }

    /**
     * Muestra los datos del paciente en pantalla.
     */
    public void mostrarDatosPantalla() {
        System.out.println("Paciente: " + this.getNombre() + " Historia Clínica: " 
        + this.getHistoriaClinica() + " Domicilio: " + this.getDomicilio());
        System.out.println(localidadVive.mostrar());
    }

    /**
     * Devuelve una cadena con los datos del paciente.
     * 
     * @return una cadena con el nombre, historia clínica, domicilio y localidad
     */
    public String cadenaDeDatos() {
        return this.getNombre() + " …… " + this.getHistoriaClinica() + " ..… " 
        + this.getDomicilio() + " - " + localidadVive.mostrar();
    }

    // Getters y Setters

    public int getHistoriaClinica() {
        return this.historiaClinica;
    }

    private void setHistoriaClinica(int historiaClinica) {
        this.historiaClinica = historiaClinica;
    }

    public String getNombre() {
        return nombre;
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDomicilio() {
        return this.domicilio;
    }

    private void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    private void setLocalidadNacido(Localidad localidadNacido) {
        this.localidadNacido = localidadNacido;
    }

    public Localidad getLocalidadNacido() {
        return this.localidadNacido;
    }

    private void setLocalidadVive(Localidad localidadVive) {
        this.localidadVive = localidadVive;
    }

    public Localidad getLocalidadVive() {
        return this.localidadVive;
    }
}


