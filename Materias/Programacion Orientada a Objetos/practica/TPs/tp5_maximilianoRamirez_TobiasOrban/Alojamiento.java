
import java.util.ArrayList;

public abstract class Alojamiento {
  private String nombre;
  private double precioBase;
  private int diasAlquiler;
  private ArrayList<Servicio> servicios;

  public abstract int contar(String p_alojamiento);

  /**
   * @param p_nombre       El nombre del alojamiento (String.)
   * @param p_precioBase   El precio base del alojamiento (double).
   * @param p_diasAlquiler Los dias de alquiler del alojamiento (int).
   */
  public Alojamiento(String p_nombre, double p_precioBase, int p_diasAlquiler) {
    this.setNombre(p_nombre);
    this.setPrecioBase(p_precioBase);
    this.setDiasAlquiler(p_diasAlquiler);
    this.setServicios(new ArrayList<Servicio>());
  }

  /**
   * @param p_nombre       El nombre del alojamiento (String.)
   * @param p_precioBase   El precio base del alojamiento (double).
   * @param p_diasAlquiler Los dias de alquiler del alojamiento (int).
   * @param p_servicios    Una lista de servicios alquilados
   *                       (ArrayList<Servicio>).
   */
  public Alojamiento(String p_nombre, double p_precioBase, int p_diasAlquiler, ArrayList<Servicio> p_servicios) {
    this.setNombre(p_nombre);
    this.setPrecioBase(p_precioBase);
    this.setDiasAlquiler(p_diasAlquiler);
    this.setServicios(p_servicios);
  }

  /**
   * Establece el nombre del alojamiento.
   *
   * @param p_nombre El nombre del alojamiento (String).
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Establece el precio base del alojamiento.
   *
   * @param p_precioBase El precio base del alojamiento (double).
   */
  private void setPrecioBase(double p_precioBase) {
    this.precioBase = p_precioBase;
  }

  /**
   * Establece los dias de alquiler de alojamiento.
   *
   * @param p_diasAlquiler Los dias de alquiler del alojamiento (int).
   */
  private void setDiasAlquiler(int p_diasAlquiler) {
    this.diasAlquiler = p_diasAlquiler;
  }

  /**
   * Establece una lista de servicios para el alojamiento.
   *
   * @param p_servicios Los servicios proporcionados para el alojamiento
   *                    (ArrayList<Servicio>).
   */
  private void setServicios(ArrayList<Servicio> p_servicios) {
    this.servicios = p_servicios;
  }

  /**
   * Obtiene el nombre del alojamiento.
   *
   * @return El nombre del alojamiento (String).
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Obtiene el precio base del alojamiento.
   *
   * @return El precio base del alojamiento (double).
   */
  public double getPrecioBase() {
    return this.precioBase;
  }

  /**
   * Obtiene los dias de alquiler de alojamiento.
   *
   * @return Los dias de alquiler de alojamiento (int).
   */
  public int getDiasAlquiler() {
    return this.diasAlquiler;
  }

  /**
   * Obtiene una lista de servicios para el alojamiento.
   *
   * @return Una lista de servicios para el alojamiento (ArrayList<Servicio>).
   */
  public ArrayList<Servicio> getServicios() {
    return this.servicios;
  }

  /**
   * Agrega un servicio contrado para el alojamiento.
   *
   * @param p_servicio El tipo de servicio que se alquilá (Servicio).
   * @return Devuelve true si el servicio se agregó con éxito, false en caso
   *         contrario (boolean).
   */
  public boolean agregarServicio(Servicio p_servicio) {
    return this.getServicios().add(p_servicio);
  }

  /**
   * Quita un servicio contrado del alojamiento.
   *
   * @param p_servicio El tipo de servicio que se va quitar (Servicio).
   * @return Devuelve true si el servicio se quitó con éxito, false en caso
   *         contrario (boolean).
   */
  public boolean quitarServicio(Servicio p_servicio) {
    return this.getServicios().remove(p_servicio);
  }

  /**
   * Calcula el costo del alquiler del alojamiento.
   *
   * @return Devuelve el costo calculando del precio base por el número de
   *         días de alquiler (double).
   */
  public double costo() {
    return this.getPrecioBase() * this.getDiasAlquiler();
  }

  /**
   * @return Devuelve el total que deberá pagar por los servicios alquilados
   *         (double).
   */
  public double costoServicios() {
    double totalCosto = 0;
    for (Servicio servicio : this.getServicios()) {
      totalCosto += servicio.getPrecio();
    }
    return totalCosto;
  }

  /**
   * Imprime por pantalla una lista de los servicios alquilados en el
   * alojamiento, con su nombre de servicio y su precio.
   */
  public void listarServicios() {
    for (Servicio servicio : this.getServicios()) {
      System.out.format("%s: $%.2f\n", servicio.getDescripcion(), servicio.getPrecio());
    }
  }

  /**
   * Imprime por pantalla el nombre del alojamiento, el costo por los dias
   * alquilados y la lista de todos los servicios alquilados.
   */
  public void liquidar() {
    System.out.format("Alojamiento: %s\n", this.getNombre());
    System.out.format("Costo por %s dias: $%.2f\n", this.getDiasAlquiler(), this.costo());
    this.listarServicios();
  }
}
