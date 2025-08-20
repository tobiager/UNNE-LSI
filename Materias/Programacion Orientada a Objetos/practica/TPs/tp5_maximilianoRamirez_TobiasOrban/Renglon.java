
/**
 * Write a description of class Renglon here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase Renglon representa un renglón en una factura o un
 * ticket, que incluye la cantidad de etiquetas y el importe total.
 */
public class Renglon {
    private int cantidad;
    private double importe;
    private Etiquetas ticket;

    /**
     * Constructor para crear un renglón con una cantidad y un ticket.
     * 
     * @param p_cantidad La cantidad de etiquetas en el renglón.
     * @param p_ticket La etiqueta asociada a este renglón.
     */
    public Renglon(int p_cantidad, Etiquetas p_ticket) {
        this.setTicket(p_ticket);
        this.setCantidad(p_cantidad);
        this.getPrecio(); // Calcula el importe al inicializar
    }

    /**
     * Establece la cantidad de etiquetas en el renglón.
     * 
     * @param p_cantidad La cantidad a establecer.
     */
    public void setCantidad(int p_cantidad) {
        this.cantidad = p_cantidad;
    }

    /**
     * Obtiene la cantidad de etiquetas en el renglón.
     * 
     * @return La cantidad de etiquetas.
     */
    public int getCantidad() {
        return this.cantidad;
    }

    /**
     * Establece la etiqueta asociada a este renglón.
     * 
     * @param p_ticket La etiqueta a establecer.
     */
    public void setTicket(Etiquetas p_ticket) {
        this.ticket = p_ticket;
    }

    /**
     * Calcula y obtiene el precio total del renglón.
     * 
     * @return El importe total del renglón.
     */
    public double getPrecio() {
        this.importe = getTicket().precio(this.getCantidad());
        return importe;
    }

    /**
     * Obtiene la etiqueta asociada a este renglón.
     * 
     * @return La etiqueta del renglón.
     */
    public Etiquetas getTicket() {
        return this.ticket;
    }

    /**
     * Muestra la información del renglón, incluyendo la cantidad
     * y los detalles de la etiqueta.
     */
    public void mostrar() {
        System.out.println(this.getCantidad() + " Etiquetas del " + this.getTicket().toString());
    }
}

