
/**
 * La clase abstracta figuraGeometrica representa una figura geométrica
 * en un sistema de coordenadas. Contiene información sobre su origen y
 * métodos abstractos para obtener el nombre de la figura, su superficie
 * y para mostrar la superficie.
 * 
 * @author (tu nombre)
 * @version (número de versión o fecha)
 */
abstract class figuraGeometrica {
    private Punto origen;

    /**
     * Constructor de la figuraGeometrica que establece el origen de la figura.
     * 
     * @param p_origen El punto de origen de la figura.
     */
    public figuraGeometrica(Punto p_origen) {
        this.setOrigen(p_origen);
    }

    /**
     * Establece el origen de la figura.
     * 
     * @param p_origen El nuevo punto de origen de la figura.
     */
    public void setOrigen(Punto p_origen) {
        this.origen = p_origen;
    }

    /**
     * Obtiene el origen de la figura.
     * 
     * @return El punto de origen de la figura.
     */
    public Punto getOrigen() {
        return this.origen;
    }

    /**
     * Devuelve el nombre de la figura geométrica.
     * 
     * @return El nombre de la figura.
     */
    public abstract String nombreFigura();

    /**
     * Calcula la superficie de la figura geométrica.
     * 
     * @return La superficie de la figura.
     */
    public abstract double superficie();

    /**
     * Muestra la superficie de la figura geométrica.
     */
    public abstract void mostrarSuperficie();
}
