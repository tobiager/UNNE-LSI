
/**
 * La clase Cuadrado representa un cuadrado en un sistema de coordenadas,
 * hereda de la clase Rectangulo.
 * 
 * @author Maximiliano
 * @version 1.0
 */
public class Cuadrado extends Rectangulo {
    
    /**
     * Constructor de la clase Cuadrado que inicializa el origen y el lado.
     * 
     * @param p_origen El punto que representa el origen del cuadrado.
     * @param p_lado La longitud de los lados del cuadrado.
     */
    public Cuadrado(Punto p_origen, double p_lado) {
        super(p_origen, p_lado, p_lado);
    }

    /**
     * Devuelve el nombre de la figura geométrica.
     * 
     * @return El nombre de la figura como un String.
     */
    public String nombreFigura() {
        return "\n***** Cuadrado *****";
    }

    /**
     * Muestra las características del cuadrado, incluyendo origen, lado, 
     * superficie y perímetro.
     */
    public void caracteristicas() {
        System.out.println(this.nombreFigura());
        System.out.printf("Origen:"+ super.getOrigen().coordenadas()+ " Lado:"+ super.getAncho());
        System.out.printf("\n Superficie:"+ super.superficie()+"  - Perímetro:" + super.perimetro());
    }

    /**
     * Muestra la superficie del cuadrado.
     */
    public void mostrarSuperficie() {
        System.out.println(this.nombreFigura());
        super.mostrarSuperficie();
    }
}

