
/**
 * Clase que representa un punto en un plano cartesiano con coordenadas X e Y.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Punto {

    private double x;
    private double y;

    /**
     * Constructor por defecto que inicializa el punto en el origen (0,0).
     */
    public Punto() {
        this.setX(0.0);
        this.setY(0.0);
    }

    /**
     * Constructor que inicializa el punto con las coordenadas dadas.
     * @param p_x Coordenada X del punto.
     * @param p_y Coordenada Y del punto.
     */
    public Punto(double p_x, double p_y) {
        this.setX(p_x);
        this.setY(p_y);
    }

    /**
     * Establece el valor de la coordenada X del punto.
     * @param p_x Nuevo valor de la coordenada X.
     */
    public void setX(double p_x) {
        this.x = p_x;
    }

    /**
     * Establece el valor de la coordenada Y del punto.
     * @param p_y Nuevo valor de la coordenada Y.
     */
    public void setY(double p_y) {
        this.y = p_y;
    }

    /**
     * Retorna el valor de la coordenada X del punto.
     * @return Valor de la coordenada X.
     */
    public double getX() {
        return this.x;
    }

    /**
     * Retorna el valor de la coordenada Y del punto.
     * @return Valor de la coordenada Y.
     */
    public double getY() {
        return this.y;
    }

    /**
     * Desplaza el punto por un valor dado en las coordenadas X e Y.
     * @param p_dx Valor de desplazamiento en el eje X.
     * @param p_dy Valor de desplazamiento en el eje Y.
     */
    public void desplazar(double p_dx, double p_dy) {
        this.setX(this.getX() + p_dx);
        this.setY(this.getY() + p_dy);
    }

    /**
     * Retorna una cadena con las coordenadas del punto en formato (X, Y).
     * @return Una cadena con las coordenadas del punto.
     */
    public String coordenadas() {
        return "(" + this.getX() + ", " + this.getY() + ")";
    }

    /**
     * Muestra las coordenadas del punto en la consola.
     */
    public void mostrar() {
        System.out.println("Punto. X: " + this.getX() + ", Y: " + this.getY());
    }

    /**
     * Calcula la distancia entre el punto actual y otro punto dado.
     * @param p_ptoDistante Otro objeto Punto con el que se calculará la distancia.
     * @return La distancia entre los dos puntos.
     */
    public double distanciaA(Punto p_ptoDistante) {
        double dx = p_ptoDistante.getX() - this.x;
        double dy = p_ptoDistante.getY() - this.y;
        return Math.sqrt(dx * dx + dy * dy);
    }
}

