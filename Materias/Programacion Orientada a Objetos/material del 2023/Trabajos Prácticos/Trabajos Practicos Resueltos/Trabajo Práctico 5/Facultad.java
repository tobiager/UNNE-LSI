import java.util.ArrayList;

public class Facultad {
  private String nombre;
  private ArrayList<Profesor> profesores;

  /**
   * Crea una nueva instancia de la clase Facultad con un nombre y un profesor
   * inicial.
   *
   * @param p_nombre   El nombre de la facultad (String).
   * @param p_profesor El profesor inicial que se agregará a la facultad
   *                   (Profesor).
   */
  public Facultad(String p_nombre, Profesor p_profesor) {
    this.setNombre(p_nombre);
    this.setProfesores(new ArrayList<Profesor>());
    this.agregarProfesor(p_profesor);
  }

  /**
   * Crea una nueva instancia de la clase Facultad con un nombre y un profesor
   * inicial.
   *
   * @param p_nombre     El nombre de la facultad (String).
   * @param p_profesores El profesor inicial que se agregará a la facultad
   *                     (ArrayList<Profesor>).
   */
  public Facultad(String p_nombre, ArrayList<Profesor> p_profesores) {
    this.setNombre(p_nombre);
    this.setProfesores(p_profesores);
  }

  /**
   * Establece el nombre de la facultad.
   *
   * @param p_nombre El nombre de la facultad que va asignar al atributo "nombre".
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Establece la lista de profesores de la facultad.
   *
   * @param p_profesores La lista de profesores.
   */
  private void setProfesores(ArrayList<Profesor> p_profesores) {
    this.profesores = p_profesores;
  }

  /**
   * Obtiene el nombre de la facultad.
   *
   * @return El nombre de la facultad (String).
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Obtiene la lista de profesores de la facultad.
   *
   * @return La lista de profesores de la facultad (ArrayList<Profesor>).
   */
  public ArrayList<Profesor> getProfesores() {
    return this.profesores;
  }

  /**
   * Agrega un profesor a la lista de profesores de la facultad.
   *
   * @param p_profesor El profesor que se va a agregar a la facultad (Profesor).
   */
  public void agregarProfesor(Profesor p_profesor) {
    this.getProfesores().add(p_profesor);
  }

  /**
   * Genera una nómina de todos los profesores de la facultad, mostrando el DNI,
   * nombre, sueldo total de cada profesor y al final el total a pagar.
   */
  public void nominaProfesores() {
    System.out.println("*************** Nómina Facultad: FaCENA");
    System.out.println("------------------------------------------------");
    for (Profesor profesor : this.getProfesores()) {
      System.out.println(profesor.mostrarLinea());
    }
    System.out.println("------------------------------------------------");
    System.out.format("Total a pagar: $%s\n", this.totalAPagar());
  }

  /**
   * Calcula y devuelve el total a pagar a todos los profesores de la facultad.
   *
   * @return El monto total a pagar a los profesores (double).
   */
  public double totalAPagar() {
    double totalPagar = 0;
    for (Profesor profesor : this.getProfesores()) {
      totalPagar += profesor.sueldoTotal();
    }
    return totalPagar;
  }

  /**
   * Lista y muestra en detalle los profesores y sus respectivos cargos en la
   * facultad.
   * Muestra el nombre, apellido y cargos de cada profesor.
   * Y al final muestra el número total de profesores en la facultad.
   */
  public void listarProfesorCargos() {
    System.out.println("***** Detalle de Profesores y cargos de Facultad: FaCENA *****");
    for (Profesor profesor : this.getProfesores()) {
      System.out.println("------------------ **** -------------------");
      profesor.mostrar();
    }
    System.out.println("----------------------------------------------------------------------");
    System.out.format("Hay %s profesores\n", this.getProfesores().size());
  }
}
