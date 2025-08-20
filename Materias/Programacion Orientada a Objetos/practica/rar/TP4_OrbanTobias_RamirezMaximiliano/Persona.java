import java.util.Calendar;
import java.util.GregorianCalendar;

public class Persona {
  private int nroDni;
  private String nombre;
  private String apellido;
  private Calendar fechaNacimiento;

  /**
   * Constructor de la clase Persona.
   * 
   * @param pDni            El DNI de la persona.
   * @param pNombre         El nombre de la persona.
   * @param pApellido       El apellido de la persona.
   * @param pAnioNacimiento El año de nacimiento de la persona.
   */
  public Persona(int pDni, String pNombre, String pApellido, int pAnioNacimiento) {
    this.setDni(pDni);
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setFechaNacimiento(new GregorianCalendar(pAnioNacimiento, 0, 1));
  }

  /**
   * Constructor de la clase Persona.
   * 
   * @param pDni             El DNI de la persona.
   * @param pNombre          El nombre de la persona.
   * @param pApellido        El apellido de la persona.
   * @param pFechaNacimiento La fecha de nacimiento de la persona.
   */
  public Persona(int pDni, String pNombre, String pApellido, Calendar pFechaNacimiento) {
    this.setDni(pDni);
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setFechaNacimiento(pFechaNacimiento);
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
   * El método establece el valor de la variable "fechaNacimiento" proporcionado
   * del valor "pFechaNacimiento".
   *
   * @param pFechaNacimiento Es un tipo Calendar que
   *                         representa la fecha de nacimiento.
   */
  private void setFechaNacimiento(Calendar pFechaNacimiento) {
    this.fechaNacimiento = pFechaNacimiento;
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
   * El método "edad" Calcula la diferencia entre año actual y año de nacimiento
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
   * El método "nomYApe" Concatena el "nombre" y el "apellido".
   *
   * @return Devuelve una cadena de caracteres de las variables
   *         "nombre" y "apellido" con un espacio entremedio.
   */
  public String nomYApe() {
    return this.getNombre() + " " + this.getApellido();
  }

  /**
   * El método "apeYNom" Concatena el "apellido" y el "nombre".
   *
   * @return Devuelve una cadena de caracteres de las variables
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

  /**
   * El método "esCumpleanios" comprueba si la fecha actual es la misma que la
   * fecha de nacimiento.
   *
   * @return El método devuelve un valor booleano.
   */
  public boolean esCumpleanios() {
    Calendar fechaActual = Calendar.getInstance();
    return this.getFechaNacimiento().get(Calendar.DAY_OF_MONTH) == fechaActual.get(Calendar.DAY_OF_MONTH)
        && this.getFechaNacimiento().get(Calendar.MONTH) == fechaActual.get(Calendar.MONTH);
  }
}