import java.util.*;
import java.util.ArrayList;
/**
 * Write a description of class Prestamo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public abstract class Socio
{
    private int dniSocio;
    private String nombre;
    private int diasPrestamo;
    private ArrayList <Prestamo> prestamos;

    /**
     * Constructor for objects of class Socio
     */
    public Socio(int p_dniSocio, String p_nombre, int p_diasPrestamo)
    {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamo);
        this.setPrestamos(new ArrayList<Prestamo> ());
    }
    /**
     * Constructor for objects of class Socio
     */
    public Socio(int p_dniSocio, String p_nombre, int p_diasPrestamo, ArrayList <Prestamo> p_prestamos)
    {
        this.setDniSocio(p_dniSocio);
        this.setNombre(p_nombre);
        this.setDiasPrestamo(p_diasPrestamo);
        this.setPrestamos(p_prestamos);
    }
    
    //Inicio de Accesors
    private void setDniSocio(int p_dniSocio){
        this.dniSocio = p_dniSocio;
    }
    public int getDniSocio(){
        return this.dniSocio;
    }
    private void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    public String getNombre(){
        return this.nombre;
    }
    private void setPrestamos(ArrayList <Prestamo> p_prestamos){
        this.prestamos = p_prestamos;
    }
    public ArrayList <Prestamo> getPrestamos(){
        return this.prestamos;
    }
    //Fin de Accesors
    
    public boolean addPrestamo(Prestamo p_prestamo){
        return this.getPrestamos().add(p_prestamo);
    }
    public boolean removePrestamo(Prestamo p_prestamo){
         return this.getPrestamos().remove(p_prestamo);
    }
    public int cantLibrosPrestados(){
        return this.getPrestamos().size();
    }
    
    //Inicio de Accesors
    public void setDiasPrestamo(int p_dias){
        this.diasPrestamo = p_dias;
    }
    public int getDiasPrestamo(){
        return this.diasPrestamo;
    }
    //Fin de Accesors
    
    public String toString(){
        return ("D.N.I.: " + this.getDniSocio() + " || " + this.getNombre() + 
        " (" + this.soyDeLaClase() + ") || Libros Prestados: " + this.cantLibrosPrestados());
    }
    public boolean puedePedir(){
        Calendar fechaHoy = Calendar.getInstance();
        for(Prestamo x: this.getPrestamos()){
            if(x.vencido(fechaHoy)){
                return false;
            }
        }
        return true;
    }
    public abstract String soyDeLaClase();
}