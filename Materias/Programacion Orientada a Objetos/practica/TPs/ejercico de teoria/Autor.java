
/**
 * Write a description of class Autor here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Autor{
    private String nombre;
    private String institucion;
    private String mail;
    
    Autor(String p_nombre, String p_institucion, String p_mail){
        this.nombre = p_nombre;
        this.institucion = p_institucion;
        this.mail = p_mail;
     }
     
    public String getNombre(){
            return this.nombre;
    }
    
    public String getInstitucion(){
            return this.institucion;
    }
    
    public String getMail(){
            return this.mail;
    }
    
    private void setNombre(String p_nombre){
            this.nombre = p_nombre;
    }
    
    private void setInstitucion(String p_institucion){
            this.institucion = p_institucion;
    }
    
    private void setMail(String p_mail){
            this.mail = p_mail;
    }
    
    public void mostrar(){
        System.out.println ("Autor: "+ nombre);
        System.out.println ("Institucion: "+ institucion);
        System.out.println ("Mail: "+ mail);
    }
}
