import java.util.ArrayList;

public class Pedido {
    private ArrayList<Renglon> tickets;

    // Constructor
    public Pedido() {
        this.tickets = new ArrayList<>();
    }

    // Método para agregar renglones al pedido
    public boolean agregarRenglon(Renglon p_renglon) {
        return tickets.add(p_renglon);
    }
    
    
    public double totalPedido() {
        double total = 0;
        for (Renglon ticket : tickets) {
            total += ticket.importe;
        }
        return total;
    }
    // Mostrar el pedido completo
    public void mostrar() {
        int totalCantidad = 0;
        double totalImporte = 0;
        int itemCount = 1; // Contador de ítems

        System.out.println("Pedido:");
        System.out.println("Cantidad de items: " + tickets.size());

        for (Renglon ticket : tickets) {
            System.out.print("Item " + itemCount + ": ");
            ticket.mostrar();
            totalCantidad += ticket.getCantidad();
            itemCount++;
        }

        System.out.println("--- Total pedido: " + totalCantidad + " Etiquetas por un importe total de: $" + totalPedido());
    }
}

