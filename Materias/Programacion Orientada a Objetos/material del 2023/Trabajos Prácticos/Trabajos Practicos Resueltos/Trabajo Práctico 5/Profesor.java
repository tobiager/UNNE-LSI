import java.util.ArrayList;
import java.util.Calendar;

public class Profesor extends Persona {
  private String titulo;
  private ArrayList<Cargo> cargos = new ArrayList<Cargo>(3);

  /**
   * Constructor para crear un objeto Profesor con un título, DNI, nombre,
   * apellido, año de nacimiento y un cargo inicial.
   *
   * @param p_titulo         Título del profesor (String).
   * @param p_dni            DNI del profesor (int).
   * @param p_nombre         Nombre del profesor (String).
   * @param p_apellido       Apellido del profesor (String).
   * @param p_anioNacimiento Año de ingreso del profesor (int).
   * @param p_cargo          Cargo inicial asignado al profesor (Cargo).
   */
  public Profesor(String p_titulo, int p_dni, String p_nombre, String p_apellido, int p_anioNacimiento, Cargo p_cargo) {
    super(p_dni, p_nombre, p_apellido, p_anioNacimiento);
    this.setTitulo(p_titulo);
    this.agregarCargo(p_cargo);
  }

  /**
   * Constructor para crear un objeto Profesor con un título, DNI, nombre,
   * apellido, año de nacimiento y un cargo inicial.
   *
   * @param p_titulo          Título del profesor (String).
   * @param p_dni             DNI del profesor (int).
   * @param p_nombre          Nombre del profesor (String).
   * @param p_apellido        Apellido del profesor (String).
   * @param p_fechaNacimiento Fecha de nacimiento del profesor (Calendar).
   * @param p_cargo           Cargo inicial asignado al profesor (Cargo).
   */
  public Profesor(String p_titulo, int p_dni, String p_nombre, String p_apellido, Calendar p_fechaNacimiento,
      Cargo p_cargo) {
    super(p_dni, p_nombre, p_apellido, p_fechaNacimiento);
    this.setTitulo(p_titulo);
    this.agregarCargo(p_cargo);
  }

  /**
   * Establece el título del profesor.
   *
   * @param p_titulo Título a asignar al profesor.
   */
  private void setTitulo(String p_titulo) {
    this.titulo = p_titulo;
  }

  /**
   * Obtiene el título del profesor.
   *
   * @return El título del profesor (String).
   */
  public String getTitulo() {
    return this.titulo;
  }

  /**
   * Obtiene la lista de cargos asignados al profesor.
   *
   * @return La lista de cargos asignados al profesor como un ArrayList
   *         (ArrayList<Cargo>).
   */
  public ArrayList<Cargo> getCargos() {
    return this.cargos;
  }

  /**
   * Agrega un cargo al profesor, siempre y cuando no tenga tres cargos
   * asignados.
   *
   * @param p_cargo Cargo a agregar al profesor de tipo Cargo.
   * @return true si el cargo se agregó con éxito, false si no se pudo agregar
   *         debido a la restricción de tres cargos (boolean).
   */
  public boolean agregarCargo(Cargo p_cargo) {
    if (this.getCargos().size() == 3) {
      System.out.println("El profesor ya tiene tres cargos asignados, no se puede agregar más.");
      return false;
    }
    return this.getCargos().add(p_cargo);
  }

  /**
   * Muestra los detalles del profesor, incluyendo su información personal,
   * título, lista de cargos asignados y sueldo total.
   */
  @Override
  public void mostrar() {
    super.mostrar();
    System.out.format("Titulo: %s\n", this.getTitulo());
    this.listarCargos();
    System.out.format("** Sueldo Total: %s **\n", this.sueldoTotal());
  }

  /**
   * Lista y muestra los detalles de los cargos asignados al profesor.
   */
  public void listarCargos() {
    System.out.println("-***** Cargos Asignados *****-");
    System.out.println("---------------------------------------");
    for (Cargo cargo : this.getCargos()) {
      cargo.mostrarCargo();
      System.out.println();
    }
  }

  /**
   * Calcula y devuelve el sueldo total del profesor, que es la suma de los
   * sueldos de todos los cargos asignados.
   *
   * @return El sueldo total del profesor (double).
   */
  public double sueldoTotal() {
    double sueldoTotal = 0;
    for (Cargo cargo : this.getCargos()) {
      sueldoTotal += cargo.sueldoDelCargo();
    }
    return sueldoTotal;
  }

  /**
   * Genera una línea de texto que muestra el DNI, nombre y sueldo total del
   * profesor.
   *
   * @return Una cadena de texto que representa una línea con la información del
   *         profesor (String).
   */
  public String mostrarLinea() {
    return String.format("DNI: %s - Nombre: %s - Sueldo Total: %s", super.getDni(), super.nomYApe(),
        this.sueldoTotal());
  }
}