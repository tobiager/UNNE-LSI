import java.util.Calendar;

public class Individuo extends Visitante {
  private Persona persona;

  public Individuo(Persona p_persona, Calendar p_fechaVisita) {
    super(p_persona.apeYNom(), p_fechaVisita);
    this.setPersona(p_persona);
  }

  /**
   * Establece un integrante.
   * 
   * @param p_persona Una persona que visita el zoologico (Persona).
   */
  public void setPersona(Persona p_persona) {
    this.persona = p_persona;
  }

  /**
   * Obtiene la persona que asistio al zoologico.
   * 
   * @return La persona que asistió al zoologico (Persona).
   */
  public Persona getPersona() {
    return this.persona;
  }

  /**
   * @return El costo de la entrada de la persona que asistio al zoologico
   *         (double).
   */
  @Override
  public double entrada() {
    return 10;
  }

  /**
   * Imprime por pantalla los datos de la persona que asistio al zoologico.
   */
  @Override
  public void mostrar() {
    this.getPersona().mostrar();
  }

  /**
   * @param p_fecha     La fecha del dia que se quiere saber quienes asistieron
   *                    (Calendar).
   * @param p_visitante El tipo de visitante a consultar.
   */
  @Override
  public void listarPorFecha(Calendar p_fecha, String p_visitante) {
    if (super.getFechaVisita().equals(p_fecha) && p_visitante == this.tipoVisitante()) {
      this.mostrar();
    }
  }

  /**
   * @return Un String del nombre del tipo visitante "Individuo" (String).
   */
  @Override
  public String tipoVisitante() {
    return "Individuo";
  }
}
