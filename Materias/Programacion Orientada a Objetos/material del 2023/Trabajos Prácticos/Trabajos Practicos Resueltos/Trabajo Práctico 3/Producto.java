/**
 * Ejercicio 1 del Tp3, clase Producto.
 * 
 * @author Olivarez Alexis E.
 */
public class Producto {
  private int codigo;
  private String rubro;
  private String descripcion;
  private double costo;
  private int stock;
  private double porcPtoRepo;
  private int existMinima;
  private Laboratorio laboratorio;

  /**
   * Constructor de la clase Producto.
   * 
   * @param pCodigo      El codigo de un producto.
   * @param pRubro       El rubro que pertenece el producto.
   * @param pDescripcion La descripción de un producto.
   * @param pCosto       El precio del producto.
   * @param pPorcPtoRepo // ! Ni idea.
   * @param pLaboratorio Un objeto de la clase Laboratorio.
   */
  Producto(int pCodigo, String pRubro, String pDescripcion, double pCosto, double pPorcPtoRepo, int pExistMinima,
      Laboratorio pLaboratorio) {
    this.setCodigo(pCodigo);
    this.setRubro(pRubro);
    this.setDescripcion(pDescripcion);
    this.setCosto(pCosto);
    this.setStock(0);
    this.setPorcPtoRepo(pPorcPtoRepo);
    this.setExistMinima(pExistMinima);
    this.setLaboratorio(pLaboratorio);
  }

  /**
   * Constructor de la clase Producto.
   * 
   * @param pCodigo      El codigo de un producto.
   * @param pRubro       El rubro que pertenece el producto.
   * @param pDescripcion La descripción de un producto.
   * @param pCosto       El precio del producto.
   * @param pLaboratorio Un objeto de la clase Laboratorio.
   */
  Producto(int pCodigo, String pRubro, String pDescripcion, double pCosto, Laboratorio pLaboratorio) {
    this.setCodigo(pCodigo);
    this.setRubro(pRubro);
    this.setDescripcion(pDescripcion);
    this.setCosto(pCosto);
    this.setStock(0);
    this.setLaboratorio(pLaboratorio);
  }

  /**
   * El método establece el valor del objeto "laboratorio" proporcionado del valor
   * "pLaboratorio".
   * 
   * @param pLaboratorio Es de la clase Laboratorio que representa un Laboratorio.
   */
  private void setLaboratorio(Laboratorio pLaboratorio) {
    this.laboratorio = pLaboratorio;
  }

  /**
   * El método establece el valor de la variable "codigo" proporcionado del valor
   * "pCodigo".
   *
   * @param pCodigo Es un valor entero que representa el nuevo valor para la
   *                variable "codigo".
   */
  private void setCodigo(int pCodigo) {
    this.codigo = pCodigo;
  }

  /**
   * El método establece el valor de la variable "rubro" proporcionado del valor
   * "pRubro".
   *
   * @param pRubro Es un String que representa el nuevo valor para la variable
   *               "rubro".
   *               Debe ser un String no nulo y no vacío.
   */
  private void setRubro(String pRubro) {
    this.rubro = pRubro;
  }

  /**
   * El método establece el valor de la variable "descripcion" proporcionado del
   * valor
   * "pDescripcion".
   *
   * @param pDescripcion Es un String que representa el nuevo valor para la
   *                     variable "descripcion".
   *                     Debe ser un String no nulo y no vacío.
   */
  private void setDescripcion(String pDescripcion) {
    this.descripcion = pDescripcion;
  }

  /**
   * El método establece el valor de la variable "costo" proporcionado del valor
   * "pCosto".
   *
   * @param pCosto Es un número doble que representa el nuevo valor para la
   *               variable "costo".
   */
  private void setCosto(double pCosto) {
    this.costo = pCosto;
  }

  /**
   * El método establece el valor de la variable "stock" proporcionado del valor
   * "pStock".
   *
   * @param pStock Es un valor entero que representa el nuevo valor para la
   *               variable "stock".
   */
  private void setStock(int pStock) {
    this.stock = pStock;
  }

  /**
   * El método establece el valor de la variable "porcPtoRepo" proporcionado del
   * valor "pPorcPtoRepo".
   *
   * @param pPorcPtoRepo Es un número doble que representa el nuevo valor para la
   *                     variable "porcPtoRepo".
   */
  private void setPorcPtoRepo(double pPorcPtoRepo) {
    this.porcPtoRepo = pPorcPtoRepo;
  }

  /**
   * El método establece el valor de la variable "existMinima" proporcionado del
   * valor "pExistMinima".
   *
   * @param pExistMinima Es un valor entero que representa el nuevo valor para la
   *                     variable "existMinima".
   */
  private void setExistMinima(int pExistMinima) {
    this.existMinima = pExistMinima;
  }

  /**
   * El método devuelve la instancia de la clase Laboratorio.
   * 
   * @return El método retorna un objeto de tipo "Laboratorio".
   */
  public Laboratorio getLaboratorio() {
    return this.laboratorio;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "codigo".
   */
  public int getCodigo() {
    return this.codigo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "rubro".
   */
  public String getRubro() {
    return this.rubro;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "descripcion".
   */
  public String getDescripcion() {
    return this.descripcion;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "costo".
   */
  public double getCosto() {
    return this.costo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "stock".
   */
  public int getStock() {
    return this.stock;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "porcPtoRepo".
   */
  public double getPorcPtoRepo() {
    return this.porcPtoRepo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "existMinima".
   */
  public int getExistMinima() {
    return this.existMinima;
  }

  /**
   * El método "ajuste" Ajusta la cantidad de stock.
   *
   * @param pCantidad Representa la cantidad de ítems a ajustar en el existencias.
   *                  El valor puede ser positivo para agregar o negativo para
   *                  sacar stock.
   */
  public void ajuste(int pCantidad) {
    this.setStock(this.getStock() + pCantidad);
    if (this.getStock() < 0) {
      this.setStock(0);
    }
  }

  /**
   * El método "precioLista" Calcula la suma del 12% del costo al costo original.
   *
   * @return El precio de lista del producto.
   */
  public double precioLista() {
    return this.getCosto() + this.getCosto() * 0.12;
  }

  /**
   * El método "precioContado" Calcula la diferencia del 5% del precio de lista al
   * precio de lista original.
   *
   * @return El precio al contado del producto.
   */
  public double precioContado() {
    return this.precioLista() - this.precioLista() * 0.05;
  }

  /**
   * El método "stockValorizado" Calcula el valor del stock multiplicando la
   * cantidad de stock por su costo y agregando un 12% adicional.
   *
   * @return Devuelve el stock valorizado, el cual se calcula multiplicando el
   *         stock cantidad por el costo unitario y luego sumando
   *         el 12% del valor resultante.
   */
  public double stockValorizado() {
    double agregado = 0.12;
    double precioStock = this.getStock() * this.getCosto();
    return precioStock + precioStock * agregado;
  }

  /**
   * El método "ajustarPtoRepo" ajusta el porcentaje del punto de repo.
   *
   * @param pPorcPtoRepo Es de tipo doble y representa el porcentaje
   *                     del punto de repo a ajustar.
   */
  public void ajustarPtoRepo(double pPorcPtoRepo) {
    this.setPorcPtoRepo(porcPtoRepo);
  }

  /**
   * El método "ajustarExistMin" ajusta el valor mínimo de existencia.
   *
   * @param pExistMinima Es un valor entero que representa el valor deseado.
   *                     cantidad mínima de un producto.
   */
  public void ajustarExistMin(int pExistMinima) {
    this.setExistMinima(existMinima);
  }

  /**
   * El método "mostrar" imprime información sobre un producto, incluyendo el
   * laboratorio, rubro, descripción, costo, stock y valor de stock.
   */
  public void mostrar() {
    System.out.println(this.laboratorio.mostrar());
    System.out.println("Rubro: " + this.getRubro());
    System.out.println("Descripcion: " + this.getDescripcion());
    System.out.println("Precio Costo: $" + this.getCosto());
    System.out.println("Stock: " + this.getStock() + " - Stock Valorizado: $" + this.stockValorizado());
  }

  /**
   * El método "mostrarLinea" devuelve una cadena que incluye la descripción,
   * precio de lista y precio al contado.
   *
   * @return Devuelve una cadena concatenando la descripción,
   *         el precio de lista y el precio al contado.
   */
  public String mostrarLinea() {
    return this.getDescripcion() + " " + this.precioLista() + " " + this.precioContado();
  }
}
