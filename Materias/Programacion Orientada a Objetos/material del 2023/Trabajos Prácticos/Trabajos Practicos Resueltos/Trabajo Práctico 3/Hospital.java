/**
 * Ejercicio 8, clase Hospital.
 * 
 * @author Olivarez Alexis E.
 */
public class Hospital {
  private String nombreHospital;
  private String nombreDirector;

  /**
   * Constructor de la clase Hospital.
   * 
   * @param pNroCuenta El nombre completo del hospital.
   * @param pTitular   El nombre completo del director del hospital
   */
  Hospital(String pNombreHospital, String pNombreDirector) {
    this.setNombreHospital(pNombreHospital);
    this.setNombreDirector(pNombreDirector);
  }

  /**
   * El método establece el valor de la variable "nombreDirector" proporcionado
   * del valor "pNombreDirector".
   *
   * @param pNombreDirector Es un String que representa el nuevo valor para la
   *                        variable "nombreDirector".
   *                        Debe ser un String no nulo y no vacío.
   */
  private void setNombreDirector(String pNombreDirector) {
    this.nombreDirector = pNombreDirector;
  }

  /**
   * El método establece el valor de la variable "nombreHospital" proporcionado
   * del valor "pNombreHospital".
   *
   * @param pNombreHospital Es un String que representa el nuevo valor para la
   *                        variable "nombreHospital".
   *                        Debe ser un String no nulo y no vacío.
   */
  private void setNombreHospital(String pNombreHospital) {
    this.nombreHospital = pNombreHospital;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombreDirector".
   */
  public String getNombreDirector() {
    return this.nombreDirector;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombreHospital".
   */
  public String getNombreHospital() {
    return this.nombreHospital;
  }

  /**
   * Muestra en pantalla los datos filiatorios de un paciente junto con
   * información del hospital.
   *
   * @param pPaciente El objeto Paciente cuyos datos filiatorios se desean
   *                  consultar.
   */
  public void consultaDatosFiliatorios(Paciente pPaciente) {
    System.out
        .println(String.format("Hospital: %s\t Director: %s", this.getNombreHospital(), this.getNombreDirector()));
    System.out.println("------------------------------------------------------------------------------------------");
    pPaciente.mostrarDatosPantalla();
  }
}