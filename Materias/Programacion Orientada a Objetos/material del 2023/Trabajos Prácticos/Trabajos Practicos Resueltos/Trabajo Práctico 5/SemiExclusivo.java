public class SemiExclusivo extends Cargo {
  private int horasDeInvestigacion;

  /**
   * Constructor para crear un cargo SemiExclusivo.
   *
   * @param p_nombre               Nombre del cargo (String).
   * @param p_sueldoBasico         Sueldo básico del cargo (double).
   * @param p_anioIngreso          Año de ingreso del profesor en el cargo (int).
   * @param p_horasDeDocencia      Cantidad de horas de docencia asignadas al
   *                               cargo (int).
   * @param p_horasDeInvestigacion Cantidad de horas de investigación asignadas al
   *                               cargo SemiExclusivo (int).
   */
  public SemiExclusivo(String p_nombre, double p_sueldoBasico, int p_anioIngreso, int p_horasDeDocencia,
      int p_horasDeInvestigacion) {
    super(p_nombre, p_sueldoBasico, p_anioIngreso, p_horasDeDocencia);
    this.setHorasDeInvestigacion(p_horasDeInvestigacion);
  }

  /**
   * Establece la cantidad de horas de investigación asignadas al cargo
   * SemiExclusivo.
   *
   * @param p_horasDeInvestigacion Cantidad de horas de investigación a asignar.
   */
  private void setHorasDeInvestigacion(int p_horasDeInvestigacion) {
    this.horasDeInvestigacion = p_horasDeInvestigacion;
  }

  /**
   * Obtiene la cantidad de horas de investigación asignadas al cargo
   * SemiExclusivo.
   *
   * @return Cantidad de horas de investigación asignadas al cargo SemiExclusivo
   *         (int).
   */
  public int getHorasDeInvestigacion() {
    return this.horasDeInvestigacion;
  }

  /**
   * Muestra los detalles del cargo SemiExclusivo, incluyendo su nombre, sueldo
   * básico, sueldo del cargo, antigüedad, horas de docencia y horas de
   * investigación.
   */
  @Override
  public void mostrarCargo() {
    super.mostrarCargo();
    System.out.println("---- Cargo de caracter SemiExclusivo ----");
    System.out.format("Horas Investigación: %s\n", this.getHorasDeInvestigacion());
  }
}