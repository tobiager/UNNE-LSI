public class Exclusivo extends Cargo {
  private int horasDeInvestigacion;
  private int horasDeExtension;

  /**
   * Constructor para crear un cargo Exclusivo.
   *
   * @param p_nombre               Nombre del cargo (String).
   * @param p_sueldoBasico         Sueldo básico del cargo (double).
   * @param p_anioIngreso          Año de ingreso del profesor en el cargo (int).
   * @param p_horasDeDocencia      Cantidad de horas de docencia asignadas al
   *                               cargo (int).
   * @param p_horasDeInvestigacion Cantidad de horas de investigación asignadas al
   *                               cargo Exclusivo (int).
   * @param p_horasDeExtension     Cantidad de horas de extensión asignadas al
   *                               cargo Exclusivo (int).
   */
  public Exclusivo(String p_nombre, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia,
      int p_horasDeInvestigacion, int p_horasDeExtension) {
    super(p_nombre, p_sueldoBasico, p_anioIngreso, p_horasDeDocencia);
    this.setHorasDeInvestigacion(p_horasDeInvestigacion);
    this.setHorasDeExtension(p_horasDeExtension);
  }

  /**
   * Establece la cantidad de horas de investigación asignadas al cargo Exclusivo.
   *
   * @param p_horasDeInvestigacion Cantidad de horas de investigación a asignar.
   */
  private void setHorasDeInvestigacion(int p_horasDeInvestigacion) {
    this.horasDeInvestigacion = p_horasDeInvestigacion;
  }

  /**
   * Establece la cantidad de horas de extensión asignadas al cargo Exclusivo.
   *
   * @param p_horasDeExtension Cantidad de horas de extensión a asignar.
   */
  private void setHorasDeExtension(int p_horasDeExtension) {
    this.horasDeExtension = p_horasDeExtension;
  }

  /**
   * Obtiene la cantidad de horas de investigación asignadas al cargo Exclusivo.
   *
   * @return Cantidad de horas de investigación asignadas al cargo Exclusivo
   *         (int).
   */
  public int getHorasDeInvestigacion() {
    return this.horasDeInvestigacion;
  }

  /**
   * Obtiene la cantidad de horas de extensión asignadas al cargo Exclusivo.
   *
   * @return Cantidad de horas de extensión asignadas al cargo Exclusivo (int).
   */
  public int getHorasDeExtension() {
    return this.horasDeExtension;
  }

  /**
   * Muestra los detalles del cargo Exclusivo, incluyendo su nombre, sueldo
   * básico, sueldo del cargo, antigüedad, horas de docencia, horas de
   * investigación y horas de extensión.
   */
  @Override
  public void mostrarCargo() {
    super.mostrarCargo();
    System.out.println("---- Cargo de caracter Exclusivo ----");
    System.out.format("Horas Investigación: %s\n", this.getHorasDeInvestigacion());
    System.out.format("Horas Extensión: %s\n", this.getHorasDeExtension());
  }
}
