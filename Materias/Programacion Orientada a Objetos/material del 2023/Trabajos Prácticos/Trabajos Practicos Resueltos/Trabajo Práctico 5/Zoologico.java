import java.util.ArrayList;
import java.util.Calendar;

public class Zoologico {
  private String nombre;
  private ArrayList<Visitante> visitantes;

  /**
   * @param p_nombre El nombre del zoologico (String).
   */
  public Zoologico(String p_nombre) {
    this.setNombre(p_nombre);
    this.setVisitantes(new ArrayList<Visitante>());
  }

  /**
   * @param p_nombre     El nombre del zoologico (String).
   * @param p_visitantes Una lista de visitantes (ArrayList<Visitante>)
   */
  public Zoologico(String p_nombre, ArrayList<Visitante> p_visitantes) {
    this.setNombre(p_nombre);
    this.setVisitantes(p_visitantes);
  }

  /**
   * Establece el nombre del zoologico.
   *
   * @param p_nombre El nombre del zoologico (String).
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Establece la lista de visitantes.
   * 
   * @param p_visitantes Una lista de visitantes (ArrayList<Visitante>).
   */
  private void setVisitantes(ArrayList<Visitante> p_visitantes) {
    this.visitantes = p_visitantes;
  }

  /**
   * Obtiene el nombre del zoologico.
   *
   * @return El nombre del zoologico (String).
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Obtiene una lista de visitantes.
   * 
   * @return Una lista de visitantes (ArrayList<Visitantes>).
   */
  public ArrayList<Visitante> getVisitantes() {
    return this.visitantes;
  }

  /**
   * Agrega un visitante a la lista.
   *
   * @param p_visitante El visitante que se va agregar (Visitante).
   */
  public void nuevoVisitante(Visitante p_visitante) {
    this.getVisitantes().add(p_visitante);
  }

  /**
   * Quita un visitante a la lista.
   *
   * @param p_visitante El visitante que se va quitar (Visitante).
   */
  public void quitarVisitante(Visitante p_visitante) {
    this.getVisitantes().remove(p_visitante);
  }

  /**
   * Lista los visitantes que asistieron en determinada fecha y sea de un tipo de
   * visitante
   * 
   * @param p_fecha         La fecha a buscar quienes asistieron (Calendar).
   * @param p_tipoVisitante El tipo de visitante (String).
   */
  public void listaTipoVisitantePorFecha(Calendar p_fecha, String p_tipoVisitante) {
    for (Visitante visitante : this.getVisitantes()) {
      if (visitante.tipoVisitante() == p_tipoVisitante && visitante.getFechaVisita().equals(p_fecha)) {
        visitante.mostrar();
      }
    }
  }

  /**
   * Lista los visitantes que asistieron en determinada fecha.
   * 
   * @param p_fecha La fecha a buscar todos los que asistieron (Calendar).
   */
  public void listaVisitantePorFecha(Calendar p_fecha) {
    System.out.format("Visitantes que asistierón en la fecha %s/%s/%s\n", p_fecha.get(Calendar.DAY_OF_MONTH),
        p_fecha.get(Calendar.MONTH) + 1, p_fecha.get(Calendar.YEAR));
    for (Visitante visitante : this.getVisitantes()) {
      visitante.listarPorFecha(p_fecha, visitante.tipoVisitante());
    }
  }

  /**
   * @param p_fechaDesde La fecha desde cuando se buscará quienes asistieron al
   *                     zoologico (Calendar).
   * @param p_fechaHasta La fecha hasta cuando se buscará quienes asistieron al
   *                     zoologico (Calendar).
   * @return La recaudación desde una fecha hasta una fecha especificadas
   *         (double).
   */
  public double recaudacion(Calendar p_fechaDesde, Calendar p_fechaHasta) {
    double recaudacion = 0;
    for (Visitante visitante : this.getVisitantes()) {
      int posteriorFecha = visitante.getFechaVisita().compareTo(p_fechaDesde);
      int anteriorFecha = visitante.getFechaVisita().compareTo(p_fechaHasta);
      if (posteriorFecha >= 0 && anteriorFecha <= 0) {
        if (visitante.getClass().getName() == "Delegacion") {
          Delegacion Delegacion = (Delegacion) visitante;
          recaudacion += Delegacion.entrada();
        } else {
          recaudacion += visitante.entrada();
        }
      }
    }
    return recaudacion;
  }
}