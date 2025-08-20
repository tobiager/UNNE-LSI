
/**
 * Representa un hospital en el sistema de gestión hospitalaria.
 */
public class Hospital {
    private String nombreHospital;
    private String nombreDirector;

    /**
     * Crea un nuevo hospital con los datos especificados.
     * 
     * @param p_nombreHospital el nombre del hospital
     * @param p_nombreDirector el nombre del director del hospital
     */
    public Hospital(String p_nombreHospital, String p_nombreDirector) {
        this.setNombreHospital(p_nombreHospital);
        this.setNombreDirector(p_nombreDirector);
    }

    /**
     * Muestra la información del hospital y los datos filiatorios del paciente.
     * 
     * @param p_paciente el paciente cuya información se desea mostrar
     */
    public void consultaDatosFiliatorios(Paciente p_paciente) {
        System.out.println("Hospital: " + this.getNombreHospital() + " Director: " + this.getNombreDirector());
        System.out.println("-----------------------------------------------------------------------------------------------------------------------------");
        p_paciente.mostrarDatosPantalla();
    }

    // Getters y Setters

    public String getNombreHospital() {
        return this.nombreHospital;
    }

    private void setNombreHospital(String nombreHospital) {
        this.nombreHospital = nombreHospital;
    }

    public String getNombreDirector() {
        return this.nombreDirector;
    }

    private void setNombreDirector(String nombreDirector) {
        this.nombreDirector = nombreDirector;
    }
}


