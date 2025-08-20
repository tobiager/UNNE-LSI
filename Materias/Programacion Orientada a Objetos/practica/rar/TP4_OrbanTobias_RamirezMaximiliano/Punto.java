

/**
 * La clase Laboratorio representa a un laboratorio con sus datos de contacto
 * y políticas de compra y entrega.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Punto
{
    private double x;
    private double y;
    
     public Punto (){
           this.setX(0);
           this.setY(0);
    }
    
    public Punto (double p_x, double p_y){
        this.setX(p_x);
        this.setY(p_y);
    }
    private void setX(double p_x){
        this.x=p_x;
    }
    private void setY(double p_y){
        this.y=p_y;
    }
    public double getX(){
        return this.x;
    }
    public double getY(){
        return this.y;
    }
    public double distanciaA(Punto p_ptoDistante){
        double dx = this.getX() - p_ptoDistante.getX();
        double dy = this.getY() - p_ptoDistante.getY();
        return Math.sqrt(dx * dx + dy * dy);
    }
    public void desplazar(double p_dx, double p_dy){
         this.setX(this.getX()+p_dx);
         this.setY(this.getY()+p_dy);
    }
    public String coordenada(){
        return "(" + this.getX() + ", " + this.getY() + ")";
    }
    public void mostrar() {
        System.out.println("Punto: X: " + this.getX() + ", Y: " + this.getY());
    }
}
