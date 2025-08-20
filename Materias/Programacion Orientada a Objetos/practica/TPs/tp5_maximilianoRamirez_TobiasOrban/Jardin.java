import java.util.ArrayList;

/**
 * La clase Jardin representa un jardín que contiene figuras geométricas.
 * Permite agregar y quitar figuras, calcular la superficie total de las figuras
 * y determinar la cantidad de pintura necesaria para cubrir el área.
 * 
 * @author (tu nombre)
 * @version (número de versión o fecha)
 */
public class Jardin {
    
    /** Lista de figuras geométricas en el jardín. */
    private ArrayList<figuraGeometrica> figuras;
    
    /** Nombre del jardín. */
    private String nombre;

    /**
     * Constructor de la clase Jardin.
     * 
     * @param p_nombre Nombre del jardín.
     * @param p_figuras Lista de figuras geométricas existentes en el jardín.
     * @param p_figura Figura geométrica que se añadirá al jardín.
     */
    public Jardin(String p_nombre, ArrayList<figuraGeometrica> p_figuras, figuraGeometrica p_figura) {
        this.setNombre(p_nombre);
        this.setFiguras(p_figuras);
        if (this.getFiguras() != null) {
            this.agregarFigura(p_figura);
        }
    }

    /**
     * Establece el nombre del jardín.
     * 
     * @param p_nombre Nombre del jardín.
     */
    public void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Establece la lista de figuras del jardín.
     * 
     * @param p_figuras Lista de figuras geométricas.
     */
    public void setFiguras(ArrayList<figuraGeometrica> p_figuras) {
        if (p_figuras != null) {
            this.figuras = p_figuras;
        }
    }

    /**
     * Obtiene el nombre del jardín.
     * 
     * @return Nombre del jardín.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Obtiene la lista de figuras geométricas del jardín.
     * 
     * @return Lista de figuras geométricas.
     */
    public ArrayList<figuraGeometrica> getFiguras() {
        return this.figuras;
    }

    /**
     * Agrega una figura geométrica al jardín.
     * 
     * @param p_figura Figura geométrica a agregar.
     * @return true si se agrega con éxito, false en caso contrario.
     */
    public boolean agregarFigura(figuraGeometrica p_figura) {
        return this.getFiguras().add(p_figura);
    }

    /**
     * Quita una figura geométrica del jardín.
     * 
     * @param p_figura Figura geométrica a quitar.
     * @return true si se quita con éxito, false en caso contrario.
     */
    public boolean quitarFigura(figuraGeometrica p_figura) {
        return this.getFiguras().remove(p_figura);
    }

    /**
     * Calcula la cantidad de litros de pintura necesaria para cubrir
     * la superficie total del jardín.
     * 
     * @return Cantidad de litros de pintura necesaria.
     */
    private double cuantosLitros() {
        double litros = (this.cuantosMetros() / 10);
        return litros;
    }

    /**
     * Calcula la cantidad de latas de pintura necesarias, considerando que
     * cada lata cubre 4 litros.
     * 
     * @return Cantidad de latas de pintura necesarias.
     */
    public int cuantasLatas() {
        return (int) Math.round(this.cuantosLitros() / 4);
    }

    /**
     * Calcula la superficie total de todas las figuras geométricas del jardín.
     * 
     * @return Superficie total en metros cuadrados.
     */
    public double cuantosMetros() {
        double metrosTotales = 0;
        for (figuraGeometrica figura : this.getFiguras()) {
            metrosTotales += figura.superficie();
        }
        return metrosTotales;
    }

    /**
     * Muestra los detalles de las figuras en el jardín, incluyendo
     * el presupuesto, la superficie total y la cantidad de latas de pintura necesarias.
     */
    public void detalleFiguras() {
        System.out.println("presupuesto: " + this.getNombre());
        for (figuraGeometrica figura : this.getFiguras()) {
            figura.mostrarSuperficie();
        }
        System.out.println("total a cubrir: " + this.cuantosMetros());
        System.out.println("cantidad de latas de pintura que se necesitan: " + this.cuantasLatas());
    }
}

