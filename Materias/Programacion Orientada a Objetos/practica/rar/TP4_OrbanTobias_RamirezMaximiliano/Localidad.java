

/**
 * Representa una localidad en el sistema de gestión hospitalaria.
 */
public class Localidad {
    private String nombre;
    private String provincia;

    /**
     * Crea una nueva localidad con los datos especificados.
     * 
     * @param p_nombre el nombre de la localidad
     * @param p_provincia la provincia donde se encuentra la localidad
     */
    public Localidad(String p_nombre, String p_provincia) {
        this.setNombre(p_nombre);
        this.setProvincia(p_provincia);
    }

    /**
     * Muestra la información de la localidad.
     * 
     * @return una cadena con el nombre y la provincia de la localidad
     */
    public String mostrar() {
        return "Localidad: " + this.getNombre() + " Provincia: " + this.getProvincia();
    }

    // Getters y Setters

    public String getNombre() {
        return this.nombre;
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getProvincia() {
        return this.provincia;
    }

    private void setProvincia(String provincia) {
        this.provincia = provincia;
    }
}