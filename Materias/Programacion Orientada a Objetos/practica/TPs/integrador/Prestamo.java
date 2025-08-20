import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * Clase que representa un préstamo de libro realizado por un socio.
 * Esta clase gestiona la fecha de retiro, la fecha de devolución, el socio que realiza el préstamo 
 * y el libro que es prestado.
 * 
 * @author MAXI
 */
public class Prestamo {

    private Calendar fechaRetiro;
    private Calendar fechaDevolucion;
    private Socio socio;
    private Libro libro;

    /**
     * Constructor que inicializa un préstamo con una fecha de retiro, fecha de devolución, 
     * el socio que realiza el préstamo y el libro prestado.
     * 
     * @param p_fechaRetiro la fecha en que el socio retira el libro
     * @param p_fechaDevolucion la fecha en que el libro debe ser devuelto
     * @param p_socio el socio que realiza el préstamo
     * @param p_libro el libro que es prestado
     */
    public Prestamo(Calendar p_fechaRetiro, Calendar p_fechaDevolucion, Socio p_socio, Libro p_libro) {
        this.setFechaRetiro(p_fechaRetiro);
        this.registrarFechaDevolucion(p_fechaDevolucion);
        this.setSocio(p_socio);
        this.setLibro(p_libro);
    }

    /**
     * Constructor que inicializa un préstamo con una fecha de retiro, sin una fecha de devolución 
     * inicializada (por ejemplo, si el libro aún no ha sido devuelto), 
     * junto con el socio y el libro prestado.
     * 
     * @param p_fechaRetiro la fecha en que el socio retira el libro
     * @param p_socio el socio que realiza el préstamo
     * @param p_libro el libro que es prestado
     */
    public Prestamo(Calendar p_fechaRetiro, Socio p_socio, Libro p_libro) {
        this.setFechaRetiro(p_fechaRetiro);
        this.registrarFechaDevolucion(null);
        this.setSocio(p_socio);
        this.setLibro(p_libro);
    }

    // Setters

    /**
     * Establece la fecha de retiro del préstamo.
     * 
     * @param p_fechaRetiro la fecha en que el socio retira el libro
     */
    public void setFechaRetiro(Calendar p_fechaRetiro) {
        this.fechaRetiro = p_fechaRetiro;
    }

    /**
     * Establece la fecha de devolución del préstamo.
     * 
     * @param p_fechaDevolucion la fecha en que el libro debe ser devuelto
     */
    public void setFechaDevolucion(Calendar p_fechaDevolucion) {
        this.fechaDevolucion = p_fechaDevolucion;
    }

    /**
     * Establece el socio que realiza el préstamo.
     * 
     * @param p_socio el socio que realiza el préstamo
     */
    public void setSocio(Socio p_socio) {
        this.socio = p_socio;
    }

    /**
     * Establece el libro que es prestado.
     * 
     * @param p_libro el libro que es prestado
     */
    public void setLibro(Libro p_libro) {
        this.libro = p_libro;
    }

    // Getters

    /**
     * Obtiene la fecha de retiro del préstamo.
     * 
     * @return la fecha de retiro del préstamo
     */
    public Calendar getFechaRetiro() {
        return this.fechaRetiro;
    }

    /**
     * Obtiene la fecha de devolución del préstamo.
     * 
     * @return la fecha de devolución del préstamo
     */
    public Calendar getFechaDevolucion() {
        return this.fechaDevolucion;
    }

    /**
     * Obtiene el socio que realizó el préstamo.
     * 
     * @return el socio que realizó el préstamo
     */
    public Socio getSocio() {
        return this.socio;
    }

    /**
     * Obtiene el libro que ha sido prestado.
     * 
     * @return el libro que ha sido prestado
     */
    public Libro getLibro() {
        return this.libro;
    }

    // Métodos

    /**
     * Registra la fecha de devolución del préstamo. Si la fecha de devolución es nula, 
     * el libro aún no ha sido devuelto.
     * 
     * @param p_fecha la fecha en que el libro debe ser devuelto
     */
    public void registrarFechaDevolucion(Calendar p_fecha) {
        this.setFechaDevolucion(p_fecha);
    }

    /**
     * Verifica si el préstamo ha vencido comparando la fecha actual con la fecha límite 
     * de devolución calculada a partir de la fecha de retiro y los días de préstamo del socio.
     * 
     * @param p_fecha la fecha actual que se va a comparar con la fecha límite de devolución
     * @return verdadero si el préstamo está vencido, falso en caso contrario
     */
    public boolean vencido(Calendar p_fecha) {
        if (p_fecha == null) {
            return false;
        }
        Calendar fechaLimite = (Calendar) this.getFechaRetiro().clone();
        fechaLimite.add(Calendar.DAY_OF_YEAR, this.getSocio().getDiasPrestamos());
        return p_fecha.after(fechaLimite);
    }

    /**
     * Devuelve una representación en cadena del préstamo, incluyendo las fechas de retiro y devolución,
     * el título del libro y el nombre del socio que realizó el préstamo.
     * 
     * @return una cadena con la información del préstamo
     */
    public String toString() {
        return "Retiro: " + this.getFechaRetiro().getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault()) + " - Devolucion: " + this.getFechaDevolucion().getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault()) +
               "\nLibro: " + this.getLibro().getTitulo() + "\nSocio: " + this.getSocio().getNombre();
    }
}

