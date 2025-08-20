import java.util.Calendar;

/**
 * Clase abstracta que representa a un visitante del zoológico.
 */
public abstract class Visitante {
    private String nombre;
    private Calendar fechaVisita;

    public abstract void mostrar();

    public abstract double entrada();

    public abstract void listarPorFecha(Calendar p_fecha, String p_visitante);

    public abstract String tipoVisitante();

    /**
     * Constructor de la clase Visitante.
     *
     * @param p_nombre      El nombre del visitante.
     * @param p_fechaVisita La fecha de la visita.
     */
    public Visitante(String p_nombre, Calendar p_fechaVisita) {
        this.setNombre(p_nombre);
        this.setFechaVisita(p_fechaVisita);
    }

    /**
     * Establece el nombre del visitante.
     *
     * @param p_nombre El nombre del visitante.
     */
    private void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Establece la fecha de visita.
     *
     * @param p_fechaVisita La fecha de visita.
     */
    private void setFechaVisita(Calendar p_fechaVisita) {
        this.fechaVisita = p_fechaVisita;
    }

    /**
     * Obtiene el nombre del visitante.
     *
     * @return El nombre del visitante.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Obtiene la fecha de visita.
     *
     * @return La fecha de visita.
     */
    public Calendar getFechaVisita() {
        return this.fechaVisita;
    }
}
