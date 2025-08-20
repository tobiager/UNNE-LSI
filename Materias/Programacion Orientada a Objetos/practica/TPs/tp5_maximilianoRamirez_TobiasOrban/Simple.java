
/**
 * Write a description of class Simple here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
/**
 * La clase Simple representa una etiqueta de tipo simple,
 * que extiende la clase abstracta Etiquetas.
 */
public class Simple extends Etiquetas {

    /**
     * Constructor para crear una instancia de una etiqueta simple.
     * 
     * @param p_costo El costo de la etiqueta.
     * @param p_plus Un costo adicional o "plus" de la etiqueta.
     * @param p_colores La cantidad de colores de la etiqueta.
     */
    public Simple(double p_costo, double p_plus, int p_colores) {
        super(p_costo, p_plus, p_colores);
    }

    /**
     * Calcula el precio total de la etiqueta simple en función
     * de la cantidad solicitada.
     * 
     * @param q La cantidad de etiquetas.
     * @return El precio total para la cantidad especificada.
     */
    public double precio(int q) {
        double precio = ((super.getCosto() * q) + super.getPlus()) - ((super.getCosto() * q + super.getPlus()) * this.descuento(q));
        return precio;
    }

    /**
     * Calcula un descuento basado en la cantidad de etiquetas
     * solicitadas.
     * 
     * @param q La cantidad de etiquetas.
     * @return El porcentaje de descuento a aplicar.
     */
    private double descuento(int q) {
        int gruposDeDiez = q / 10;
        double porcentajeDescuento = gruposDeDiez * 0.01;

        // Asegurarse de que el descuento no llegue a 100%
        if (porcentajeDescuento > 1.0) { 
            porcentajeDescuento = 1.0;
        } 
        
        if (q >= 1 && q <= 10) {
            return 0.0;
        } else if (q > 10 && q <= 50) { 
            return 0.02;
        } else if (q > 50 && q < 100) {
            return 0.05;
        } else {
            return porcentajeDescuento;
        }
    }

    /**
     * Devuelve el tipo de etiqueta, que en este caso es "simple".
     * 
     * @return El tipo de etiqueta.
     */
    protected String tipo() {
        return "simple";
    }
}

