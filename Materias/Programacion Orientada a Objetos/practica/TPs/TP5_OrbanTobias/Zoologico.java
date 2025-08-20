import java.util.ArrayList;
import java.util.Calendar;

/**
 * Representa un zoológico que administra los visitantes.
 */
public class Zoologico {
    private String nombre;
    private ArrayList<Visitante> visitantes;

    /**
     * Constructor que inicializa el nombre del zoológico y la lista de visitantes.
     *
     * @param p_nombre El nombre del zoológico.
     */
    public Zoologico(String p_nombre) {
        this.setNombre(p_nombre);
        this.setVisitantes(new ArrayList<>());
    }

    /**
     * Establece el nombre del zoológico.
     *
     * @param p_nombre El nombre del zoológico.
     */
    private void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Establece la lista de visitantes.
     *
     * @param p_visitantes La lista de visitantes.
     */
    private void setVisitantes(ArrayList<Visitante> p_visitantes) {
        this.visitantes = p_visitantes;
    }

    /**
     * Obtiene el nombre del zoológico.
     *
     * @return El nombre del zoológico.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Obtiene la lista de visitantes.
     *
     * @return La lista de visitantes.
     */
    public ArrayList<Visitante> getVisitantes() {
        return this.visitantes;
    }

    /**
     * Agrega un nuevo visitante a la lista.
     *
     * @param p_visitante El visitante a agregar.
     */
    public void nuevoVisitante(Visitante p_visitante) {
        this.visitantes.add(p_visitante);
    }

    /**
     * Elimina un visitante de la lista.
     *
     * @param p_visitante El visitante a eliminar.
     */
    public void quitarVisitante(Visitante p_visitante) {
        this.visitantes.remove(p_visitante);
    }

    /**
     * Lista los visitantes de un tipo específico que asistieron en una fecha determinada.
     *
     * @param p_fecha         La fecha de la visita.
     * @param p_tipoVisitante El tipo de visitante ("Individuo" o "Delegación").
     */
    public void listaTipoVisitantePorFecha(Calendar p_fecha, String p_tipoVisitante) {
        for (Visitante visitante : this.getVisitantes()) {
            if (visitante.tipoVisitante().equals(p_tipoVisitante) && visitante.getFechaVisita().equals(p_fecha)) {
                visitante.mostrar();
            }
        }
    }

    /**
     * Muestra todos los visitantes que asistieron en una fecha determinada.
     *
     * @param p_fecha La fecha de la visita.
     */
    public void listaVisitantePorFecha(Calendar p_fecha) {
        System.out.format("Visitantes que asistieron el %d/%d/%d:\n",
                p_fecha.get(Calendar.DAY_OF_MONTH), p_fecha.get(Calendar.MONTH) + 1, p_fecha.get(Calendar.YEAR));
        for (Visitante visitante : this.getVisitantes()) {
            visitante.listarPorFecha(p_fecha, visitante.tipoVisitante());
        }
    }

    /**
     * Calcula la recaudación total entre dos fechas especificadas.
     *
     * @param p_fechaDesde La fecha de inicio del rango.
     * @param p_fechaHasta La fecha de fin del rango.
     * @return La recaudación total entre las dos fechas.
     */
    public double recaudacion(Calendar p_fechaDesde, Calendar p_fechaHasta) {
        double recaudacion = 0;
        for (Visitante visitante : this.getVisitantes()) {
            if ((visitante.getFechaVisita().compareTo(p_fechaDesde) >= 0) &&
                (visitante.getFechaVisita().compareTo(p_fechaHasta) <= 0)) {
                recaudacion += visitante.entrada();
            }
        }
        return recaudacion;
    }
}
