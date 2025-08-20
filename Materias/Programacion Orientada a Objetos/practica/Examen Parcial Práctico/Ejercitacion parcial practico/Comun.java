
public class Comun extends Etiqueta{
    private double plus;
    
    public double getPlus(){
        return this.plus;
    }

    public void setPlus(double p_plus){
         this.plus = p_plus;
    }
    
    public Comun (double p_costo, double p_plus){
        super(p_costo);
        this.setPlus(p_plus);
    }
    
    @Override
    public double precio(int q) {
        return (costo + plus) * descuento(q);
    }

    
    public double descuento(int q) {
        if (q >= 1 && q <= 10) {
            return 1.0; // 0% descuento
        } else if (q >= 11 && q <= 50) {
            return 0.98; // 2% descuento
        } else if (q >= 51 && q <= 100) {
            return 0.95; // 5% descuento
        } else { // Más de 100
            return 1 - ((q / 10) * 0.01); // 1% descuento por cada 10 unidades
        }
    }

    
    @Override
    public String tipo(){
        return "Comun";
    }
}
