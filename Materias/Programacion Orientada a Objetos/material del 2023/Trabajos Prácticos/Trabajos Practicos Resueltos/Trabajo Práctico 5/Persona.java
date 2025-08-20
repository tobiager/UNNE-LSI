import java.util.Calendar;

public class Persona {
  private int nroDni;
  private String nombre;
  private String apellido;
  private Calendar fechaNacimiento;

  /**
   * Constructor de la clase Persona.
   * 
   * @param p_dni            El DNI de la persona.
   * @param p_nombre         El nombre de la persona.
   * @param p_apellido       El apellido de la persona.
   * @param p_anioNacimiento El año de nacimiento de la persona.
   */
  public Persona(int p_dni, String p_nombre, String p_apellido, int p_anioNacimiento) {
    this.setDni(p_dni);
    this.setNombre(p_nombre);
    this.setApellido(p_apellido);
    this.setFechaNacimiento(Calendar.getInstance());
    this.getFechaNacimiento().set(Calendar.DAY_OF_MONTH, 1);
    this.getFechaNacimiento().set(Calendar.MONTH, 0);
    this.getFechaNacimiento().set(Calendar.YEAR, p_anioNacimiento);
  }

  /**
   * Constructor de la clase Persona.
   * 
   * @param p_dni             El DNI de la persona.
   * @param p_nombre          El nombre de la persona.
   * @param p_apellido        El apellido de la persona.
   * @param p_fechaNacimiento La fecha de nacimiento de la persona.
   */
  public Persona(int p_dni, String p_nombre, String p_apellido, Calendar p_fechaNacimiento) {
    this.setDni(p_dni);
    this.setNombre(p_nombre);
    this.setApellido(p_apellido);
    this.setFechaNacimiento(p_fechaNacimiento);
  }

  /**
   * Establece el valor de la variable "nroDni" proporcionado del valor
   * "p_dni".
   * 
   * @param p_dni Es un valor entero que representa el DNI
   *              (Documento Nacional de Número de identidad).
   */
  private void setDni(int p_dni) {
    this.nroDni = p_dni;
  }

  /**
   * Establece el valor de la variable "nombre" proporcionado del valor
   * "p_nombre".
   *
   * @param p_nombre Es un String que representa el nuevo valor para la variable
   *                 "nombre".
   *                 Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Establece el valor de la variable "apellido" proporcionado del
   * valor "p_apellido".
   *
   * @param p_apellido Es un String que representa el nuevo valor para la variable
   *                   "apellido".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setApellido(String p_apellido) {
    this.apellido = p_apellido;
  }

  /**
   * Establece el valor de la variable "fechaNacimiento" proporcionado
   * del valor "p_fechaNacimiento".
   *
   * @param p_fechaNacimiento Es un tipo Calendar que
   *                          representa la fecha de nacimiento.
   */
  private void setFechaNacimiento(Calendar p_fechaNacimiento) {
    this.fechaNacimiento = p_fechaNacimiento;
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
   * @return Devuelve el valor de la variable de instancia "fechaNacimiento" que
   *         es de tipo Calendar.
   */
  public Calendar getFechaNacimiento() {
    return this.fechaNacimiento;
  }

  /**
   * Calcula la diferencia entre año actual y año de nacimiento
   * de una persona.
   *
   * @return Devuelve la edad actual de la persona.
   */
  public int edad() {
    Calendar fechaHoy = Calendar.getInstance();
    int anioHoy = fechaHoy.get(Calendar.YEAR);
    return anioHoy - this.getFechaNacimiento().get(Calendar.YEAR);
  }

  /**
   * Concatena el "nombre" y el "apellido".
   *
   * @return Devuelve una cadena de caracteres de las variables
   *         "nombre" y "apellido" con un espacio entremedio.
   */
  public String nomYApe() {
    return this.getNombre() + " " + this.getApellido();
  }

  /**
   * Concatena el "apellido" y el "nombre".
   *
   * @return Devuelve una cadena de caracteres de las variables
   *         "apellido" y "nombre" con un espacio entremedio.
   */
  public String apeYNom() {
    return this.getApellido() + " " + this.getNombre();
  }

  /**
   * Muestra información de la persona, nombre y apellido, DNI y la edad.
   */
  public void mostrar() {
    System.out.println("Nombre y Apellido: " + this.nomYApe());
    System.out.println("DNI: " + this.getDni() + " " + "Edad: " + this.edad() + " años");
  }

  /**
   * Comprueba si la fecha actual es la misma que la fecha de nacimiento.
   *
   * @return Devuelve un valor booleano.
   */
  public boolean esCumpleanios() {
    Calendar fechaActual = Calendar.getInstance();
    return this.getFechaNacimiento().get(Calendar.DAY_OF_MONTH) == fechaActual.get(Calendar.DAY_OF_MONTH)
        && this.getFechaNacimiento().get(Calendar.MONTH) == fechaActual.get(Calendar.MONTH);
  }
}