public class Circulo extends Elipse {
  /**
   * Crea un objeto Circulo con un radio y un centro.
   *
   * @param p_radio  El radio del círculo (double).
   * @param p_centro El centro del círculo representado como un objeto (Punto).
   */
  public Circulo(double p_radio, Punto p_centro) {
    super(p_radio, p_radio, p_centro);
  }

  /**
   * @return Un String del nombre de la figura "Circulo" (String).
   */
  public String nombreFigura() {
    return "****** Circulo ******";
  }
}