
public class Premium extends Etiqueta{
    private int colores;
    
    public int getColores(){
        return this.colores;
    }

    public void setColores(int p_colores){
         this.colores = p_colores;
    }
    
    public Premium (double p_costo, int p_colores){
        super(p_costo);
        this.setColores(p_colores);
    }
    
    @Override
    public double precio(int q){
        return costo + adicional();
    }
    
    public double adicional() {
        if (colores == 1) {
            return 0;
        } else if (colores == 2) {
            return costo * 0.05;
        } else if (colores == 3) {
            return costo * 0.07;
        } else { // Más de 3 colores
            return costo *  (colores * 0.03);
        }
    }

    
    @Override
    public String tipo(){
        return "Premium";
    }
}
