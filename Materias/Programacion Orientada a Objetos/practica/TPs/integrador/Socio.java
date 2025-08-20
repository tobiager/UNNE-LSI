import java.util.ArrayList;

/**
 * Clase abstracta que representa un Socio en el sistema de préstamos de libros.
 * Los socios pueden tener un DNI, nombre, un número de días para préstamos y una lista de préstamos activos.
 * 
 * @author MAXI
 */
abstract class Socio {

    private int dniSocio;
    private String nombre;
    private int diasPrestamo;
    private ArrayList<Prestamo> prestamos;

    /**
     * Constructor que inicializa un socio con DNI, nombre y días de préstamo.
     * La lista de préstamos se inicializa vacía.
     *
     * @param p_dniSocio el DNI del socio
     * @param p_nombre el nombre del socio
     * @param p_diasPrestamo los días permitidos para los préstamos
     */
    public Socio(int p_dniSocio, String p_nombre, int p_diasPrestamo) {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamo);
        this.setPrestamos(new ArrayList<Prestamo>());
    }

    /**
     * Constructor que inicializa un socio con DNI, nombre, días de préstamo y un préstamo inicial.
     * La lista de préstamos se inicializa con el préstamo pasado como parámetro.
     *
     * @param p_dniSocio el DNI del socio
     * @param p_nombre el nombre del socio
     * @param p_diasPrestamos los días permitidos para los préstamos
     * @param p_prestamo el préstamo inicial que se agregará al socio
     */
    public Socio(int p_dniSocio, String p_nombre, int p_diasPrestamos, Prestamo p_prestamo) {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamos);
        this.setPrestamos(new ArrayList<Prestamo>());
        this.agregarPrestamo(p_prestamo);
    }

    /**
     * Constructor que inicializa un socio con DNI, nombre, días de préstamo, una lista de préstamos y un préstamo inicial.
     * La lista de préstamos se establece a partir del parámetro.
     *
     * @param p_dniSocio el DNI del socio
     * @param p_nombre el nombre del socio
     * @param p_diasPrestamos los días permitidos para los préstamos
     * @param p_prestamos la lista de préstamos del socio
     * @param p_prestamo el préstamo inicial que se agregará
     */
    public Socio(int p_dniSocio, String p_nombre, int p_diasPrestamos, ArrayList<Prestamo> p_prestamos, Prestamo p_prestamo) {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamos);
        this.setPrestamos(p_prestamos);
        this.agregarPrestamo(p_prestamo);
    }

    /**
     * Constructor que inicializa un socio con DNI, nombre, días de préstamo y una lista de préstamos vacía.
     * Este constructor también elimina un préstamo específico de la lista de préstamos.
     *
     * @param p_dniSocio el DNI del socio
     * @param p_nombre el nombre del socio
     * @param p_prestamos la lista de préstamos del socio
     * @param p_prestamo el préstamo a eliminar
     * @param p_diasPrestamos los días permitidos para los préstamos
     */
    public Socio(int p_dniSocio, String p_nombre, ArrayList<Prestamo> p_prestamos , Prestamo p_prestamo, int p_diasPrestamos) {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamos);
        this.setPrestamos(new ArrayList<Prestamo>());
        this.quitarPrestamo(p_prestamo);
    }

    // Setters y getters

    /**
     * Establece el DNI del socio.
     * 
     * @param p_dniSocio el DNI del socio
     */
    public void setDniSocio(int p_dniSocio) {
        this.dniSocio = p_dniSocio;
    }

    /**
     * Establece el nombre del socio.
     * 
     * @param p_nombre el nombre del socio
     */
    public void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Establece los días de préstamo permitidos para el socio.
     * 
     * @param p_diasPrestamos los días de préstamo
     */
    public void setDiasPrestamo(int p_diasPrestamos) {
        this.diasPrestamo = p_diasPrestamos;
    }

    /**
     * Establece la lista de préstamos del socio.
     * 
     * @param p_prestamos la lista de préstamos
     */
    public void setPrestamos(ArrayList<Prestamo> p_prestamos) {
        this.prestamos = p_prestamos;
    }

    /**
     * Obtiene el DNI del socio.
     * 
     * @return el DNI del socio
     */
    public int getDniSocio() {
        return this.dniSocio;
    }

    /**
     * Obtiene el nombre del socio.
     * 
     * @return el nombre del socio
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Obtiene los días de préstamo permitidos para el socio.
     * 
     * @return los días de préstamo del socio
     */
    public int getDiasPrestamos() {
        return this.diasPrestamo;
    }

    /**
     * Obtiene la lista de préstamos activos del socio.
     * 
     * @return la lista de préstamos
     */
    public ArrayList<Prestamo> getPrestamos() {
        return this.prestamos;
    }

    /**
     * Agrega un préstamo a la lista de préstamos del socio.
     * 
     * @param p_prestamo el préstamo a agregar
     * @return verdadero si el préstamo se agregó correctamente, falso en caso contrario
     */
    public boolean agregarPrestamo(Prestamo p_prestamo) {
        return this.getPrestamos().add(p_prestamo);
    }

    /**
     * Elimina un préstamo de la lista de préstamos del socio.
     * 
     * @param p_prestamo el préstamo a eliminar
     * @return verdadero si el préstamo se eliminó correctamente, falso en caso contrario
     */
    public boolean quitarPrestamo(Prestamo p_prestamo) {
        if (this.getPrestamos().size() == 0) {
            return false;
        }
        return this.getPrestamos().remove(p_prestamo);
    }

    /**
     * Devuelve la cantidad de libros actualmente prestados al socio.
     * 
     * @return el número de libros prestados
     */
    public int cantLibrosPrestados() {
        int totalLibros = this.getPrestamos().size();
        return totalLibros;
    }

    /**
     * Devuelve una representación en cadena del socio, incluyendo su DNI, nombre, tipo de socio y cantidad de libros prestados.
     * 
     * @return una cadena con la información del socio
     */
    public String toString() {
        return "D.N.I.: " + this.getDniSocio() + " || " + this.getNombre() + " (" + this.soyDeLaClase() + ")"
                + " || Libros prestados: " + this.cantLibrosPrestados();
    }

    /**
     * Verifica si el socio puede solicitar más préstamos, basado en si tiene préstamos vencidos.
     * 
     * @return verdadero si el socio puede pedir un nuevo préstamo, falso si tiene algún préstamo vencido
     */
    public boolean puedePedir() {
        for (Prestamo prestamo : this.getPrestamos()) {
            if (prestamo.vencido(prestamo.getFechaDevolucion()) == true) {
                return false;
            }
        }
        return true;
    }

    /**
     * Método abstracto que debe ser implementado por las clases hijas para devolver el tipo de socio.
     * 
     * @return el tipo de socio como una cadena
     */
    abstract public String soyDeLaClase();
}

