
public abstract class  Etiqueta{
    protected double costo;
    
    public double getCosto(){
        return this.costo;
    }

    public void setCosto(double p_costo){
         this.costo = p_costo;
    }
    
    public Etiqueta (double p_costo){
        this.setCosto(p_costo);
    }
    
    public abstract double precio(int q);
    
    public String toString() {
        if (this instanceof Premium) {
            return "Tipo: " + tipo() + " - Costo: $" + getCosto() + " - Colores: " + ((Premium) this).getColores();
        } else if (this instanceof Comun) {
            return "Tipo: " + tipo() + " - Costo: $" + getCosto() + " - Diseño: $" + ((Comun) this).getPlus();
        }
    
        return "Tipo: " + tipo() + " - Costo: $" + getCosto();
    }   
    
    public abstract String tipo();
}
