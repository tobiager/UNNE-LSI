
public class Servicio {
  private String descripcion;
  private double precio;

  /**
   * @param p_descripcion La descripcion del servicio a alquilar (String).
   * @param p_precio      El precio del servicio a alquilar (double).
   */
  public Servicio(String p_descripcion, double p_precio) {
    this.setDescripcion(p_descripcion);
    this.setPrecio(p_precio);
  }

  /**
   * Establece la descripcion del servicio a alquilar.
   * 
   * @param p_descripcion La descripcion del servicio a alquilar (String).
   */
  private void setDescripcion(String p_descripcion) {
    this.descripcion = p_descripcion;
  }

  /**
   * Establece el precio del servicio a alquilar.
   * 
   * @param p_precio El precio del servicio a alquilar (double).
   */
  private void setPrecio(double p_precio) {
    this.precio = p_precio;
  }

  /**
   * Obtiene la descripcion del servicio.
   *
   * @return La descripcion del servicio (String).
   */
  public String getDescripcion() {
    return this.descripcion;
  }

  /**
   * Obtiene el precio del servicio a alquilar.
   *
   * @return El precio del servicio a alquilar (double).
   */
  public double getPrecio() {
    return this.precio;
  }
}
