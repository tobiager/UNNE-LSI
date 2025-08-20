import java.util.Calendar;
import java.util.GregorianCalendar;
/**
 * Ejercicio 5, clase Empleado.
 * 
 * @author Olivarez Alexis E.
 */
public class Empleado {
  private long cuil;
  private String apellido;
  private String nombre;
  private double sueldoBasico;
  private int anioIngreso;

  /**
   * Constructor de la clase Empleado.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * 
   * @param pCuil         El número de cuil del empleado.
   * @param pApellido     El apellido del empleado.
   * @param pNombre       El nombre del empleado.
   * @param pSueldoBasico El sueldo basico del empleado.
   * @param pAnioIngreso  El año que ingreso el empleado.
   */
  Empleado(long pCuil, String pApellido, String pNombre, double pSueldoBasico, int pAnioIngreso) {
    this.setCuil(pCuil);
    this.setApellido(pApellido);
    this.setNombre(pNombre);
    this.setSueldoBasico(pSueldoBasico);
    this.setAnioIngreso(pAnioIngreso);
  }

  /**
   * El método establece el valor de la variable "cuil" proporcionado del valor
   * "pCuil".
   * 
   * @param pCuil Es un valor entero que representa el cuil del empleado.
   */
  private void setCuil(long pCuil) {
    this.cuil = pCuil;
  }

  /**
   * El método establece el valor de la variable "apellido" proporcionado del
   * valor "pApellido".
   *
   * @param pApellido Es un String que representa el nuevo valor para la variable
   *                  "apellido".
   *                  Debe ser un String no nulo y no vacío.
   */
  private void setApellido(String pApellido) {
    this.apellido = pApellido;
  }

  /**
   * El método establece el valor de la variable "nombre" proporcionado del
   * valor "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para la variable
   *                "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor de la variable "sueldoBasico" proporcionado del
   * valor "pSueldoBasico".
   *
   * @param pSueldoBasico Es un número doble que representa el nuevo valor para la
   *                      variable "sueldoBasico".
   */
  private void setSueldoBasico(double pSueldoBasico) {
    this.sueldoBasico = pSueldoBasico;
  }

  /**
   * El método establece el valor de la variable "anioIngreso" proporcionado
   * del valor "pAnioIngreso".
   *
   * @param pAnioIngreso Es un número entero que representa el año de que ingreso
   *                     el empleado a la empresa.
   */
  private void setAnioIngreso(int pAnioIngreso) {
    this.anioIngreso = pAnioIngreso;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "cuil".
   */
  public long getCuil() {
    return this.cuil;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "apellido".
   */
  public String getApellido() {
    return this.apellido;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "sueldoBasico".
   */
  public double getSueldoBasico() {
    return this.sueldoBasico;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "anioIngreso".
   */
  public int getAnioIngreso() {
    return this.anioIngreso;
  }

  /**
   * El método "antiguedad" Calcula la diferencia entre año actual y año de que
   * ingreso el empleado.
   *
   * @return Devuelve la cantidad de años de servicio.
   */
  public int antiguedad() {
    Calendar fechaHoy = new GregorianCalendar();
    int anioHoy = fechaHoy.get(Calendar.YEAR);
    return anioHoy - this.getAnioIngreso();
  }

  /**
   * El método "descuento" Calcula el monto total del descuento sumando la
   * contribución al seguro médico y el importe fijo para el seguro de vida.
   *
   * @return Devuelve la suma de las variables locales "obraSocial" y
   *         "seguroVida".
   */
  private double descuento() {
    double obraSocial = this.getSueldoBasico() * 0.02;
    double seguroVida = 1500;
    return obraSocial + seguroVida;
  }

  /**
   * El método "sueldoNeto" Calcula el sueldo neto del empleado sumando el salario
   * básico, el monto adicional, y restando el monto del descuento.
   *
   * @return Devuelve el salario neto.
   */
  public double sueldoNeto() {
    return this.getSueldoBasico() + this.adicional() - this.descuento();
  }

  /**
   * El método "nomYApe" Concatena el "nombre" y el "apellido".
   *
   * @return Devuelve una cadena de caracteres de las variables
   *         "nombre" y "apellido" con un espacio entremedio.
   */
  public String nomYApe() {
    return this.getNombre() + " " + this.getApellido();
  }

  /**
   * El método "apeYNom" Concatena el "apellido" y el "nombre".
   *
   * @return Devuelve una cadena de caracteres de las variables
   *         "apellido" y "nombre" con un espacio entremedio.
   */
  public String apeYNom() {
    return this.getApellido() + " " + this.getNombre();
  }

  /**
   * El método "adicional" Calcula el monto adicional en función de los años de
   * servicio del empleado.
   *
   * @return Devuelve la cantidad adicional basada en los años de antigüedad del
   *         empleado y su salario básico (sueldoBasico).
   */
  private double adicional() {
    if (this.antiguedad() < 2) {
      return this.getSueldoBasico() * 0.02;
    } else if (this.antiguedad() < 10) {
      return this.getSueldoBasico() * 0.04;
    }
    return this.getSueldoBasico() * 0.06;
  }

  /**
   * El método "mostrar" Muestra el nombre y apellido, CUIL, años de servicio y
   * salario neto del empleado.
   */
  public void mostrar() {
    System.out.println("Nombre y Apellido: " + this.nomYApe());
    System.out.println("CUIL: " + this.getCuil() + "\t" + "Antiguedad: " + this.antiguedad() + " años de servicio.");
    System.out.println("Sueldo Neto: $" + this.sueldoNeto());
  }

  /**
   * El método "mostrarLinea" Concatena el CUIL, apellido, nombre y salario neto.
   *
   * @return Devuelve una cadena de caracteres que contiene el CUIL, apellido,
   *         nombre y sueldo neto.
   */
  public String mostrarLinea() {
    return this.getCuil() + "\t" + this.getApellido() + "," + this.getNombre() + " $ " + this.sueldoNeto();
  }
}
