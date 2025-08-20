import java.util.Calendar;

public class Docente extends Socio {
    private String area;

    public Docente(int p_dniSocio, String p_nombre, String p_area) {
        super(p_dniSocio, p_nombre, 5);
        this.setArea(p_area);
    }

    private void setArea(String p_area) {
        this.area = p_area;
    }

    public String getArea() {
        return this.area;
    }
    public boolean esResponsable() {
        Calendar p_fecha = Calendar.getInstance();
        for (Prestamo unPrestamo : super.getPrestamos()) {
            if (unPrestamo.vencido(p_fecha)) {
                return false;
            }
        }
        return true;
    }
    

    public void agregarDiasDePrestamo(int p_dias) {
        if (this.esResponsable()) {
            super.setDiasPrestamo(super.getDiasPrestamo() + p_dias);
        }
    }

    public String soyDeLaClase() {
        return "Docente";
    }
}