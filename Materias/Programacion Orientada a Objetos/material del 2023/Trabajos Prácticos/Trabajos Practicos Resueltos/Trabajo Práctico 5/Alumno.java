import java.util.Calendar;

public class Alumno extends Persona {
  private int lu;
  private double nota1;
  private double nota2;

  /**
   * Constructor de la clase Alumno.
   * 
   * @param p_lu             El número de la libreta universitaria (int).
   * @param p_dni            El DNI del alumno (int).
   * @param p_nombre         El nombre del alumno (String).
   * @param p_apellido       El apellido del alumno (String).
   * @param p_anioNacimiento El año de nacimiento del alumno (int).
   */
  public Alumno(int p_lu, int p_dni, String p_nombre, String p_apellido, int p_anioNacimiento) {
    super(p_dni, p_nombre, p_apellido, p_anioNacimiento);
    this.setLu(p_lu);
    this.setNota1(0);
    this.setNota2(0);
  }

  /**
   * Constructor de la clase Alumno.
   * 
   * @param p_lu              El número de la libreta universitaria (int).
   * @param p_dni             El DNI del alumno (int).
   * @param p_nombre          El nombre del alumno (String).
   * @param p_apellido        El apellido del alumno (String).
   * @param p_fechaNacimiento La fecha de nacimiento del alumno (Calendar).
   */
  public Alumno(int p_lu, int p_dni, String p_nombre, String p_apellido, Calendar p_fechaNacimiento) {
    super(p_dni, p_nombre, p_apellido, p_fechaNacimiento);
    this.setLu(p_lu);
    this.setNota1(0);
    this.setNota2(0);
  }

  /**
   * Establece el valor de la variable "lu" proporcionado del valor
   * "p_lu".
   * 
   * @param p_lu Es un valor entero que representa el Lu
   *             (Libreta universitaria).
   */
  private void setLu(int p_lu) {
    this.lu = p_lu;
  }

  /**
   * Establece el valor de la variable "nota1" proporcionado
   * del valor "p_nota1".
   *
   * @param p_nota1 Es un número entero que
   *                representa la nota primer nota del alumno.
   */
  public void setNota1(double p_nota1) {
    this.nota1 = p_nota1;
  }

  /**
   * Establece el valor de la variable "nota2" proporcionado
   * del valor "p_nota2".
   *
   * @param p_nota2 Es un número entero que
   *                representa la nota segunda nota del alumno.
   */
  public void setNota2(double p_nota2) {
    this.nota2 = p_nota2;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "lu".
   */
  public int getLu() {
    return this.lu;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nota1".
   */
  public double getNota1() {
    return this.nota1;
  }

  /**
   * @return Devuelve el valor de la variable de instancia "nota2".
   */
  public double getNota2() {
    return this.nota2;
  }

  /**
   * Calcula el promedio entre las dos notas.
   * 
   * @return El promedio de dos números, que se obtienen usando los
   *         métodos "getNota1()" y "getNota2()".
   */
  public double promedio() {
    return (this.getNota1() + this.getNota2()) / 2;
  }

  /**
   * Devuelve verdadero si la calificación promedio es mayor a
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
    return this.aprueba() ? "APROBADO" : "DESAPROBADO";
  }

  /**
   * Muestra información del alumno, nombre, apellido, dni,
   * edad, LU, sus dos notas y el promedio de esas notas.
   */
  @Override
  public void mostrar() {
    super.mostrar();
    System.out.format("LU: %s\tNotas: %s - %s\n", this.getLu(), this.getNota1(), this.getNota2());
    System.out.format("Promedio: %s - %s\n", this.promedio(), this.leyendaAprueba());
  }
}
