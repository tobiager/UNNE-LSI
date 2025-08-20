
/**
 * La clase Circulo representa un círculo en un sistema de coordenadas,
 * hereda de la clase Elipse.
 */
public class Circulo extends Elipse {

    /**
     * Constructor de la clase Circulo que inicializa el radio y el centro.
     * 
     * @param p_radio El radio del círculo.
     * @param p_centro El punto que representa el centro del círculo.
     */
    public Circulo(double p_radio, Punto p_centro) {
        super(p_radio, p_radio, p_centro); // Ambos semiejes son iguales para un círculo
    }

    /**
     * Calcula el perímetro del círculo utilizando la fórmula:
     * 2 * π * radio.
     * 
     * @return El perímetro del círculo.
     */
    public double perimetro() {
        return 2 * Math.PI * this.getSemiejeMayor(); // Utiliza semiejeMayor como el radio
    }

    /**
     * Muestra las características del círculo, incluyendo su nombre,
     * coordenadas, radio, superficie y perímetro.
     */
    @Override
    public void caracteristicas() {
        System.out.printf(nombreFigura());
        System.out.printf("Centro: %s - Radio: %.2f%nSuperficie: %.2f - Perímetro: %.2f%n", 
                          super.getOrigen().coordenadas(), this.getSemiejeMayor(), this.superficie(), this.perimetro());
    }

    /**
     * Devuelve el nombre de la figura geométrica.
     * 
     * @return El nombre de la figura como un String.
     */
    @Override
    public String nombreFigura() {
        return "\n****** Circulo ******%n";
    }

    /**
     * Muestra la superficie del círculo.
     */
    public void mostrarSuperficie() {
        System.out.println(this.nombreFigura());
        super.mostrarSuperficie();
    }
}




 