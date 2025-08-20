
public class Cajero {
    private String usuarioCajero;
    private String nombre;
    

    public Cajero(String usuarioCajero, String nombre) {
        this.usuarioCajero = usuarioCajero;
        this.nombre = nombre;
    }

    @Override
    public String toString() {
        return "Cajero: " + nombre + " (Usuario: " + usuarioCajero + ")";
    }
}


