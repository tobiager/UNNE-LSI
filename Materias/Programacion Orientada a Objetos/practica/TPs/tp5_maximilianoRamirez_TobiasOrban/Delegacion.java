import java.util.ArrayList;
import java.util.Calendar;

/**
 * Representa una delegación que visita el zoológico.
 */
public class Delegacion extends Visitante {
    private ArrayList<Individuo> integrantes;

    /**
     * Constructor de la clase Delegación.
     *
     * @param p_nombre      El nombre de la delegación.
     * @param p_fechaVisita La fecha de la visita.
     * @param p_integrante  El primer integrante de la delegación.
     */
    public Delegacion(String p_nombre, Calendar p_fechaVisita, Individuo p_integrante) {
        super(p_nombre, p_fechaVisita);
        this.setIntegrantes(new ArrayList<>());
        this.inscribirIndividuo(p_integrante);
    }
    
    /**
     * Constructor de la clase Delegación que permite crear una delegación con una lista vacía de integrantes.
     *
     * @param p_nombre      El nombre de la delegación.
     * @param p_fechaVisita La fecha de la visita.
     * @param p_integrantes Lista de integrantes que pertenece a la delegación.
     */
     public Delegacion(String p_nombre, Calendar p_fechaVisita, ArrayList<Individuo> p_integrantes) {
        super(p_nombre, p_fechaVisita);
        this.setIntegrantes(p_integrantes);
    }

    /**
     * Establece la lista de integrantes de la delegación.
     *
     * @param p_integrantes La lista de integrantes.
     */
    private void setIntegrantes(ArrayList<Individuo> p_integrantes) {
        this.integrantes = p_integrantes;
    }

    /**
     * Obtiene la lista de integrantes de la delegación.
     *
     * @return La lista de integrantes.
     */
    public ArrayList<Individuo> getIntegrantes() {
        return this.integrantes;
    }

    /**
     * Calcula el costo de la entrada de la delegación con un descuento del 10%.
     *
     * @return El costo total de la entrada.
     */
    @Override
    public double entrada() {
        double entradaCosto = this.cantidadDeIntegrantes() * 10;
        return entradaCosto -= entradaCosto * 0.10;
    }

    /**
     * Agrega un individuo a la delegación.
     *
     * @param p_individuo El individuo a agregar.
     */
    public void inscribirIndividuo(Individuo p_individuo) {
        this.getIntegrantes().add(p_individuo);
    }

    /**
     * Elimina un individuo de la delegación.
     *
     * @param p_individuo El individuo a eliminar.
     */
    public void eliminarIndividuo(Individuo p_individuo) {
        if (this.cantidadDeIntegrantes() > 1) {
            this.getIntegrantes().remove(p_individuo);
        } else {
            System.out.println("No se puede eliminar, debe quedar al menos un individuo.");
        }
    }

    /**
     * Obtiene la cantidad de integrantes de la delegación.
     *
     * @return La cantidad de integrantes.
     */
    public int cantidadDeIntegrantes() {
        return this.getIntegrantes().size();
    }

    /**
     * Muestra la información de la delegación y sus integrantes.
     */
    @Override
    public void mostrar() {
        System.out.format("Delegación: %s\n", this.getNombre());
        System.out.println("Integrantes:");
        for (Individuo integrante : this.getIntegrantes()) {
            integrante.mostrar();
        }
        System.out.format("Cantidad de Integrantes: %d\n", this.cantidadDeIntegrantes());
    }

    /**
     * Lista los visitantes por fecha.
     *
     * @param p_fecha     La fecha de la visita.
     * @param p_visitante El tipo de visitante.
     */
    @Override
    public void listarPorFecha(Calendar p_fecha, String p_visitante) {
        if (this.getFechaVisita().equals(p_fecha) && p_visitante.equals(this.tipoVisitante())) {
            this.mostrar();
        }
    }

    /**
     * Devuelve el tipo de visitante.
     *
     * @return "Delegación".
     */
    @Override
    public String tipoVisitante() {
        return "Delegación";
    }
}
