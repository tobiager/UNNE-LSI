
/**
 * La clase Triangulo representa un triángulo en un sistema de coordenadas,
 * hereda de la clase figuraGeometrica.
 */
public class Triangulo extends figuraGeometrica {
    private double base;
    private double altura;

    /**
     * Constructor de la clase Triangulo que inicializa la base y la altura.
     * 
     * @param p_punto El punto que representa un vértice del triángulo (origen).
     * @param p_base La longitud de la base del triángulo.
     * @param p_altura La altura del triángulo.
     */
    public Triangulo(Punto p_punto, double p_base, double p_altura) {
        super(p_punto);
        this.setBase(p_base);
        this.setAltura(p_altura);
    }

    /**
     * Establece la base del triángulo.
     * 
     * @param p_base La longitud de la base.
     */
    public void setBase(double p_base) {
        this.base = p_base;
    }

    /**
     * Establece la altura del triángulo.
     * 
     * @param p_altura La altura del triángulo.
     */
    public void setAltura(double p_altura) {
        this.altura = p_altura;
    }

    /**
     * Devuelve la base del triángulo.
     * 
     * @return La longitud de la base.
     */
    public double getBase() {
        return this.base;
    }

    /**
     * Devuelve la altura del triángulo.
     * 
     * @return La altura del triángulo.
     */
    public double getAltura() {
        return this.altura;
    }

    /**
     * Devuelve el nombre de la figura geométrica.
     * 
     * @return El nombre de la figura como un String.
     */
    public String nombreFigura() {
        return "\n***** Triangulo *****";
    }

    /**
     * Calcula la superficie del triángulo utilizando la fórmula:
     * (base * altura) / 2.
     * 
     * @return La superficie del triángulo.
     */
    public double superficie() {
        return (this.getBase() * this.getAltura()) / 2;
    }

    /**
     * Muestra la superficie del triángulo.
     */
    public void mostrarSuperficie() {
        System.out.println(this.nombreFigura());
        System.out.println("Superficie: " + this.superficie());
    }
}

