
/**
 * esta clase da los datos generales de un cliente
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */

    public class Cliente {
    private String nombre;
    private String direccion;

    public Cliente(String p_nombre, String p_direccion) {
        this.setNombre(p_nombre);
        this.setDireccion(p_direccion);
    }
    public void setNombre(String p_nombre){
        this.nombre=p_nombre;
    }
    public void setDireccion(String p_direccion){
        this.direccion=p_direccion;
    }
    public String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }
}
