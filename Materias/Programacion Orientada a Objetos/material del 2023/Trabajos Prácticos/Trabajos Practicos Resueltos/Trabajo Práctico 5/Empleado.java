import java.util.Calendar;

public class Empleado extends Persona {
  private long cuil;
  private double sueldoBasico;
  private Calendar fechaIngreso;

  /**
   * Constructor de la clase Empleado.
   * 
   * @param p_cuil           El número de cuil del empleado (long).
   * @param p_apellido       El apellido del empleado (int).
   * @param p_nombre         El nombre del empleado (String).
   * @param p_sueldoBasico   El sueldo basico del empleado (String).
   * @param p_anioNacimiento El ano de nacimiento del empleado (int).
   * @param p_sueldoBasico   El sueldo basico el empleado (double).
   * @param p_anioIngreso    El año de que ingreso el empleado a la empresa (int).
   */
  public Empleado(long p_cuil, int p_dni, String p_apellido, String p_nombre, int p_anioNacimiento,
      double p_sueldoBasico, int p_anioIngreso) {
    super(p_dni, p_nombre, p_apellido, p_anioNacimiento);
    this.setCuil(p_cuil);
    this.setSueldoBasico(p_sueldoBasico);
    this.setAnioIngreso(p_anioIngreso);
  }

  /**
   * Constructor de la clase Empleado.
   * 
   * @param p_cuil           El número de cuil del empleado (long).
   * @param p_apellido       El apellido del empleado (int).
   * @param p_nombre         El nombre del empleado (String).
   * @param p_sueldoBasico   El sueldo basico del empleado (String).
   * @param p_anioNacimiento El ano de nacimiento del empleado (int).
   * @param p_sueldoBasico   El sueldo basico el empleado (double).
   * @param p_fechaIngreso   La fecha que ingreso el empleado a la empresa
   *                         (Calendar).
   */
  public Empleado(long p_cuil, int p_dni, String p_apellido, String p_nombre, int p_anioNacimiento,
      double p_sueldoBasico, Calendar p_fechaIngreso) {
    super(p_dni, p_nombre, p_apellido, p_anioNacimiento);
    this.setCuil(p_cuil);
    this.setSueldoBasico(p_sueldoBasico);
    this.setFechaIngreso(p_fechaIngreso);
  }

  /**
   * Establece el valor de la variable "cuil" proporcionado del valor
   * "p_cuil".
   * 
   * @param p_cuil Es un valor entero que representa el cuil del empleado.
   */
  private void setCuil(long p_cuil) {
    this.cuil = p_cuil;
  }

  /**
   * Establece el valor de la variable "sueldoBasico" proporcionado del
   * valor "p_sueldoBasico".
   *
   * @param p_sueldoBasico Es un número doble que representa el nuevo valor para
   *                       la
   *                       variable "sueldoBasico".
   */
  private void setSueldoBasico(double p_sueldoBasico) {
    this.sueldoBasico = p_sueldoBasico;
  }

  /**
   * Establece el valor de la variable "fechaIngreso" proporcionado
   * del valor "p_fechaIngreso".
   *
   * @param p_fechaIngreso fecha de cuando ingreso el empleado a la empresa.
   */
  private void setFechaIngreso(Calendar p_fechaIngreso) {
    this.fechaIngreso = p_fechaIngreso;
  }

  /**
   * Establece el valor de la variable "anioIngreso" proporcionado
   * del valor "p_anioIngreso".
   *
   * @param p_anioIngreso Es un número entero que representa el año de que ingreso
   *                      el empleado a la empresa.
   */
  private void setAnioIngreso(int p_anioIngreso) {
    this.setFechaIngreso(Calendar.getInstance());
    this.getFechaIngreso().set(Calendar.DAY_OF_MONTH, 1);
    this.getFechaIngreso().set(Calendar.MONTH, 0);
    this.getFechaIngreso().set(Calendar.YEAR, p_anioIngreso);
  }

  /**
   * @return Devuelve el valor de la variable de instancia "cuil".
   */
  public long getCuil() {
    return this.cuil;
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
   * Calcula la diferencia entre año actual y año de que
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
   * Calcula el monto total del descuento sumando la
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
   * Calcula el sueldo neto del empleado sumando el salario
   * básico, el monto adicional, y restando el monto del descuento.
   *
   * @return Devuelve el salario neto.
   */
  public double sueldoNeto() {
    return this.getSueldoBasico() + this.adicional() - this.descuento();
  }

  /**
   * Calcula el monto adicional en función de los años de
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
   * Muestra el nombre y apellido, CUIL, años de servicio y
   * salario neto del empleado.
   */
  @Override
  public void mostrar() {
    super.mostrar();
    System.out
        .println("CUIL: " + this.getCuil() + "\t" + "Antiguedad: " + this.antiguedad() + " a\u00F1o de servicio.");
    System.out.println("Sueldo Neto: $" + this.sueldoNeto());
  }

  /**
   * Concatena el CUIL, apellido, nombre y salario neto.
   *
   * @return Devuelve una cadena de caracteres que contiene el CUIL, apellido,
   *         nombre y sueldo neto.
   */
  public String mostrarLinea() {
    return this.getCuil() + "\t" + super.getApellido() + ", " + super.getNombre() + " $" + this.sueldoNeto();
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
    int diaIngreso = this.getFechaIngreso().get(Calendar.DAY_OF_MONTH);
    int mesIngreso = this.getFechaIngreso().get(Calendar.MONTH);
    return diaHoy == diaIngreso && mesHoy == mesIngreso;
  }
}