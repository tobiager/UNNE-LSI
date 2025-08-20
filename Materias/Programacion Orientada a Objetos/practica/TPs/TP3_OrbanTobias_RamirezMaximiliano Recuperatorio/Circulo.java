
import java.util.Random;

/**
 * Clase que representa un círculo en un plano, con un centro y un radio.
 * Utiliza la clase Punto para el centro.
 */
public class Circulo {

    private double radio;
    private Punto centro;

    /**
     * Constructor por defecto que inicializa el círculo con un radio de 0 y el centro en el origen (0,0).
     */
    public Circulo() {
        this.radio = 0.0;
        this.centro = new Punto();
    }

    /**
     * Constructor que inicializa el círculo con un centro y un radio dados.
     * @param p_radio El radio del círculo.
     * @param p_centro El centro del círculo.
     */
    public Circulo(double p_radio, Punto p_centro) {
        this.radio = p_radio;
        this.centro = p_centro;
    }

    /**
     * Establece el centro del círculo.
     * @param p_centro El nuevo centro del círculo.
     */
    public void setCentro(Punto p_centro) {
        this.centro = p_centro;
    }

    /**
     * Establece el radio del círculo.
     * @param p_radio El nuevo radio del círculo.
     */
    public void setRadio(double p_radio) {
        this.radio = p_radio;
    }

    /**
     * Obtiene el centro del círculo.
     * @return El centro del círculo.
     */
    public Punto getCentro() {
        return this.centro;
    }

    /**
     * Obtiene el radio del círculo.
     * @return El radio del círculo.
     */
    public double getRadio() {
        return this.radio;
    }

    /**
     * Desplaza el círculo a una nueva posición sin cambiar su tamaño, desplazando su centro.
     * @param p_dx Desplazamiento en el eje X.
     * @param p_dy Desplazamiento en el eje Y.
     */
    public void desplazar(double p_dx, double p_dy) {
        this.centro.desplazar(p_dx, p_dy);
    }

    /**
     * Calcula el perímetro del círculo.
     * @return El perímetro del círculo.
     */
    public double perimetro() {
        return 2 * Math.PI * this.radio;
    }

    /**
     * Calcula la superficie del círculo.
     * @return La superficie del círculo.
     */
    public double superficie() {
        return Math.PI * Math.pow(this.radio, 2);
    }

    /**
     * Muestra las características del círculo.
     */
    public void caracteristicas() {
        System.out.printf("****** Circulo ******%nCentro: %s - Radio: %.1f%nSuperficie: %.2f - Perímetro: %.2f%n", 
                          this.centro.coordenadas(), this.radio, this.superficie(), this.perimetro());
    }

    /**
     * Calcula la distancia entre este círculo y otro círculo dado.
     * @param otroCirculo El otro círculo con el que se calculará la distancia.
     * @return La distancia entre los centros de los dos círculos.
     */
    public double distanciaA(Circulo otroCirculo) {
        return this.centro.distanciaA(otroCirculo.getCentro());
    }

    /**
     * Compara dos círculos y retorna el que tiene mayor superficie.
     * @param otroCirculo El otro círculo con el que se comparará.
     * @return El círculo con mayor superficie.
     */
    public Circulo elMayor(Circulo otroCirculo) {
        return (this.superficie() > otroCirculo.superficie()) ? this : otroCirculo;
    }
}

