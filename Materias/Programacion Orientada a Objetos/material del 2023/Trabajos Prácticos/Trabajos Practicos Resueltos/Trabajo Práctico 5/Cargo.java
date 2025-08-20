import java.util.Calendar;

public class Cargo {
  private String nombreCargo;
  private double sueldoBasico;
  private int anioIngreso;
  private int horasDeDocencia;

  /**
   * Constructor para crear un nuevo objeto Cargo.
   *
   * @param p_nombre          El nombre del cargo (String).
   * @param p_sueldoBasico    El sueldo básico del cargo (double).
   * @param p_anioIngreso     El año de ingreso al cargo (int).
   * @param p_horasDeDocencia Las horas de docencia asignadas al cargo (int).
   */
  public Cargo(String p_nombre, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia) {
    this.setNombreCargo(p_nombre);
    this.setSueldoBasico(p_sueldoBasico);
    this.setAnioIngreso(p_anioIngreso);
    this.setHorasDeDocencia(p_horasDeDocencia);
  }

  /**
   * Establece el nombre del cargo del profesor.
   *
   * @param p_nombreCargo El nombre del cargo.
   */
  private void setNombreCargo(String p_nombreCargo) {
    this.nombreCargo = p_nombreCargo;
  }

  /**
   * Establece el sueldo básico del cargo del profesor.
   *
   * @param p_sueldoBasico El sueldo básico.
   */
  private void setSueldoBasico(double p_sueldoBasico) {
    this.sueldoBasico = p_sueldoBasico;
  }

  /**
   * Establece el año de ingreso al cargo del profesor.
   *
   * @param p_anioIngreso El año de ingreso al cargo.
   */
  private void setAnioIngreso(int p_anioIngreso) {
    this.anioIngreso = p_anioIngreso;
  }

  /**
   * Establece las horas de docencia asignadas al cargo del profesor.
   *
   * @param horasDeDocencia Las horas de docencia.
   */
  private void setHorasDeDocencia(int horasDeDocencia) {
    this.horasDeDocencia = horasDeDocencia;
  }

  /**
   * Obtiene el nombre del cargo.
   *
   * @return El nombre del cargo (String).
   */
  public String getNombreCargo() {
    return this.nombreCargo;
  }

  /**
   * Obtiene el sueldo básico del cargo.
   *
   * @return El sueldo básico del cargo (double).
   */
  public double getSueldoBasico() {
    return this.sueldoBasico;
  }

  /**
   * Obtiene el año de ingreso al cargo.
   *
   * @return El año de ingreso al cargo (int).
   */
  public int getAnioIngreso() {
    return this.anioIngreso;
  }

  /**
   * Obtiene las horas de docencia asignadas al cargo.
   *
   * @return Las horas de docencia asignadas al cargo (int).
   */
  public int getHorasDeDocencia() {
    return this.horasDeDocencia;
  }

  /**
   * Calcula y devuelve la antigüedad en años del profesor en el cargo.
   *
   * @return La antigüedad en años del profesor en el cargo (int).
   */
  public int antiguedad() {
    Calendar fechaActual = Calendar.getInstance();
    int añoActual = fechaActual.get(Calendar.YEAR);
    return añoActual - this.getAnioIngreso();
  }

  /**
   * Multiplica la antigüedad por el 1% y luego hace el producto por el sueldo
   * basico.
   *
   * @return El adicional por antigüedad en el sueldo básico (double).
   */
  private double adicionalXAntiguedad() {
    return this.getSueldoBasico() * this.antiguedad() * 0.01;
  }

  /**
   * Calcula y devuelve el sueldo total del cargo, que incluye el sueldo básico y
   * el adicional por antigüedad.
   *
   * @return El sueldo total del cargo (double).
   */
  public double sueldoDelCargo() {
    return this.getSueldoBasico() + this.adicionalXAntiguedad();
  }

  /**
   * Muestra los detalles del cargo, incluyendo el nombre del cargo, sueldo
   * básico, sueldo total (con adicional por antigüedad),
   * antigüedad y horas de docencia.
   */
  public void mostrarCargo() {
    System.out.format("%s - Sueldo Basico: %s - Sueldo Cargo: %s - Antiguedad: %s años\n", this.getNombreCargo(),
        this.getSueldoBasico(), this.sueldoDelCargo(), this.antiguedad());
    System.out.format("Horas Docencia: %s\n", this.getHorasDeDocencia());
  }
}
