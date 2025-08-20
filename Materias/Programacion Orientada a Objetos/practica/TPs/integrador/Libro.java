import java.util.*;
/**
 * Class Libro.
 * 
 * @author (Orban Tobias) 
 * @version (1.0)
 */
public class Libro{
    
    private String titulo;
    private int edicion;
    private String editorial;
    private int anio;
    private ArrayList<Prestamo> prestamos;

    /**
     * Constructor que inicializa un libro con un conjunto de préstamos.
     * 
     * @param p_titulo Título del libro.
     * @param p_edicion Edición del libro.
     * @param p_editorial Editorial del libro.
     * @param p_anio Año de publicación.
     * @param p_prestamo Lista de préstamos inicial del libro.
     */
    public Libro(String p_titulo, int p_edicion, String p_editorial, int p_anio, ArrayList<Prestamo> p_prestamo){
        this.setTitulo(p_titulo);
        this.setEdicion(p_edicion);
        this.setEditorial(p_editorial);
        this.setAnio(p_anio);
        this.setPrestamos(p_prestamo);
    }
    
     /**
     * Constructor que inicializa un libro con un préstamo.
     * 
     * @param p_titulo Título del libro.
     * @param p_edicion Edición del libro.
     * @param p_editorial Editorial del libro.
     * @param p_anio Año de publicación.
     * @param p_prestamo Préstamo inicial del libro.
     */
    public Libro(String p_titulo, int p_edicion, String p_editorial, int p_anio, Prestamo p_prestamo){
        this.setTitulo(p_titulo);
        this.setEdicion(p_edicion);
        this.setEditorial(p_editorial);
        this.setAnio(p_anio);
        this.setPrestamos(new ArrayList<Prestamo>());
        this.agregarPrestamo (p_prestamo);
    }    
    
     /**
     * Constructor que inicializa un libro sin prestamo.
     * 
     * @param p_titulo Título del libro.
     * @param p_edicion Edición del libro.
     * @param p_editorial Editorial del libro.
     * @param p_anio Año de publicación.
     */
    public Libro(String p_titulo, int p_edicion, String p_editorial, int p_anio){
        this.setTitulo(p_titulo);
        this.setEdicion(p_edicion);
        this.setEditorial(p_editorial);
        this.setAnio(p_anio);
        this.setPrestamos(new ArrayList<Prestamo>());
    }    
    
     /**
     * Establece el título del libro.
     * 
     * @param p_titulo Título a asignar.
     */
    private void setTitulo(String p_titulo){
        this.titulo = p_titulo;
    }
    
     /**
     * Obtiene el título del libro.
     * 
     * @return El título del libro.
     */
    public String getTitulo(){
        return this.titulo;
    }
    
     /**
     * Establece la edición del libro.
     * 
     * @param p_edicion Edición a asignar.
     */
    private void setEdicion(int p_edicion){
        this.edicion = p_edicion;
    }
    
    /**
     * Obtiene la edición del libro.
     * 
     * @return La edición del libro.
     */
    public int getEdicion(){
        return this.edicion;
    }
    
     /**
     * Establece la editorial del libro.
     * 
     * @param p_editorial Editorial a asignar.
     */
    private void setEditorial(String p_editorial){
        this.editorial = p_editorial;
    }
    
     /**
     * Obtiene la editorial del libro.
     * 
     * @return La editorial del libro.
     */
    public String getEditorial(){
        return this.editorial;
    }
    
    /**
     * Establece la lista de préstamos del libro.
     * 
     * @param p_prestamos Lista de préstamos a asignar.
     */
    private void setPrestamos(ArrayList<Prestamo> p_prestamos){
        this.prestamos = p_prestamos;
    }
    
    /**
     * Obtiene la lista de préstamos del libro.
     * 
     * @return La lista de préstamos del libro.
     */
    public ArrayList<Prestamo> getPrestamos(){
        return this.prestamos;
    } 
    
    /**
     * Establece el año de publicación del libro.
     * 
     * @param p_anio Año de publicación a asignar.
     */
    public void setAnio(int p_anio){
        this.anio = p_anio;
    }
    
    /**
     * Obtiene el año de publicación del libro.
     * 
     * @return El año de publicación del libro.
     */
    public int getAnio(){
        return this.anio;
    }

     /**
     * Agrega un préstamo a la lista de préstamos del libro.
     * 
     * @param p_prestamo Préstamo a agregar.
     * @return true si el préstamo fue agregado exitosamente, false en caso contrario.
     */
    public boolean agregarPrestamo(Prestamo p_prestamo){
        return this.getPrestamos().add(p_prestamo);
    }
    
    /**
     * Devuelve el último préstamo hecho para este libro.
     * Si no hay préstamos, retorna null.
     * 
     * @return El último préstamo del libro, o null si no hay préstamos.
     */
    public Prestamo ultimoPrestamo() {
        if (prestamos.isEmpty()){ 
            return null;
        }
        return prestamos.get(prestamos.size() - 1);
    }
    
    /**
     * Verifica si el libro está prestado. Se considera que está prestado si el último
     * préstamo no tiene fecha de devolución.
     * 
     * @return true si el libro está prestado, false en caso contrario.
     */
    public boolean prestado(){
        boolean prestado = false;
        
        if(this.ultimoPrestamo() != null && this.ultimoPrestamo().getFechaDevolucion() == null){
            prestado = true;
        }
        
        return prestado;
    }
    
    /**
     * Retorna una representación en cadena del libro, que incluye su título.
     * 
     * @return Una cadena con el título del libro.
     */
    public String toString(){
        return "Titulo: "+this.getTitulo();
    }
    
     /**
     * Elimina un préstamo de la lista de préstamos del libro.
     * 
     * @param p_prestamo Préstamo a eliminar.
     * @return true si el préstamo fue eliminado exitosamente, false en caso contrario.
     */
    public boolean quitarPrestamo(Prestamo p_prestamo){
        return this.getPrestamos().remove(p_prestamo);
    }
}