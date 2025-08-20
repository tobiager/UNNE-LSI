/**
 * Ejercicio 6 del Tp3, clase Docente.
 * 
 * @author Olivarez Alexis E.
 */
public class Docente {
  private String nombre;
  private String grado;
  private double sueldoBasico;
  private double asignacionFamiliar;

  /**
   * Constructor de la clase Docente.
   * 
   * @param pNombre             Nombre del docente.
   * @param pGrado              Grado donde el docente da clases.
   * @param pSueldoBasico       Sueldo basico del docente.
   * @param pAsignacionFamiliar Asignacion Familiar?
   */
  Docente(String pNombre, String pGrado, double pSueldoBasico, double pAsignacionFamiliar) {
    this.setNombre(pNombre);
    this.setGrado(pGrado);
    this.setSueldoBasico(pSueldoBasico);
    this.setAsignacionFamiliar(pAsignacionFamiliar);
  }

  /**
   * El método establece el valor de la variable "nombre" proporcionado del valor
   * "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la variable
   *                "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "grado" proporcionado del valor
   * "pGrado".
   *
   * @param pGrado Es un String que representa el nuevo valor para la variable
   *               "grado".
   *               Debe ser un String no nulo y no vacío.
   */
  private void setGrado(String pGrado) {
    this.grado = pGrado;
  }

  /**
   * El método establece el valor de la variable "sueldoBasico" proporcionado del
   * valor "pSueldoBasico".
   *
   * @param pSueldoBasico Es un valor double que representa el sueldo basico del
   *                      docente.
   */
  private void setSueldoBasico(double pSueldoBasico) {
    this.sueldoBasico = pSueldoBasico;
  }

  /**
   * El método establece el valor de la variable "asignacionFamiliar"
   * proporcionado del valor "pAsignacionFamiliar".
   *
   * @param pAsignacionFamiliar Es un valor double que representa el sueldo basico
   *                            del docente.
   */
  private void setAsignacionFamiliar(double pAsignacionFamiliar) {
    this.asignacionFamiliar = pAsignacionFamiliar;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "grado".
   */
  public String getGrado() {
    return this.grado;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "sueldoBasico".
   */
  public double getSueldoBasico() {
    return this.sueldoBasico;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "asignacionFamiliar".
   */
  public double getAsignacionFamiliar() {
    return this.asignacionFamiliar;
  }

  /**
   * El método "calcularSueldo" calcula el salario total sumando el salario basico
   * y el subsidio familiar.
   *
   * @return Devuelve la suma del sueldoBasico y la asignacionFamiliar.
   */
  public double calcularSueldo() {
    return this.getSueldoBasico() + this.getAsignacionFamiliar();
  }
}
