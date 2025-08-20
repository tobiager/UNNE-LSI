/**
 * Ejercicio 2, clase Laboratorio.
 * 
 * @author Olivarez Alexis E.
 */
public class Cliente {
  private int nroDni;
  private String nombre;
  private String apellido;
  private double saldo;

  /**
   * Constructor de la clase Cliente.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pDni      El DNI del cliente.
   * @param pNombre   El nombre de la cliente.
   * @param pApellido El apellido de la cliente.
   * @param pSaldo    El saldo actual del cliente.
   */
  Cliente(int pDni, String pNombre, String pApellido, double pSaldo) {
    this.setNroDni(pDni);
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setSaldo(pSaldo);
  }

  /**
   * El método establece el valor de la variable "nroDni" proporcionado del valor
   * "pDni".
   * 
   * @param pNroDni Es un valor entero que representa el DNI
   *                (Documento Nacional de Número de identidad).
   */
  private void setNroDni(int pNroDni) {
    this.nroDni = pNroDni;
  }

  /**
   * El método establece el valor de la variable "nombre" proporcionado del valor
   * "pNombre".
   * 
   * @param pNombre Es un String que representa el nombre de un cliente.
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "apellido" proporcionado del
   * valor "pApellido".
   * 
   * @param pApellido Es un String que representa el nombre de un cliente.
   *                  Debe ser un String no nulo y no vacío.
   */
  private void setApellido(String pApellido) {
    this.apellido = pApellido;
  }

  /**
   * El método establece el valor de la variable "saldo" proporcionado del valor
   * "pSaldo".
   *
   * @param pSaldo Es un valor doble que representa el nuevo
   *               valor para la variable "saldo".
   */
  private void setSaldo(double pSaldo) {
    this.saldo = pSaldo;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nroDni".
   */
  private int getNroDni() {
    return this.nroDni;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  private String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "apellido".
   */
  private String getApellido() {
    return this.apellido;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "saldo".
   */
  private double getSaldo() {
    return this.saldo;
  }

  /**
   * El método "mostrar" Muestra información del cliente, nombre y apellido, DNI
   * y el saldo.
   */
  public void mostrar() {
    System.out.println("- Cliente -");
    System.out.println("Nombre y Apellido: " + this.nomYApe() + " (" + this.getNroDni() + ")");
    System.out.println("Saldo: $" + this.getSaldo());
  }

  /**
   * El método "nomYApe" Concatena el "nombre" y el "apellido".
   *
   * @return Devuelve una cadena de texto de las variables
   *         "nombre" y "apellido" con un espacio entremedio.
   */
  public String nomYApe() {
    return this.getNombre() + " " + this.getApellido();
  }

  /**
   * El método "apeYNom" Concatena el "apellido" y el "nombre".
   *
   * @return Devuelve una cadena de texto de las variables
   *         "apellido" y "nombre" con un espacio entremedio.
   */
  public String apeYNom() {
    return this.getApellido() + " " + this.getNombre();
  }

  /**
   * El método "nuevoSaldo" asigna el nuevo saldo a la variable de instancia y
   * devuelve ese nuevo saldo.
   *
   * @param pImporte Representa el nuevo monto que se asignara a la variable
   *                 "saldo".
   * @return Devuelve el valor de "pImporte".
   */
  public double nuevoSaldo(double pImporte) {
    this.setSaldo(pImporte);
    return pImporte;
  }

  /**
   * El método "agregaSaldo" agrega saldo a la variable de instancia "saldo" y
   * devuelve el saldo actual.
   *
   * @param pImporte Representa el nuevo monto que se agregará a la variable
   *                 "saldo".
   * @return Devuelve el saldo actual.
   */
  public double agregaSaldo(double pImporte) {
    this.setSaldo(this.getSaldo() + pImporte);
    return this.getSaldo();
  }
}
