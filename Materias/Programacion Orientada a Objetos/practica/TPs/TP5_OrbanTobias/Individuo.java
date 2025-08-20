import java.util.Calendar;

/**
 * Representa a un individuo que visita el zoológico.
 */
public class Individuo extends Visitante {
    private Persona persona;

    /**
     * Constructor de la clase Individuo.
     *
     * @param p_persona     La persona que visita el zoológico.
     * @param p_fechaVisita La fecha de la visita.
     */
    public Individuo(Persona p_persona, Calendar p_fechaVisita) {
        super(p_persona.apeYNom(), p_fechaVisita);
        this.setPersona(p_persona);
    }

    /**
     * Establece la persona que visita el zoológico.
     *
     * @param p_persona La persona que visita el zoológico.
     */
    public void setPersona(Persona p_persona) {
        this.persona = p_persona;
    }

    /**
     * Obtiene la persona que visita el zoológico.
     *
     * @return La persona que visita el zoológico.
     */
    public Persona getPersona() {
        return this.persona;
    }

    /**
     * Calcula el costo de la entrada del individuo.
     *
     * @return El costo de la entrada.
     */
    @Override
    public double entrada() {
        return 10;
    }

    /**
     * Muestra la información del individuo.
     */
    @Override
    public void mostrar() {
        this.getPersona().mostrar();
    }

    /**
     * Lista los visitantes por fecha.
     *
     * @param p_fecha     La fecha de la visita.
     * @param p_visitante El tipo de visitante.
     */
    @Override
    public void listarPorFecha(Calendar p_fecha, String p_visitante) {
        if (super.getFechaVisita().equals(p_fecha) && p_visitante.equals(this.tipoVisitante())) {
            this.mostrar();
        }
    }

    /**
     * Devuelve el tipo de visitante.
     *
     * @return "Individuo".
     */
    @Override
    public String tipoVisitante() {
        return "Individuo";
    }
}
