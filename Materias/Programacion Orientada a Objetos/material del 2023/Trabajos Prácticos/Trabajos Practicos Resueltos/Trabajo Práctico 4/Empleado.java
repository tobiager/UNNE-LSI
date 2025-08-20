import java.util.Calendar;
import java.util.GregorianCalendar;

public class Empleado {
  private long cuil;
  private String apellido;
  private String nombre;
  private double sueldoBasico;
  private Calendar fechaIngreso;

  /**
   * Constructor de la clase Empleado.
   * 
   * @param pCuil         El número de cuil del empleado.
   * @param pApellido     El apellido del empleado.
   * @param pNombre       El nombre del empleado.
   * @param pSueldoBasico El sueldo basico del empleado.
   * @param pAnioIngreso  El año que ingreso el empleado.
   */
  public Empleado(long pCuil, String pApellido, String pNombre, double pSueldoBasico, int pAnioIngreso) {
    this.setCuil(pCuil);
    this.setApellido(pApellido);
    this.setNombre(pNombre);
    this.setSueldoBasico(pSueldoBasico);
    this.setAnioIngreso(pAnioIngreso);
  }

  /**
   * Constructor de la clase Empleado.
   * 
   * @param pCuil         El número de cuil del empleado.
   * @param pApellido     El apellido del empleado.
   * @param pNombre       El nombre del empleado.
   * @param pSueldoBasico El sueldo basico del empleado.
   * @param pFechaIngreso La fecha que ingreso el empleado.
   */
  public Empleado(long pCuil, String pApellido, String pNombre, double pSueldoBasico, Calendar pFechaIngreso) {
    this.setCuil(pCuil);
    this.setApellido(pApellido);
    this.setNombre(pNombre);
    this.setSueldoBasico(pSueldoBasico);
    this.setFechaIngreso(pFechaIngreso);
  }

  /**
   * El método establece el valor de la variable "cuil" proporcionado del valor
   * "pCuil".
   * 
   * @param pCuil Es un valor entero que representa el cuil del empleado.
   */
  private void setCuil(long pCuil) {
    this.cuil = pCuil;
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
   * El método establece el valor de la variable "nombre" proporcionado del
   * valor "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la variable
   *                "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "sueldoBasico" proporcionado del
   * valor "pSueldoBasico".
   *
   * @param pSueldoBasico Es un número doble que representa el nuevo valor para la
   *                      variable "sueldoBasico".
   */
  private void setSueldoBasico(double pSueldoBasico) {
    this.sueldoBasico = pSueldoBasico;
  }

  /**
   * El método establece el valor de la variable "fechaIngreso" proporcionado
   * del valor "pFechaIngreso".
   *
   * @param pFechaIngreso fecha de cuando ingreso el empleado a la empresa.
   */
  private void setFechaIngreso(Calendar pFechaIngreso) {
    this.fechaIngreso = pFechaIngreso;
  }

  /**
   * El método establece el valor de la variable "anioIngreso" proporcionado
   * del valor "pAnioIngreso".
   *
   * @param pAnioIngreso Es un número entero que representa el año de que ingreso
   *                     el empleado a la empresa.
   */
  private void setAnioIngreso(int pAnioIngreso) {
    this.setFechaIngreso(new GregorianCalendar(pAnioIngreso, Calendar.JANUARY, 1));
  }

  /**
   * @return Devuelve el valor de la variable de instancia "cuil".
   */
  public long getCuil() {
    return this.cuil;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "apellido".
   */
  public String getApellido() {
    return this.apellido;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "sueldoBasico".
   */
  public double getSueldoBasico() {
    return this.sueldoBasico;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "fechaIngreso".
   */
  public Calendar getFechaIngreso() {
    return this.fechaIngreso;
  }

  /**
   * @return Devuelve el año de ingreso del empleado.
   */
  public int getAnioIngreso() {
    return this.getFechaIngreso().get(Calendar.YEAR);
  }

  /**
   * El método "antiguedad" Calcula la diferencia entre año actual y año de que
   * ingreso el empleado.
   *
   * @return Devuelve la cantidad de años de servicio.
   */
  public int antiguedad() {
    Calendar fechaHoy = Calendar.getInstance();
    int anioHoy = fechaHoy.get(Calendar.YEAR);
    Calendar fechaIngreso = this.getFechaIngreso();
    int anio = fechaIngreso.get(Calendar.YEAR);
    return anioHoy - anio;
  }

  /**
   * El método "descuento" Calcula el monto total del descuento sumando la
   * contribución al seguro médico y el importe fijo para el seguro de vida.
   *
   * @return Devuelve la suma de las variables locales "obraSocial" y
   *         "seguroVida".
   */
  private double descuento() {
    double obraSocial = this.getSueldoBasico() * 0.02;
    double seguroVida = 1500;
    return obraSocial + seguroVida;
  }

  /**
   * El método "sueldoNeto" Calcula el sueldo neto del empleado sumando el salario
   * básico, el monto adicional, y restando el monto del descuento.
   *
   * @return Devuelve el salario neto.
   */
  public double sueldoNeto() {
    return this.getSueldoBasico() + this.adicional() - this.descuento();
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
   * El método "adicional" Calcula el monto adicional en función de los años de
   * servicio del empleado.
   *
   * @return Devuelve la cantidad adicional basada en los años de antigüedad del
   *         empleado y su salario básico (sueldoBasico).
   */
  private double adicional() {
    if (this.antiguedad() < 2) {
      return this.getSueldoBasico() * 0.02;
    } else if (this.antiguedad() < 10) {
      return this.getSueldoBasico() * 0.04;
    }
    return this.getSueldoBasico() * 0.06;
  }

  /**
   * El método "mostrar" Muestra el nombre y apellido, CUIL, años de servicio y
   * salario neto del empleado.
   */
  public void mostrar() {
    System.out.println("Nombre y Apellido: " + this.nomYApe());
    System.out
        .println("CUIL: " + this.getCuil() + "\t" + "Antiguedad: " + this.antiguedad() + " a\u00F1o de servicio.");
    System.out.println("Sueldo Neto: $" + this.sueldoNeto());
  }

  /**
   * El método "mostrarLinea" Concatena el CUIL, apellido, nombre y salario neto.
   *
   * @return Devuelve una cadena de caracteres que contiene el CUIL, apellido,
   *         nombre y sueldo neto.
   */
  public String mostrarLinea() {
    return this.getCuil() + "\t" + this.getApellido() + ", " + this.getNombre() + " $" + this.sueldoNeto();
  }

  /**
   * Comprueba si la fecha de ingreso en el objeto actual coincide con la fecha
   * actual, lo que indica que es el aniversario del empleado.
   *
   * @return Verdadero si la fecha de ingreso coincide con la fecha actual
   *         (aniversario), Falso en caso contrario.
   */
  public boolean esAniversario() {
    Calendar hoy = Calendar.getInstance();
    int diaHoy = hoy.get(Calendar.DAY_OF_MONTH);
    int mesHoy = hoy.get(Calendar.MONTH);

    int diaIngreso = this.fechaIngreso.get(Calendar.DAY_OF_MONTH);
    int mesIngreso = this.fechaIngreso.get(Calendar.MONTH);

    return diaHoy == diaIngreso && mesHoy == mesIngreso;
  }
}
