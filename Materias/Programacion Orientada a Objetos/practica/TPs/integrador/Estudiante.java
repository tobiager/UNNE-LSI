import java.util.*;
/**
 * Write a description of class Docente here.
 * 
 * @author (Alejandro Ezequil Ratti) 
 */
public class Estudiante extends Socio{
    private String carrera;
    
    //Constructores
    public Estudiante(int p_dniSocio, String p_nombre,String p_carrera){
        super(p_dniSocio, p_nombre, 20);
        this.setCarrera(p_carrera);
    }

    public Estudiante(int p_dniSocio, String p_nombre, ArrayList<Prestamo> p_prestamos,Prestamo p_prestamo, String p_carrera){
        super(p_dniSocio, p_nombre, 20, p_prestamos, p_prestamo);
        this.setCarrera(p_carrera);
    }
    
    //Setters
    private void setCarrera(String p_carrera){
        this.carrera = p_carrera;
    }
    
    //Getters
    public String getCarrera(){
        return this.carrera;
    }
    
    //Metodos
     /**
        verifica si el Estudiante puede pedir libros.
          @param no recibe parametros
    */
    public boolean puedePedir(){
        if(super.puedePedir() && (super.cantLibrosPrestados() <= 3)){
            return true;
        }else{
            return false;
        }
    }
    
    /**
       retorna el mensaje Estudiante.
       @param no recibe parametros
     */
    public String soyDeLaClase(){
        return "Estudiante";
    }
}