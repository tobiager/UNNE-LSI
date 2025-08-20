import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * Ejercicio 1, clase Persona.
 * 
 * @author Olivarez Alexis E.
 */
class Persona {
  private int nroDni;
  private String nombre;
  private String apellido;
  private int anioNacimiento;

  /**
   * Constructor de la clase Persona.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pDni            El DNI de la persona.
   * @param pNombre         El nombre de la persona.
   * @param pApellido       El apellido de la persona.
   * @param pAnioNacimiento El año de nacimiento de la persona.
   */
  Persona(int pDni, String pNombre, String pApellido, int pAnioNacimiento) {
    this.setDni(pDni);
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setAnioNacimiento(pAnioNacimiento);
  }

  /**
   * El método establece el valor de la variable "nroDni" proporcionado del valor
   * "pDni".
   * 
   * @param pDni Es un valor entero que representa el DNI
   *             (Documento Nacional de Número de identidad).
   */
  private void setDni(int pDni) {
    this.nroDni = pDni;
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
   * El método establece el valor de la variable "apellido" proporcionado del
   * valor "pApellido".
   *
   * @param pApellido Es un String que representa el nuevo valor para la variable
   *                  "apellido".
   *                  Debe ser un String no nulo y no vacío.
   */
  private void setApellido(String pApellido) {
    this.apellido = pApellido;
  }

  /**
   * El método establece el valor de la variable "anioNacimiento" proporcionado
   * del valor "pAnioNacimiento".
   *
   * @param pAnioNacimiento Es un número entero que
   *                        representa el año de nacimiento.
   */
  private void setAnioNacimiento(int pAnioNacimiento) {
    this.anioNacimiento = pAnioNacimiento;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nroDni".
   */
  public int getDni() {
    return this.nroDni;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "apellido".
   */
  public String getApellido() {
    return this.apellido;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "anioNacimiento".
   */
  public int getAnioNacimiento() {
    return this.anioNacimiento;
  }

  /**
   * El método "edad" Calcula la diferencia entre año actual y año de nacimiento
   * de una persona.
   *
   * @return Devuelve la edad actual de la persona.
   */
  public int edad() {
    Calendar fechaHoy = new GregorianCalendar();
    int anioHoy = fechaHoy.get(Calendar.YEAR);
    return anioHoy - this.getAnioNacimiento();
  }

  /**
   * El método "nomYApe" Concatena el "nombre" y el "apellido".
   *
   * @return Devuelve una cadena de texto de las variables
   *         "nombre" y "apellido" con un espacio entremedio.
   */
  public String nomYApe() {
    return this.getNombre() + " " + this.getApellido();
  }

  /**
   * El método "apeYNom" Concatena el "apellido" y el "nombre".
   *
   * @return Devuelve una cadena de texto de las variables
   *         "apellido" y "nombre" con un espacio entremedio.
   */
  public String apeYNom() {
    return this.getApellido() + " " + this.getNombre();
  }

  /**
   * El método "mostrar" Muestra información de la persona, nombre y apellido, DNI
   * y la edad.
   */
  public void mostrar() {
    System.out.println("Nombre y Apellido: " + this.nomYApe());
    System.out.println("DNI: " + this.getDni() + " " + "Edad: " + this.edad());
  }
}
