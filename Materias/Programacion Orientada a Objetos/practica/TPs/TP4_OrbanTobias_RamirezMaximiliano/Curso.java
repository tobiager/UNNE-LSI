
import java.util.HashMap;
import java.util.Map;

public class Curso {
  private String nombre;
  private HashMap alumnos;

  /**
   * Constructor de la clase Curso.
   * 
   * @param p_nombre Nombre del curso de tipo String.
   */
  public Curso(String p_nombre) {
    this.setNombre(p_nombre);
    this.setAlumnos(new HashMap());
  }

  /**
   * @param p_nombre  Nombre del curso de tipo String.
   * @param p_alumnos Una colección de tipo HashMap donde la clave
   *                  es de tipo Integer y el valor es de tipo Alumno (Objeto)
   *                  *sin genericos*.
   */
  public Curso(String p_nombre, HashMap p_alumnos) {
    this.setNombre(p_nombre);
    this.setAlumnos(p_alumnos);
  }

  /**
   * El método establece el valor del atributo "nombre" de tipo String
   * proporcionado del valor "p_nombre" de tipo String.
   * 
   * @param p_nombre Representa el nuevo valor del atributo "nombre" de tipo
   *                 String.
   * @return No devuelve ningún valor.
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * El método establece una colección al atributo "alumnos" de tipo HashMap
   * proporcionado del valor "p_alumnos" de tipo HashMap.
   * 
   * @param p_alumnos La nueva colección de alumnos que se asignará.
   * @return No devuelve ningún valor.
   */
  private void setAlumnos(HashMap p_alumnos) {
    this.alumnos = p_alumnos;
  }

  /**
   * Devuelve el valor del atributo "nombre".
   * 
   * @return Devuelve un valor de tipo String.
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Devuelve el valor del atributo "alumnos".
   * 
   * @return Devuelve un valor de tipo HashMap.
   */
  public HashMap getAlumnos() {
    return this.alumnos;
  }

  /**
   * @param p_alumno Añade un Alumno de tipo Alumno (Objeto) a la colección.
   * @return No devuelve ningún valor.
   */
  public void inscribirAlumno(Alumno p_alumno) {
    this.getAlumnos().put(p_alumno.getLu(), p_alumno);
  }

  /**
   * El método busca un alumno en la colección de alumnos del curso utilizando su
   * libreta universitaria (LU) y lo elimina de la colección.
   * 
   * @param p_lu La libreta universitaria (LU) del alumno que se va a quitar.
   * @return Un Objeto Alumno que se quitó del curso, o null si no se encontró
   *         ningún alumno con el LU especificado.
   */
  public Alumno quitarAlumno(int p_lu) {
    Alumno alumno = this.buscarAlumno(p_lu);
    this.getAlumnos().remove(p_lu);
    return alumno;
  }

  /**
   * Obtiene la cantidad de alumnos inscritos en el curso.
   * 
   * @return Un entero que representa la cantidad de alumnos inscritos en el
   *         curso.
   */
  public int cantidadDeAlumnos() {
    return this.getAlumnos().size();
  }

  /**
   * Verifica si un alumno con un libreta universitaria (LU) está inscrito
   * en el curso.
   *
   * @param p_lu La libreta universitaria (LU) del alumno que se va a verificar.
   * @return Devuelve un valor Booleano, true si el alumno con el LU especificado
   *         está inscrito en el curso, false en caso contrario.
   */
  public boolean estaInscripto(int p_lu) {
    return this.getAlumnos().containsKey(p_lu);
  }

  /**
   * Verifica si un alumno específico está inscrito en el curso.
   *
   * @param p_alumno El Objeto Alumno que se va a verificar.
   * @return Devuelve un valor Booleano, true si el alumno especificado está
   *         inscrito en el curso, false en caso contrario.
   */
  public boolean estaInscripto(Alumno p_alumno) {
    return this.getAlumnos().containsValue(p_alumno);
  }

  /**
   * Busca un alumno por su libreta universitaria (LU) en el curso.
   *
   * @param p_lu La libreta universitaria (LU) del alumno que se va a buscar.
   * @return Un objeto Alumno correspondiente al LU especificado, o null si no se
   *         encuentra ningún alumno con ese LU.
   */
  public Alumno buscarAlumno(int p_lu) {
    return (Alumno) this.getAlumnos().get(p_lu);
  }

  /**
   * Imprime el promedio de un alumno de la libreta universitaria (LU)
   * especificada, si el alumno con el LU especificado no se encuentra inscrito en
   * el curso, se imprime un mensaje de error.
   *
   * @param p_lu La libreta universitaria (LU) del alumno cuyo promedio se va a
   *             imprimir.
   * @return No devuelve ningún valor.
   */
  public void imprimirPromedioDelAlumno(int p_lu) {
    Alumno alumno = buscarAlumno(p_lu);
    if (alumno == null) {
      System.out.format("****-- Lu %s no encontrado --****\n", p_lu);
      return;
    }
    System.out.format("Promedio: %s\n", alumno.promedio());
  }

  /**
   * Muestra una lista de alumnos del curso, con su libreta universitaria (LU),
   * nombre y apellido, si no hay alumnos inscriptos muestra un mensaje indicando
   * "No hay alumnos inscriptos a este curso!".
   * 
   * @return No devuelve ningún valor.
   */
  public void mostrarInscriptos() {
    if (this.getAlumnos().isEmpty()) {
      System.out.println("No hay alumnos inscriptos a este curso!\n");
      return;
    }
    for (Object object : this.getAlumnos().entrySet()) {
      Map.Entry entry = (Map.Entry) object;
      Alumno alumno = (Alumno) entry.getValue();
      System.out.format("%d, %s\n", alumno.getLu(), alumno.nomYApe());
    }
  }
}
