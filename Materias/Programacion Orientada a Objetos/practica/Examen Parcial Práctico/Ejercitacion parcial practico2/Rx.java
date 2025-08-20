

public class Rx extends Atleta{
    private int ringMuscleUps;
    
    public int getRingMuscleUps(){
        return this.ringMuscleUps;
    }
    
    private void setRingMuscleUps(int p_ringMuscleUps){
        this.ringMuscleUps = p_ringMuscleUps;
    }
    
    public Rx(int p_identificador,String p_nombre,double p_kilos,int p_ringMuscleUps){
        super(p_identificador,p_nombre,p_kilos);
        this.setRingMuscleUps(p_ringMuscleUps);
    }
    
    @Override
    public String imprimirTipo(){
        return "RingMuscleUps";
    }
    
    
    public String mostrarDatos(){
       return "Atleta: "+ this.getIdentificador() + " - " + this.getNombre() + " - " + " Kilos movidos: "+ this.getKilos() + " RingMuscleUps realizados: "+ this.getRingMuscleUps();
    }
}
