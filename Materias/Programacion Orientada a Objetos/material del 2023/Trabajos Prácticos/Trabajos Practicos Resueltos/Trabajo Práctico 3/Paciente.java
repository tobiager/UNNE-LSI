/**
 * Ejercicio 8, clase Paciente.
 * 
 * @author Olivarez Alexis E.
 */
public class Paciente {
  private int historiaClinica;
  private String nombre;
  private String domicilio;
  private Localidad localidadVive;
  private Localidad localidadNacido;

  /**
   * Constructor de la clase Paciente.
   * 
   * @param pHistoriaClinica Número de historial clinico.
   * @param pNombre          El nombre completo del Paciente.
   * @param pDomicilio       Domicilio del Paciente.
   * @param pLocalidadVive   Objeto Localidad que tiene Localidad y Provincia
   *                         donde vivé.
   * @param pLocalidadNacido Objeto Localidad que tiene Localidad y Provincia
   *                         donde nació.
   */
  Paciente(int pHistoriaClinica, String pNombre, String pDomicilio, Localidad pLocalidadVive,
      Localidad pLocalidadNacido) {
    this.setHistoriaClinica(pHistoriaClinica);
    this.setNombre(pNombre);
    this.setDomicilio(pDomicilio);
    this.setVive(pLocalidadVive);
    this.setNacido(pLocalidadNacido);
  }

  /**
   * El método establece el valor del atributo "historiaClinica" proporcionado
   * del valor "pHistoriaClinica".
   *
   * @param pHistoriaClinica Es un entero que representa el nuevo valor para la
   *                         variable "historiaClinica".
   */
  private void setHistoriaClinica(int pHistoriaClinica) {
    this.historiaClinica = pHistoriaClinica;
  }

  /**
   * El método establece el valor del atributo "nombre" proporcionado
   * del valor "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la
   *                variable "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor del atributo "domicilio" proporcionado
   * del valor "pDomicilio".
   *
   * @param pDomicilio Es un String que representa el nuevo valor para la
   *                   variable "domicilio".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setDomicilio(String pDomicilio) {
    this.domicilio = pDomicilio;
  }

  /**
   * El método establece el valor del atributo "localidadVive" proporcionado
   * del valor "pLocalidadVive".
   *
   * @param pLocalidadVive Es un String que representa el nuevo valor para la
   *                       variable "localidadVive".
   */
  private void setVive(Localidad pLocalidadVive) {
    this.localidadVive = pLocalidadVive;
  }

  /**
   * El método establece el valor del atributo "localidadNacido" proporcionado
   * del valor "pLocalidadNacido".
   *
   * @param pLocalidadNacido Es un String que representa el nuevo valor para la
   *                         variable "localidadNacido".
   */
  private void setNacido(Localidad pLocalidadNacido) {
    this.localidadNacido = pLocalidadNacido;
  }

  /**
   * @return Devuelve el valor del atributo "historiaClinica".
   */
  public int getHistoriaClinica() {
    return this.historiaClinica;
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
   * @return Devuelve el valor del atributo "localidadVive" que es
   *         un objeto de tipo Localidad.
   */
  public Localidad getVive() {
    return this.localidadVive;
  }

  /**
   * @return Devuelve el valor del atributo "localidadNacido" que
   *         es un objeto de tipo Localidad.
   */
  public Localidad getNacido() {
    return this.localidadNacido;
  }

  /**
   * El método "mostrarDatosPantalla" imprime el nombre completo del paciente,
   * historia clinica, domicilio, localidad y provincia donde vive.
   */
  public void mostrarDatosPantalla() {
    // System.out.println("Paciente: " + this.getNombre() +
    // "\tHistoria Cl\u00EDnica: " + this.getHistoriaClinica() +
    // "\tDomicilio: " + this.getDomicilio());
    System.out.println(String.format("Paciente: %s\tHistoria Cl\u00EDnica: %s\tDomicilio: %s", this.getNombre(),
        this.getHistoriaClinica(), this.getDomicilio()));
    System.out.println(this.getVive().mostrar());
  }

  /**
   * @return Cadena de texto concatenando nombre, historia clinica, localidad y
   *         provincia donde vive.
   */
  public String cadenaDeDatos() {
    // return this.getNombre() + this.getHistoriaClinica() + this.getDomicilio() +
    // "-" + this.getVive().getNombre() + "- "
    // + this.getVive().getProvincia();
    return String.format("%s %s %s - %s - %s", this.getNombre(), this.getHistoriaClinica(), this.getDomicilio(),
        this.getVive().getNombre(), this.getVive().getProvincia());
  }
}
