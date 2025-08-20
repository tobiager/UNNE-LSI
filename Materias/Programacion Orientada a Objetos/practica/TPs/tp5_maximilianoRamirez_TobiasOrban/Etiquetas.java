
/**
 * Write a description of class Etiquetas here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase abstracta Etiquetas representa una etiqueta
 * con propiedades como costo, plus y colores. Las subclases
 * deben implementar el método `precio` y el método `tipo`.
 */
abstract class Etiquetas {
    private double costo;
    private double plus;
    private int colores;

    /**
     * Constructor para crear una instancia de Etiquetas.
     * 
     * @param p_costo El costo de la etiqueta.
     * @param p_plus Un costo adicional o "plus" de la etiqueta.
     * @param p_colores La cantidad de colores de la etiqueta.
     */
    public Etiquetas(double p_costo, double p_plus, int p_colores) {
        this.setCosto(p_costo);
        this.setPlus(p_plus);
        this.setColores(p_colores);
    }

    /**
     * Establece el costo de la etiqueta.
     * 
     * @param p_costo El costo a establecer.
     */
    public void setCosto(double p_costo) {
        this.costo = p_costo;
    }

    /**
     * Establece el plus de la etiqueta.
     * 
     * @param p_plus El plus a establecer.
     */
    public void setPlus(double p_plus) {
        this.plus = p_plus;
    }

    /**
     * Establece la cantidad de colores de la etiqueta.
     * 
     * @param p_colores La cantidad de colores a establecer.
     */
    public void setColores(int p_colores) {
        this.colores = p_colores;
    }

    /**
     * Obtiene el costo de la etiqueta.
     * 
     * @return El costo de la etiqueta.
     */
    public double getCosto() {
        return this.costo;
    }

    /**
     * Obtiene el plus de la etiqueta.
     * 
     * @return El plus de la etiqueta.
     */
    public double getPlus() {
        return this.plus;
    }

    /**
     * Obtiene la cantidad de colores de la etiqueta.
     * 
     * @return La cantidad de colores.
     */
    public int getColores() {
        return this.colores;
    }

    /**
     * Método abstracto que calcula el precio de la etiqueta
     * basado en una cantidad dada.
     * 
     * @param q La cantidad de etiquetas.
     * @return El precio total para la cantidad especificada.
     */
    public abstract double precio(int q);

    /**
     * Representa la etiqueta como una cadena, mostrando
     * su tipo, costo y colores.
     * 
     * @return Una cadena que representa la etiqueta.
     */
    public String toString() {
        if (this.tipo().equals("premium")) {
            return "Tipo: " + this.tipo() + " - Costo: " + this.getCosto() + " - Colores: " + this.getColores();
        } else if (this.tipo().equals("simple")) {
            return "Tipo: " + this.tipo() + " - Costo: " + this.getPlus() + " - Diseño: " + this.getPlus();
        } else {
            return "Tipo: no especificado...";
        }
    }

    /**
     * Método abstracto que debe ser implementado por las subclases
     * para definir el tipo de etiqueta.
     * 
     * @return El tipo de etiqueta.
     */
    protected abstract String tipo();
}


