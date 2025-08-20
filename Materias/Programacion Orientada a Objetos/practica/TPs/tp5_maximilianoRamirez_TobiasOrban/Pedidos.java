import java.util.ArrayList;

/**
 * La clase Pedidos representa un conjunto de renglones (tickets)
 * que conforman un pedido.
 */
public class Pedidos {
    private ArrayList<Renglon> tickets = new ArrayList<>();

    /**
     * Constructor para crear un pedido con una lista de renglones
     * y opcionalmente agregar un renglón adicional.
     * 
     * @param p_tickets La lista de renglones inicial.
     * @param p_ticket Un renglón adicional a agregar al pedido.
     */
    public Pedidos(ArrayList<Renglon> p_tickets, Renglon p_ticket) {
        this.setTickets(p_tickets);
        if (p_ticket != null) {
            this.agregarTicket(p_ticket);
        }
    }

    /**
     * Establece la lista de renglones del pedido.
     * 
     * @param p_tickets La lista de renglones a establecer.
     */
    public void setTickets(ArrayList<Renglon> p_tickets) {
        this.tickets = p_tickets;
    }

    /**
     * Obtiene la lista de renglones del pedido.
     * 
     * @return La lista de renglones.
     */
    public ArrayList<Renglon> getTickets() {
        return this.tickets;
    }

    /**
     * Agrega un renglón al pedido.
     * 
     * @param p_ticket El renglón a agregar.
     * @return true si el renglón fue agregado exitosamente.
     */
    public boolean agregarTicket(Renglon p_ticket) {
        return this.getTickets().add(p_ticket);
    }

    /**
     * Elimina un renglón del pedido. (Nota: el método contiene un error
     * y debería usar `remove` en lugar de `add`).
     * 
     * @param p_ticket El renglón a eliminar.
     * @return true si el renglón fue eliminado exitosamente.
     */
    public boolean quitarTicket(Renglon p_ticket) {
        return this.getTickets().remove(p_ticket); // Corrige `add` a `remove`
    }

    /**
     * Cuenta la cantidad de renglones en el pedido.
     * 
     * @return La cantidad total de renglones.
     */
    public int cantidadItems() {
        return this.getTickets().size();
    }

    /**
     * Calcula el total del pedido sumando los precios de todos los renglones.
     * 
     * @return El importe total del pedido.
     */
    public double totalPedido() {
        double total = 0;
        for (Renglon ticket : this.getTickets()) {
            total += ticket.getPrecio();
        }
        return total;
    }

    /**
     * Muestra los detalles del pedido, incluyendo la cantidad de items,
     * y el precio de cada uno.
     */
    public void mostrar() {
        int i = 1;
        System.out.println("Pedido:");
        System.out.println("Cantidad de items: " + this.getTickets().size());
        for (Renglon ticket : this.getTickets()) {
            System.out.println("Item: " + i);
            ticket.mostrar();
            System.out.println("Precio: $" + ticket.getPrecio());
            i++;
        }
        System.out.println("--- Total pedido: " + this.cantidadItems() + " Etiquetas por un importe total de: $" + this.totalPedido());
    }
}

