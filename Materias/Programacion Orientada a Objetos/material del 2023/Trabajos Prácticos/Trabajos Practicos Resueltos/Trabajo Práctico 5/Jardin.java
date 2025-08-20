import java.util.ArrayList;

public class Jardin {
  private String nombre;
  private ArrayList<FiguraGeometrica> figuras;

  /**
   * @param p_nombre El nombre del jardin (String).
   */
  public Jardin(String p_nombre) {
    this.setNombre(p_nombre);
    this.setFiguras(new ArrayList<FiguraGeometrica>());
  }

  /**
   * @param p_nombre  El nombre del jardin (String).
   * @param p_figuras Una lista de figuras geometricas
   *                  (ArrayList<FiguraGeometrica>).
   */
  public Jardin(String p_nombre, ArrayList<FiguraGeometrica> p_figuras) {
    this.setNombre(p_nombre);
    this.setFiguras(p_figuras);
  }

  /**
   * Establece el nombre del jardin.
   *
   * @param p_nombre El nombre del jardin (String).
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Establece una lista de figuras geometricas.
   * 
   * @param p_figuras La lista de figuras geometricas
   *                  (ArrayList<FiguraGeometrica>).
   */
  private void setFiguras(ArrayList<FiguraGeometrica> p_figuras) {
    this.figuras = p_figuras;
  }

  /**
   * Obtiene el nombre del jardin.
   *
   * @return El nombre del jardin (String).
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Obtiene una lista de figuras geometricas.
   * 
   * @return La lista de figuras geometricas (ArrayList<FiguraGeometrica>).
   */
  public ArrayList<FiguraGeometrica> getFiguras() {
    return this.figuras;
  }

  /**
   * Agrega una figura geometrica a la lista de figuras.
   *
   * @param p_figura El tipo de figura que se agregará (FiguraGeometrica).
   * @return Devuelve true si la figura se agregó con éxito, false en caso
   *         contrario (boolean).
   */
  public boolean agregarFigura(FiguraGeometrica p_figura) {
    return this.getFiguras().add(p_figura);
  }

  /**
   * Quita una figura geometrica de la lista de figuras.
   *
   * @param p_figura El tipo de figura que se va quitar (FiguraGeometrica).
   * @return Devuelve true si la figura se quitó con éxito, false en caso
   *         contrario (boolean).
   */
  public boolean quitarFigura(FiguraGeometrica p_figura) {
    return this.getFiguras().remove(p_figura);
  }

  /**
   * @return La cantidad de litros de pintura que se necesitan (double).
   */
  private double cuantosLitros() {
    return this.cuantasLatas() * 4;
  }

  /**
   * @return La cantidad de latas que se necesitan para pintar (int).
   */
  public int cuantasLatas() {
    return (int) Math.ceil(this.cuantosMetros() / 20);
  }

  /**
   * @return La cantidad de metros a pintar (double).
   */
  public double cuantosMetros() {
    double superficieTotal = 0;
    for (FiguraGeometrica figura : this.getFiguras()) {
      superficieTotal += figura.superficie();
    }
    return superficieTotal;
  }

  /**
   * Imprime por pantalla el presupuesto la lista de figuras con su superficie, el
   * total a cubrir y las latas de pintura a comprar.
   */
  public void detalleFiguras() {
    System.out.format("Presupuesto: %s\n", this.getNombre());
    for (FiguraGeometrica figura : this.getFiguras()) {
      figura.mostrarSuperficie();
    }
    System.out.println("---------------------------------------------");
    System.out.format("Total a cubrir: %.2f\n", this.cuantosMetros());
    System.out.format("Comprar %s Latas.", this.cuantasLatas());
  }
}