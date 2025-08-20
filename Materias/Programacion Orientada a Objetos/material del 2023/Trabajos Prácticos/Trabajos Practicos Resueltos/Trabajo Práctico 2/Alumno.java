/**
 * Ejercicio 4, clase Alumno.
 * 
 * @author Olivarez Alexis E.
 */
public class Alumno {
  private int lu;
  private String nombre;
  private String apellido;
  private double nota1;
  private double nota2;

  /**
   * Constructor de la clase Alumno.
   * 
   * Asigna los valores de los parámetro a las variables de
   * instancias mediante los setters.
   * Y las notas se inicializan en 0 tanto la nota1 como la
   * nota2.
   * 
   * @param pLu       El número de la libreta universitaria.
   * @param pNombre   El nombre del alumno.
   * @param pApellido El apellido del alumno.
   */
  Alumno(int pLu, String pNombre, String pApellido) {
    this.setLu(pLu);
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setNota1(0);
    this.setNota2(0);
  }

  /**
   * El método establece el valor de la variable "lu" proporcionado del valor
   * "pLu".
   * 
   * @param pLu Es un valor entero que representa el Lu
   *            (Libreta universitaria).
   */
  private void setLu(int pLu) {
    this.lu = pLu;
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
   * El método establece el valor de la variable "nota1" proporcionado
   * del valor "pNota1".
   *
   * @param pNota1 Es un número entero que
   *               representa la nota primer nota del alumno.
   */
  public void setNota1(double pNota1) {
    this.nota1 = pNota1;
  }

  /**
   * El método establece el valor de la variable "nota2" proporcionado
   * del valor "pNota2".
   *
   * @param pNota2 Es un número entero que
   *               representa la nota segunda nota del alumno.
   */
  public void setNota2(double pNota2) {
    this.nota2 = pNota2;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "lu".
   */
  private int getLu() {
    return this.lu;
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
   * @return Devuelve el valor de la variable de instancia "nota1".
   */
  private double getNota1() {
    return this.nota1;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nota2".
   */
  public double getNota2() {
    return this.nota2;
  }

  /**
   * El método calcula el promedio entre las dos notas.
   * 
   * @return El promedio de dos números, que se obtienen usando los
   *         métodos "getNota1()" y "getNota2()".
   */
  public double promedio() {
    return (this.getNota1() + this.getNota2()) / 2;
  }

  /**
   * El método "aprueba" Devuelve verdadero si la calificación promedio es mayor a
   * 7 y ambas notas individuales son mayores o iguales a 6.
   * 
   * @return Un valor Boolean(true o false).
   */
  private Boolean aprueba() {
    return promedio() > 7.0 && this.getNota1() >= 6.0 && this.getNota2() >= 6.0;
  }

  /**
   * @return Devuelve un String "APROBADO" si la condición del
   *         método "aprueba()" es verdadera, caso contrario devuelve un String
   *         "REPROBADO".
   */
  private String leyendaAprueba() {
    return this.aprueba() ? "APROBADO" : "REPROBADO";
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
   * El método "mostrar" Muestra información del alumno, nombre y apellido, LU,
   * sus dos notas y el promedio.
   */
  public void mostrar() {
    System.out.println("Nombre y Apellido: " + this.nomYApe());
    System.out.println("LU: " + this.getLu() + "\t" + "Notas: " + this.getNota1() + " - " + this.getNota2());
    System.out.println("Promedio: " + this.promedio() + " - " + this.leyendaAprueba());
  }
}
