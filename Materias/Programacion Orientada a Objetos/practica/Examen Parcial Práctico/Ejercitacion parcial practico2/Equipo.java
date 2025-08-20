import java.util.ArrayList;


public class Equipo{
    private String nombre;
    private String procedencia;
    public ArrayList <Atleta> atletas = new ArrayList<>();
    
    public String getNombre(){
        return this.nombre;
    }
    
    private void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    
    public String getProcedencia(){
        return this.procedencia;
    }
    
    private void setProcedencia(String p_procedencia){
        this.procedencia = p_procedencia;
    }
    
    public Equipo(String p_nombre, String p_procedencia){
        this.setNombre(p_nombre);
        this.setProcedencia(p_procedencia);
    }
    
    public boolean agregarAtleta (Atleta p_atleta){
        return atletas.add(p_atleta);
    }
    
    public int cantidadIntegrantes (){
        return atletas.size();
    }
    
    public double totalKilos (){
        double total = 0;
        for(Atleta atleta : atletas){
            total += atleta.getKilos();
        }
        return total;
    }
    
    public void listarEquipo(){
        System.out.println("\n*********Detalle*********");
        for(Atleta atleta : atletas){
            System.out.println(atleta.mostrarDatos());
        }
    }
    
    public void mostrarEquipo(){
        System.out.println("\n----------------------------");
        System.out.println("Nombre del Equipo: "+ this.getNombre());
        System.out.println("Procedencia: "+ this.getProcedencia());
        listarEquipo();
        System.out.println("Cantidad de integrantes:"+ this.cantidadIntegrantes());
        System.out.println("Puntaje total del equipo:"+ this.totalKilos());
    }
}
