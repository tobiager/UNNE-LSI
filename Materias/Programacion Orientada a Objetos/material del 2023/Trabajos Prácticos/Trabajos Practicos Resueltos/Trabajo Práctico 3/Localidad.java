/**
 * Ejercicio 8, clase Localidad.
 * 
 * @author Olivarez Alexis E.
 */
public class Localidad {
  private String nombre;
  private String provincia;

  /**
   * Constructor de la clase Localidad.
   * 
   * @param pNombre   El nombre de la Localidad.
   * @param pProvincia El nombre de la Provincia.
   */
  Localidad(String pNombre, String pProvincia) {
    this.setNombre(pNombre);
    this.setProvincia(pProvincia);
  }

  /**
   * El método establece el valor de la variable "nombre" proporcionado del
   * valor "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la
   *                variable "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "provincia" proporcionado del
   * valor "pProvincia".
   *
   * @param pProvincia Es un String que representa el nuevo valor para la
   *                   variable "provincia".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setProvincia(String pProvincia) {
    this.provincia = pProvincia;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "provincia".
   */
  public String getProvincia() {
    return this.provincia;
  }

  /**
   * @return Cadena de texto concatenando Localidad y Provincia.
   */
  public String mostrar() {
    // return "Localidad: " + this.getNombre() + "\tProvincia: " +
    // this.getProvincia();
    return String.format("Localidad: %s\tProvincia: %s", this.getNombre(), this.getProvincia());
  }
}