import java.util.Calendar;

public class Estudiante extends Socio {
    private String carrera;

    public Estudiante(int p_dniSocio, String p_nombre, String p_carrera) {
        super(p_dniSocio, p_nombre, 0);
        this.setCarrera(p_carrera);
    }

    private void setCarrera(String p_carrera) {
        this.carrera = p_carrera;
    }

    public String getCarrera() {
        return this.carrera;
    }

    public boolean puedePedir() {
        Calendar p_fecha = Calendar.getInstance();
        for (Prestamo unPrestamo : super.getPrestamos()) {
            if (super.cantLibrosPrestados() > 3 && unPrestamo.vencido(p_fecha)) {
                return false;
            }
        }
        return true;
    }

    public String soyDeLaClase() {
        return "Estudiante";
    }
}