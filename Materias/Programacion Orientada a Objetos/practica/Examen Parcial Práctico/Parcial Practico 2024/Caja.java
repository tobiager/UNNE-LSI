import java.util.ArrayList;

public class Caja {
    private int nroCaja;
    private Cajero cajero;
    private ArrayList<Ticket> tickets;

    public Caja(int nroCaja,Cajero cajero) {
        this.nroCaja = nroCaja;
        this.cajero = cajero;
        this.tickets = new ArrayList<>();
    }

    public boolean agregarTicket(Ticket p_ticket) {
        return tickets.add(p_ticket);
    }
    
    public boolean quitarTicket(Ticket p_ticket) {
        boolean seQuito= false;
                if(tickets.size() > 1){
                    tickets.remove(p_ticket);
                    seQuito = true;
                }
        return seQuito;
    }

    public double recaudacion() {
        double total = 0;
        for (Ticket ticket : tickets) {
            total += ticket.calculaPeaje();
        }
        return total;
    }

    public String contarPorCategoria() {
        int totalOficial = 0;
        int totalParticular = 0;

        for (Ticket ticket : tickets) {
            if (ticket.getCategoria() instanceof Oficial) {
                totalOficial++;
            } else  {
                totalParticular++;
            }
        }

        return "Vehículos oficiales: " + totalOficial + " Vehículos particulares: " + totalParticular;
    }

    public String contarPorTurno() {
        int totalDiurno = 0;
        int totalNocturno = 0;

        for (Ticket ticket : tickets) {
            if (ticket.getTurno().equals("Diurno")) {
                totalDiurno++;
            } else if (ticket.getTurno().equals("Nocturno")) {
                totalNocturno++;
            }
        }

        return "Vehículos turno diurno: " + totalDiurno + " Vehículos turno nocturno: " + totalNocturno;
    }

    public void cerrarCaja() {
        System.out.println("Caja " + nroCaja + " :");
        System.out.println("Recaudación: $" + recaudacion());
        System.out.println(cajero.toString());
        System.out.println(contarPorCategoria());
        System.out.println(contarPorTurno());
        System.out.println("------------------------------------------");
    }
}
