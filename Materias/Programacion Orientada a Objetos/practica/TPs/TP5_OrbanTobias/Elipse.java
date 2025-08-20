 
/**
 * La clase Elipse representa una elipse en un sistema de coordenadas,
 * definiendo su semieje mayor, semieje menor y su centro.
 * Hereda de la clase abstracta figuraGeometrica.
 */
public class Elipse extends figuraGeometrica {
    private double semiejeMayor;
    private double semiejeMenor;

    /**
     * Constructor de la clase Elipse que inicializa los semiejes y el centro.
     * 
     * @param p_semiejeMayor El valor del semieje mayor de la elipse.
     * @param p_semiejeMenor El valor del semieje menor de la elipse.
     * @param p_centro El punto que representa el centro de la elipse.
     */
    public Elipse(double p_semiejeMayor, double p_semiejeMenor, Punto p_centro) {
        super(p_centro);
        this.setSemiejeMayor(p_semiejeMayor);
        this.setSemiejeMenor(p_semiejeMenor);
    }

    /**
     * Establece el semieje mayor de la elipse.
     * 
     * @param p_semiejeMayor El nuevo valor del semieje mayor.
     */
    public void setSemiejeMayor(double p_semiejeMayor) {
        this.semiejeMayor = p_semiejeMayor;
    }

    /**
     * Establece el semieje menor de la elipse.
     * 
     * @param p_semiejeMenor El nuevo valor del semieje menor.
     */
    public void setSemiejeMenor(double p_semiejeMenor) {
        this.semiejeMenor = p_semiejeMenor;
    }

    /**
     * Obtiene el semieje mayor de la elipse.
     * 
     * @return El semieje mayor de la elipse.
     */
    public double getSemiejeMayor() {
        return this.semiejeMayor;
    }

    /**
     * Obtiene el semieje menor de la elipse.
     * 
     * @return El semieje menor de la elipse.
     */
    public double getSemiejeMenor() {
        return this.semiejeMenor;
    }

    /**
     * Desplaza el centro de la elipse en el sistema de coordenadas.
     * 
     * @param p_dx Desplazamiento en el eje x.
     * @param p_dy Desplazamiento en el eje y.
     */
    public void desplazar(double p_dx, double p_dy) {
        super.getOrigen().desplazar(p_dx, p_dy);
    }

    /**
     * Calcula la superficie de la elipse utilizando la fórmula: 
     * π * semiejeMayor * semiejeMenor.
     * 
     * @return La superficie de la elipse.
     */
    public double superficie() {
        return Math.PI * this.semiejeMayor * this.semiejeMenor;
    }

    /**
     * Muestra las características de la elipse, incluyendo su nombre,
     * coordenadas, semiejes y superficie.
     */
    public void caracteristicas() {
        System.out.printf(this.nombreFigura());
        System.out.printf("Centro: %s - Semieje Mayor: %.2f - Semieje Menor: %.2f%nSuperficie: %.2f%n", 
                          super.getOrigen().coordenadas(), this.getSemiejeMayor(), this.getSemiejeMenor(), this.superficie());
    }

    /**
     * Devuelve el nombre de la figura geométrica.
     * 
     * @return El nombre de la figura como un String.
     */
    public String nombreFigura() {
        return "\n****** Elipse ******%n";
    }

    /**
     * Muestra la superficie de la elipse.
     */
    public void mostrarSuperficie() {
        System.out.println(this.nombreFigura());
        System.out.println("superficie: " + this.superficie());
    }
}




