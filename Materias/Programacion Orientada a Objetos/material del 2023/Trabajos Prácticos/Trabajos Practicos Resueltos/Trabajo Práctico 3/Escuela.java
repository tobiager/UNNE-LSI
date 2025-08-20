/**
 * Ejercicio 6 del Tp3, clase Escuela.
 * 
 * @author Olivarez Alexis E.
 */
public class Escuela {
  private String nombre;
  private String domicilio;
  private String director;

  /**
   * Constructor de la clase Escuela.
   * 
   * @param pNombre       Nombre de la institución.
   * @param pGrado        Domicilio de la institución.
   * @param pSueldoBasico Nombre completo del director.
   */
  Escuela(String pNombre, String pDomicilio, String pDirector) {
    this.setNombre(pNombre);
    this.setDomicilio(pDomicilio);
    this.setDirector(pDirector);
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
   * El método establece el valor de la variable "domicilio" proporcionado del
   * valor
   * "pDomicilio".
   *
   * @param pDomicilio Es un String que representa el nuevo valor para la variable
   *                   "domicilio".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setDomicilio(String pDomicilio) {
    this.domicilio = pDomicilio;
  }

  /**
   * El método establece el valor de la variable "director" proporcionado del
   * valor
   * "pDirector".
   *
   * @param pDirector Es un String que representa el nuevo valor para la variable
   *                  "director".
   *                  Debe ser un String no nulo y no vacío.
   */
  private void setDirector(String pDirector) {
    this.director = pDirector;
  }

  /**
   * @return Devuelve el valor del atributo "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor del atributo "domicilio".
   */
  public String getDomicilio() {
    return this.domicilio;
  }

  /**
   * @return Devuelve el valor del atributo "director".
   */
  public String getDirector() {
    return this.director;
  }

  /**
   * El método "imprimirRecibo" imprime un recibo de un docente, incluyendo su
   * nombre, salario, salario basico y asignación familiar.
   *
   * @param pDocente El parámetro pDocente es un objeto de tipo Docente, que
   *                 representa a un profesor.
   */
  public void imprimirRecibo(Docente pDocente) {
    System.out.println(
        "Escuela: " + this.getNombre() + "\tDomicilio: " + this.getDomicilio() + "\tDirector: " + this.getDirector());
    System.out.println("---------------------------------------------------------------------------------------");
    System.out.println("Docente: " + pDocente.getNombre());
    System.out.println("Sueldo.........................$ " + pDocente.calcularSueldo());
    System.out.println("Sueldo Basico..................$ " + pDocente.getSueldoBasico());
    System.out.println("Asignacion Familiar............$ " + pDocente.getAsignacionFamiliar());
  }
}
