
import java.util.ArrayList;

public class Cabaña extends Alojamiento {
  private int nroHabitaciones;

  /**
   * @param p_nombre          El nombre de la cabaña (String).
   * @param p_precioBase      El precio base de la cabaña (double).
   * @param p_diasAlquiler    Los dias de alquiler de la cabaña (int).
   * @param p_nroHabitaciones El número de habitaciones de la cabaña (int).
   */
  public Cabaña(String p_nombre, double p_precioBase, int p_diasAlquiler, int p_nroHabitaciones) {
    super(p_nombre, p_precioBase, p_diasAlquiler);
    this.setNroHabitaciones(p_nroHabitaciones);
  }

  /**
   * @param p_nombre          El nombre de la cabaña (String).
   * @param p_precioBase      El precio base de la cabaña (double).
   * @param p_diasAlquiler    Los dias de alquiler de la cabaña (int).
   * @param p_servicios       Una lista de servicios alquilados en la cabaña
   *                          (ArrayList<Servicio>).
   * @param p_nroHabitaciones El número de habitaciones de la cabaña (int).
   */
  public Cabaña(String p_nombre, double p_precioBase, int p_diasAlquiler, ArrayList<Servicio> p_servicios,
      int p_nroHabitaciones) {
    super(p_nombre, p_precioBase, p_diasAlquiler, p_servicios);
    this.setNroHabitaciones(p_nroHabitaciones);
  }

  /**
   * Establece el número de habitaciones de la cabaña.
   *
   * @param p_nroHabitaciones El número de habitaciones de la cabaña (int).
   */
  private void setNroHabitaciones(int p_nroHabitaciones) {
    this.nroHabitaciones = p_nroHabitaciones;
  }

  /**
   * Obtiene el número de habitaciones de la cabaña.
   *
   * @return El número de habitaciones de la cabaña (int).
   */
  public int getNroHabitaciones() {
    return this.nroHabitaciones;
  }

  /**
   * Calcula el costo total de alquiler de la cabaña, incluyendo un cargo
   * adicional por habitaciones.
   *
   * @return El costo total del alquiler considerando las habitaciones
   *         adicionales.
   */
  @Override
  public double costo() {
    return super.costo() + (this.getNroHabitaciones() * 30 * super.getDiasAlquiler());
  }

  /**
   * Cuenta la cantidad de alojamientos de un tipo específico.
   *
   * @param p_alojamiento El tipo de alojamiento que se desea contar .
   * @return Devuelve 1 si el tipo de alojamiento es "Cabaña" si no 0 (int).
   */
  @Override
  public int contar(String p_alojamiento) {
    return p_alojamiento == "Cabaña" ? 1 : 0;
  }

  /**
   * Imprime por pantalla el nombre del alojamiento, el costo por los dias
   * alquilados, la lista de todos los servicios alquilados, la cantidad de
   * habitaciones y el total a pagar.
   */
  @Override
  public void liquidar() {
    super.liquidar();
    System.out.format("Cabaña con %s habitaciones\n", this.getNroHabitaciones());
    System.out.format("Total: ------> $%.2f\n", this.costo() + super.costoServicios());
  }
}
