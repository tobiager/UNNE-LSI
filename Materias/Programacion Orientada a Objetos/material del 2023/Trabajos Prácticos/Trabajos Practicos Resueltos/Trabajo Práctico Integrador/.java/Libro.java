import java.util.ArrayList;

public class Libro {
    private String titulo;
    private int edicion;
    private String editorial;
    private int anio;
    private ArrayList<Prestamo> prestamos;

    public Libro(String p_titulo, int p_edicion, String p_editorial, int p_anio) {
        this.setTitulo(p_titulo);
        this.setEdicion(p_edicion);
        this.setEditorial(p_editorial);
        this.setAnio(p_anio);
        this.setPrestamos(new ArrayList<Prestamo>());
    }

    private void setTitulo(String p_titulo) {
        this.titulo = p_titulo;
    }

    private void setEdicion(int p_edicion) {
        this.edicion = p_edicion;
    }

    private void setEditorial(String p_editorial) {
        this.editorial = p_editorial;
    }

    private void setAnio(int p_anio) {
        this.anio = p_anio;
    }

    private void setPrestamos(ArrayList<Prestamo> p_prestamos) {
        this.prestamos = p_prestamos;
    }

    public String getTitulo() {
        return this.titulo;
    }

    public int getEdicion() {
        return this.edicion;
    }

    public String getEditorial() {
        return this.editorial;
    }

    public int getAnio() {
        return this.anio;
    }

    public ArrayList<Prestamo> getPrestamos() {
        return this.prestamos;
    }

    public Prestamo getPrestamo() {
        int longitud = this.getPrestamos().size();
        if (longitud != 0) {
            return this.getPrestamos().get(longitud - 1);
        }
        return null;
    }

    public boolean addPrestamo(Prestamo p_prestamo) {
        return this.getPrestamos().add(p_prestamo);
    }

    public boolean removePrestamo(Prestamo p_prestamo) {
        return this.getPrestamos().remove(p_prestamo);
    }

    public boolean prestado() {
        if (this.getPrestamos().isEmpty()) {
            return false;
        }
        return this.getPrestamo().getFechaDevolucion() == null && this.getPrestamo().getFechaRetiro() != null;
    }
    
    public String toString() {
        return "Titulo: " + this.getTitulo();
    }
}