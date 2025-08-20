import java.util.ArrayList;
import java.util.Calendar;

public class Delegacion extends Visitante {
  private ArrayList<Individuo> integrantes;

  /**
   * Constructor de la clase Delegación.
   * 
   * @param p_nombre      El nombre de la delegación (String).
   * @param p_fechaVisita La fecha en la que visita (Calendar).
   * @param p_integrante  El primer integrante que va pertenecer a la delegación
   *                      (Individuo).
   */
  public Delegacion(String p_nombre, Calendar p_fechaVisita, Individuo p_integrante) {
    super(p_nombre, p_fechaVisita);
    this.setIntegrantes(new ArrayList<Individuo>());
    this.inscribirIndividuo(p_integrante);
  }

  /**
   * Constructor de la clase Delegación.
   * 
   * @param p_nombre      El nombre de la delegación (String).
   * @param p_fechaVisita La fecha en la que visita (Calendar).
   * @param p_integrante  Una Lista de integrantes que va pertenecer a la
   *                      delegación
   *                      (ArrayList<Individuo>).
   */
  public Delegacion(String p_nombre, Calendar p_fechaVisita, ArrayList<Individuo> p_integrantes) {
    super(p_nombre, p_fechaVisita);
    this.setIntegrantes(p_integrantes);
  }

  /**
   * Establece una lista de integrantes.
   * 
   * @param p_integrantes Una lista de integrantes (ArrayList<Individuo>).
   */
  private void setIntegrantes(ArrayList<Individuo> p_integrantes) {
    this.integrantes = p_integrantes;
  }

  /**
   * Obtiene la lista de integrantes.
   *
   * @return La lista de integrantes (ArrayList<Individuo>).
   */
  public ArrayList<Individuo> getIntegrantes() {
    return this.integrantes;
  }

  /**
   * @return El costo de la entrada de cada integrante con un descuento del 10%.
   */
  @Override
  public double entrada() {
    double entradaCosto = this.cantidadDeIntegrantes() * 10;
    return entradaCosto -= entradaCosto * 0.10;
  }

  /**
   * Agrega un integrante a la delegación.
   *
   * @param p_individuo El integrante que se agregará (Individuo).
   */
  public void inscribirIndividuo(Individuo p_individuo) {
    this.getIntegrantes().add(p_individuo);
  }

  /**
   * Quita un integrante a la delegación.
   *
   * @param p_individuo El integrante que se quitará (Individuo).
   */
  public void eliminarIndividuo(Individuo p_individuo) {
    if (this.cantidadDeIntegrantes() == 1) {
      System.out.println("No se puede eliminar, porque tiene que quedar un Individuo.");
    }
    this.getIntegrantes().remove(p_individuo);
  }

  /**
   * @return La cantidad de integrantes de la delegación (int).
   */
  public int cantidadDeIntegrantes() {
    return this.getIntegrantes().size();
  }

  /**
   * Imprime el nombre de la delegación, una lista de los
   * integrantes y la cantidad de integrantes.
   */
  @Override
  public void mostrar() {
    System.out.format("Delegacion: %s\n", this.getNombre());
    System.out.println("Integrantes");
    for (Individuo integrante : this.getIntegrantes()) {
      integrante.mostrar();
    }
    System.out.format("Cantidad de Integrantes: %s\n\n", this.cantidadDeIntegrantes());
  }

  /**
   * @param p_fecha     La fecha del dia que se quiere saber quienes asistieron
   *                    (Calendar).
   * @param p_visitante El tipo de visitante a consultar.
   */
  @Override
  public void listarPorFecha(Calendar p_fecha, String p_visitante) {
    if (this.getFechaVisita().equals(p_fecha) && p_visitante == this.tipoVisitante()) {
      this.mostrar();
    }
  }

  /**
   * @return Un String del nombre del tipo visitante "Delegación" (String).
   */
  @Override
  public String tipoVisitante() {
    return "Delegación";
  }
}