
/**
 * Write a description of class Premiun here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase Premium representa una etiqueta de tipo premium,
 * que extiende la clase abstracta Etiquetas.
 */
public class Premium extends Etiquetas {

    /**
     * Constructor para crear una instancia de una etiqueta premium.
     * 
     * @param p_costo El costo de la etiqueta.
     * @param p_plus Un costo adicional o "plus" de la etiqueta.
     * @param p_colores La cantidad de colores de la etiqueta.
     */
    public Premium(double p_costo, double p_plus, int p_colores) {
        super(p_costo, p_plus, p_colores);
    }

    /**
     * Calcula el precio total de la etiqueta premium en función
     * de la cantidad solicitada.
     * 
     * @param q La cantidad de etiquetas.
     * @return El precio total para la cantidad especificada.
     */
    public double precio(int q) {
        double precio = (super.getCosto() * q) + ((super.getCosto() * q) * this.adicional());
        return precio;        
    }

    /**
     * Calcula un adicional basado en la cantidad de colores
     * de la etiqueta.
     * 
     * @return El porcentaje adicional a aplicar.
     */
    private double adicional() {
        double porcentajeAdicional = super.getColores() * 0.03;
        if (super.getColores() == 1) {
            return 0;
        } else if (super.getColores() == 2) { 
            return 0.05;
        } else if (super.getColores() == 3) {
            return 0.07;
        } else {
            return porcentajeAdicional;
        }
    }

    /**
     * Devuelve el tipo de etiqueta, que en este caso es "premium".
     * 
     * @return El tipo de etiqueta.
     */
    protected String tipo() {
        return "premium";
    }
}

