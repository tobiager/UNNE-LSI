import java.util.ArrayList;

public class Pedido {
  private ArrayList<Renglon> renglones;

  /**
   * @param p_renglon Un renglón para las etiquetas (Renglon).
   */
  public Pedido(Renglon p_renglon) {
    this.setRenglones(new ArrayList<Renglon>());
    this.agregarRenglon(p_renglon);
  }

  /**
   * @param p_renglones Una lista de renglones con etiquetas (ArrayList<Renglon>).
   */
  public Pedido(ArrayList<Renglon> p_renglones) {
    this.setRenglones(p_renglones);
  }

  /**
   * Asigna una lista de renglones para las diferentes etiquetas.
   *
   * @param p_renglones Una lista de renglones con etiquetas (ArrayList<Renglon>).
   */
  private void setRenglones(ArrayList<Renglon> p_renglones) {
    this.renglones = p_renglones;
  }

  /**
   * Obtiene una lista de los renglones para las diferentes etiquetas.
   * 
   * @return Una lista de renglones con etiquetas (ArrayList<Renglon>).
   */
  public ArrayList<Renglon> getRenglones() {
    return this.renglones;
  }

  /**
   * Agrega un renglon a la lista de renglones.
   *
   * @param p_renglon El renglon que se va agregar a la lista de renglones
   *                  (Renglon).
   */
  public boolean agregarRenglon(Renglon p_renglon) {
    return this.getRenglones().add(p_renglon);
  }

  /**
   * Quita un renglon a la lista de renglones.
   *
   * @param p_renglon El renglon que se va quitar de la lista de renglones
   *                  (Renglon).
   */
  public boolean quitarRenglon(Renglon p_renglon) {
    boolean seQuitó = false;
    if (this.getRenglones().size() > 1) {
      seQuitó = this.getRenglones().remove(p_renglon);
    }
    return seQuitó;
  }

  /**
   * Imprime por pantalla el pedido con la cantidad de items, y una lista
   * enúmerada de los items con su informácion y el precio. Al final el total de
   * etiquetas y el importe total a pagar.
   */
  public void mostrar() {
    double importeTotal = 0;
    int cantidadTotal = 0;
    System.out.println("Pedido:");
    System.out.format("Cantidad de items: %s\n", this.getRenglones().size());
    for (int i = 0; i < this.getRenglones().size(); i++) {
      System.out.format("Item %s: ", i + 1);
      this.getRenglones().get(i).mostrar();
      System.out.format("Precio: $%s\n", this.getRenglones().get(i).getImporte());
      importeTotal += this.getRenglones().get(i).getImporte();
      cantidadTotal += this.getRenglones().get(i).getCantidad();
    }
    System.out.format("--- Total pedido: %s etiquetas por un importe total de: $%s\n", cantidadTotal, importeTotal);
  }
}