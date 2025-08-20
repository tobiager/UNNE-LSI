import java.util.ArrayList;
/**
 * La clase Rectangulo modela un rectángulo definido por un punto de origen, un ancho y un alto.
 * Proporciona métodos para calcular su área, perímetro, desplazar su origen, 
 * y comparar su tamaño con otro rectángulo.
 */
public class Rectangulo extends figuraGeometrica {
    private double ancho;
    private double alto;
    private String nombreFi;

    /**
     * Constructor que crea un rectángulo con el origen en el punto (0, 0).
     *
     * @param ancho El ancho del rectángulo.
     * @param alto  El alto del rectángulo.
     */

    /**
     * Constructor que crea un rectángulo con un origen específico.
     *
     * @param origen El punto de origen del rectángulo.
     * @param ancho  El ancho del rectángulo.
     * @param alto   El alto del rectángulo.
     */
    public Rectangulo(Punto p_origen, double p_ancho, double p_alto) {
        super(p_origen);
        this.setAncho(p_ancho);
        this.setAlto(p_alto);
        
    }
    
    /**
     * Establece el ancho del rectángulo.
     *
     * @param ancho El nuevo ancho del rectángulo.
     */
    public void setAncho(double p_ancho) {
        this.ancho = p_ancho;
    }

    /**
     * Establece el alto del rectángulo.
     *
     * @param alto El nuevo alto del rectángulo.
     */
    public void setAlto(double p_alto) {
        this.alto = p_alto;
    }

    /**
     * Devuelve el ancho del rectángulo.
     *
     * @return El ancho del rectángulo.
     */
    public double getAncho() {
        return this.ancho;
    }

    /**
     * Devuelve el alto del rectángulo.
     *
     * @return El alto del rectángulo.
     */
    public double getAlto() {
        return this.alto;
    }
    
    public String nombreFigura(){
        return "\n*****rectangulo*****";
    }
    /**
     * Desplaza el rectángulo sumando un valor a las coordenadas del origen.
     *
     * @param dx Desplazamiento en el eje x.
     * @param dy Desplazamiento en el eje y.
     */
    public void desplazar(double dx, double dy) {
        super.getOrigen().desplazar(dx, dy);
    }

    /**
     * Calcula el perímetro del rectángulo.
     *
     * @return El perímetro del rectángulo.
     */
    public double perimetro() {
        return (2 * getAncho() + 2* getAlto());
    }

    /**
     * Calcula la superficie (área) del rectángulo.
     *
     * @return La superficie del rectángulo.
     */
    public double superficie() {
        return this.getAncho() * this.getAlto();
    }

    /**
     * Muestra las características del rectángulo, incluyendo origen, ancho, alto, superficie y perímetro.
     */
    public void caracteristicas() {
        System.out.println(this.nombreFigura());
        System.out.printf("Origen:"+ this.getOrigen().coordenadas()+ " - Alto:"+ this.getAlto()+" - Ancho:"+ this.getAncho());
        System.out.printf("\n Superficie:"+ this.superficie()+"  - Perímetro:" + this.perimetro());
    }

    /**
     * Calcula la distancia entre el origen de este rectángulo y el origen de otro rectángulo.
     *
     * @param otroRectangulo El otro rectángulo con el que se calculará la distancia.
     * @return La distancia entre los orígenes de los dos rectángulos.
     */
    public double distanciaA(Rectangulo otroRectangulo) {
        return super.getOrigen().distanciaA(otroRectangulo.getOrigen());
    }

    /**
     * Compara la superficie de este rectángulo con la de otro y devuelve el rectángulo mayor.
     *
     * @param otroRectangulo El otro rectángulo a comparar.
     * @return El rectángulo con mayor superficie (si son iguales, devuelve este rectángulo).
     */
    public Rectangulo elMayor(Rectangulo otroRectangulo) {
        return (this.superficie() >= otroRectangulo.superficie()) ? this : otroRectangulo;
    }
    public void mostrarSuperficie(){
        System.out.println(this.nombreFigura());
        System.out.println("superficie: "+ this.superficie());
    }
}



