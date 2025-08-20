

public abstract class Atleta{
    private int identificador;
    private String nombre;
    private double kilos;
    
    public int getIdentificador(){
        return this.identificador;
    }
    
    private void setIdentificador(int p_identificador){
        this.identificador = p_identificador;
    }
    
    public String getNombre(){
        return this.nombre;
    }
    
    private void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    
    public double getKilos(){
        return this.kilos;
    }
    
    private void setKilos(double p_kilos){
        this.kilos = p_kilos;
    }
    
    public Atleta(int p_identificador,String p_nombre,double p_kilos){
        this.setIdentificador(p_identificador);
        this.setNombre(p_nombre);
        this.setKilos(p_kilos);
    }
    
    public abstract String imprimirTipo();
    
    public String mostrarDatos(){
       return "Atleta: "+ this.getIdentificador() + "-" + this.getNombre() + "-" + "Kilos movidos: "+ this.getKilos(); 
    }
    
}
