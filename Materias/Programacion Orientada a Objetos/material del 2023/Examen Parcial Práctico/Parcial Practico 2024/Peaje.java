
import java.util.ArrayList;
import java.util.List;

public class Peaje {
    private String nombrePeaje;
    private ArrayList<Caja> cajas;

    public Peaje(String nombrePeaje) {
        this.nombrePeaje = nombrePeaje;
        this.cajas = new ArrayList<>();
    }

    public void agregarCaja(Caja caja) {
        cajas.add(caja);
    }

    public double totalRecaudado() {
        double total = 0;
        for (Caja caja : cajas) {
            total += caja.recaudacion();
        }
        return total;
    }

    public void informeTurno() {
        System.out.println("Peaje: " + nombrePeaje);
        System.out.println("------------------------------------------");
        System.out.println("Total recaudado: $" + totalRecaudado());
        System.out.println("------------------------------------------");

        for (Caja caja : cajas) {
            caja.cerrarCaja();
        }
    }
}




