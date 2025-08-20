import java.util.ArrayList;


public class Campeonato{
    private String nombre;
    public ArrayList <Equipo> equipos = new ArrayList<>();

    public String getNombre(){
        return this.nombre;
    }
    
    private void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    public Campeonato(String p_nombre){
        this.setNombre(p_nombre);
    }
    
    public boolean agregarEquipo (Equipo p_equipo){
        return equipos.add(p_equipo);
    }
    
    public void determinarGanador(){
        Equipo ganador = null;
        double maxKilos = 0;
        for(Equipo equipo : equipos){
            if(maxKilos < equipo.totalKilos()){
                ganador = equipo;
                maxKilos = equipo.totalKilos();
            }
        }
        System.out.println("\n Equipo ganador: "+ ganador.getNombre());
    }
}
