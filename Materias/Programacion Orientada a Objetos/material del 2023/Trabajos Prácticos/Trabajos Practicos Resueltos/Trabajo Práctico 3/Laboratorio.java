/**
 * Ejercicio 1 del Tp3, clase Laboratorio.
 * 
 * @author Olivarez Alexis E.
 */
public class Laboratorio {
  private String nombre;
  private String domicilio;
  private String telefono;
  private int compraMinima;
  private int diaEntrega;

  /**
   * Constructor de la clase Laboratorio.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pNombre       El nombre del laboratorio.
   * @param pDomicilio    El domicilio del laboratorio.
   * @param pTelefono     El telefono del laboratorio.
   * @param pCompraMinima La compra minima de un producto.
   * @param pDiaEntrega   El dia que se va entregar el producto.
   */
  Laboratorio(String pNombre, String pDomicilio, String pTelefono, int pCompraMinima, int pDiaEntrega) {
    this.setNombre(pNombre);
    this.setDomicilio(pDomicilio);
    this.setTelefono(pTelefono);
    this.setCompraMinima(pCompraMinima);
    this.setDiaEntrega(pDiaEntrega);
  }

  /**
   * Constructor de la clase Laboratorio.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pNombre    El nombre del laboratorio.
   * @param pDomicilio El domicilio del laboratorio.
   * @param pTelefono  El telefono del laboratorio.
   */
  Laboratorio(String pNombre, String pDomicilio, String pTelefono) {
    this.setNombre(pNombre);
    this.setDomicilio(pDomicilio);
    this.setTelefono(pTelefono);
    this.setCompraMinima(1);
    this.setDiaEntrega(0);
  }

  /**
   * El método establece el valor de la variable "nombre" proporcionado del valor
   * "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la variable
   *                "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "domicilio" proporcionado del
   * valor "pDomicilio".
   *
   * @param pDomicilio Es un String que representa el nuevo valor para la variable
   *                   "domicilio".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setDomicilio(String pDomicilio) {
    this.domicilio = pDomicilio;
  }

  /**
   * El método establece el valor de la variable "telefono" proporcionado del
   * valor "pTelefono".
   *
   * @param pDomicilio Es un String que representa el nuevo valor para la variable
   *                   "pTelefono".
   *                   Debe ser un String no nulo y no vacío.
   */
  private void setTelefono(String pTelefono) {
    this.telefono = pTelefono;
  }

  /**
   * El método establece el mínimo de compra proporcionado del
   * valor "pCompraMinima".
   *
   * @param pCompraMinima Es un número entero que representa el nuevo valor para
   *                      la variable "compraminima".
   */
  private void setCompraMinima(int pCompraMinima) {
    this.compraMinima = pCompraMinima;
  }

  /**
   * El método establece el valor de la variable "diaEntrega".
   *
   * @param pDiaEntrega Es un número entero que representa el día de la semana
   *                    para entregar el producto.
   */
  private void setDiaEntrega(int pDiaEntrega) {
    this.diaEntrega = pDiaEntrega;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "domicilio".
   */
  public String getDomicilio() {
    return this.domicilio;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "telefono".
   */
  public String getTelefono() {
    return this.telefono;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "compraMinima".
   */
  public int getCompraMinima() {
    return this.compraMinima;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "diaEntrega".
   */
  public int getDiaEntrega() {
    return this.diaEntrega;
  }

  /**
   * El método establece el mínimo de compra proporcionado del
   * valor "pCompraMinima".
   *
   * @param pCompraMinima Es un número entero que representa el nuevo valor para
   *                      la variable "compraminima".
   */
  public void ajusteCompraMinima(int pCompraMinima) {
    this.setCompraMinima(pCompraMinima);
  }

  /**
   * El método establece el valor de la variable "diaEntrega".
   *
   * @param pDiaEntrega Es un número entero que representa el día de la semana
   *                    para entregar el producto.
   */
  public void ajusteDiaEntrega(int pDiaEntrega) {
    this.setDiaEntrega(pDiaEntrega);
  }

  /**
   * El método "mostrar" Muestra información del laboratorio, nombre y domicilio,
   * y el telefono.
   */
  public String mostrar() {
    // return "Laboratorio: " + this.getNombre() + "\n" + "Domicilio: " +
    // this.getDomicilio() + " - " + "Telefono: " + this.getTelefono();
    return String.format("Laboratorio: %s\nDomicilio: %s - Telefono: %s", this.getNombre(), this.getDomicilio(),
        this.getTelefono());
  }
}