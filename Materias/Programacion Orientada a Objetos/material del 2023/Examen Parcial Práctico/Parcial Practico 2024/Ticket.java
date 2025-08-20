
import java.util.Calendar;

public class Ticket {
    private String turno;
    private String patente;
    private Calendar fecha;
    private Categoria categoria;
    
    public String getTurno() {
        return this.turno;
    }

    private void setTurno(String p_turno) {
        this.turno = p_turno;
    }
    
    public String getPatente() {
        return this.patente;
    }

    private void setPatente(String p_patente) {
        this.patente = p_patente;
    }
    
    public Categoria getCategoria() {
        return this.categoria;
    }

    private void setCategoria(Categoria p_categoria) {
        this.categoria = p_categoria;
    }
    
    public Ticket(String p_turno, String p_patente, Calendar fecha, Categoria p_categoria) {
        this.setTurno(p_turno);
        this.setPatente(p_patente);
        this.fecha = fecha;
        this.setCategoria(p_categoria);
    }

    public double calculaPeaje() {
        return categoria.costoTotal(turno);
    }

    public void imprimirTicket() {
    System.out.println("Ticket");
    System.out.println("------------------------------------------");
    System.out.println("Fecha: " + fecha.get(Calendar.YEAR) + "/" + (fecha.get(Calendar.MONTH) + 1) + "/" + fecha.get(Calendar.DAY_OF_MONTH));
    System.out.println("Categoria: " + categoria.leyendaCategoria());
    System.out.println("Patente: " + patente + " - Turno: " + turno);
    System.out.println("Total: " + calculaPeaje());
    System.out.println("------------------------------------------");
    }

}



