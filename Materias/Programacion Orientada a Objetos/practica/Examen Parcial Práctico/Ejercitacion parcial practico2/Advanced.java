

public class Advanced extends Atleta{
    private int barMuscleUps;
    
    public int getBarMuscleUps(){
        return this.barMuscleUps;
    }
    
    private void setBarMuscleUps(int p_barMuscleUps){
        this.barMuscleUps = p_barMuscleUps;
    }
    
    public Advanced(int p_identificador,String p_nombre,double p_kilos,int p_barMuscleUps){
        super(p_identificador,p_nombre,p_kilos);
        this.setBarMuscleUps(p_barMuscleUps);
    }
    
    @Override
    public String imprimirTipo(){
        return "BarMuscleUps";
    }
    
    
    public String mostrarDatos(){
       return "Atleta: "+ this.getIdentificador() + " - " + this.getNombre() + " - " + " Kilos movidos: "+ this.getKilos() + "- BarMuscleUps realizados: "+ this.getBarMuscleUps();
    }
}
