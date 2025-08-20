
public class Renglon{
    
    private int cantidad;
    protected double importe;
    private Etiqueta ticket;
    
    public int getCantidad(){
        return this.cantidad;
    }
    
    public void setCantidad(int p_cantidad){
      this.cantidad = p_cantidad;
    }

    public double getImporte(){
        return  ticket.precio(cantidad);
    }
    
    public void setImporte(double p_importe){
       this.importe = p_importe;
    }
    
    public Etiqueta getTicket(){
        return this.ticket;
    }
    
    public void setTicket(Etiqueta p_ticket){
        this.ticket = p_ticket;
    }
    
    public Renglon (int p_cantidad, double p_importe,Etiqueta p_ticket){
        this.setCantidad(p_cantidad);
        this.setImporte(p_importe);
        this.setTicket(p_ticket);
    }
    
    public Renglon (int p_cantidad, double p_importe){
        this.setCantidad(p_cantidad);
        this.setImporte(p_importe);
    }
    
    // Método para mostrar los detalles de este renglon
    public void mostrar() {
        System.out.println(getCantidad() + " Etiquetas de tipo " + ticket.tipo() + " - Costo: $" + ticket.getCosto() + " - " + ticket.toString());
        System.out.println("Precio: $" + getImporte());
    } 
}
