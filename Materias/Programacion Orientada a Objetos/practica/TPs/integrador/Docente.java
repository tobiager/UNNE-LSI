import java.util.*;
/**
 * Write a description of class Docente here.
 * 
 * @author (Alejandro Ezequiel Ratti). 
 */
public class Docente extends Socio{
    private String area;
    
    //Constructores
    public Docente(int p_dniSocio, String p_nombre,String p_area){
        super(p_dniSocio, p_nombre, 5);
        this.setArea(p_area);
    }
    
    public Docente(int p_dniSocio, String p_nombre, ArrayList<Prestamo> p_prestamos,Prestamo p_prestamo, String p_area){
        super(p_dniSocio, p_nombre, 5, p_prestamos, p_prestamo);
        this.setArea(p_area);
    }
    
    //Setters
    private void setArea(String p_area){
        this.area = p_area;
    }
    
    //Getters
    public String getArea(){
        return this.area;
    }
    
    //Metodos
    /**
     * verifica si el Docente puede pedir o no libros.
     * @param no recibe parametros.
     */
    public boolean esResponsable(){
        return this.puedePedir();
    }
    
    /**
     
     * Si el docente es responsable, se le asigna dias de prestamos,como bonificacion.
     * @param p_dias de tipo int.
     */
    public void cambiarDiasDePrestamo(int p_dias){
        if(this.esResponsable()){
            super.setDiasPrestamo(p_dias);
        }
    }
    
    /**
        verifica si el Docente puede pedir libros.
          @param no recibe parametros
    */
    public boolean puedePedir(){
        return super.puedePedir();
    }
    
    /**
       retorna el mensaje Docente.
       @param no recibe parametros
     */
    public String soyDeLaClase(){
        return "Docente";
    }
}   
