
/**
 * La clase Laboratorio representa a un laboratorio con sus datos de contacto
 * y políticas de compra y entrega.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Laboratorio {
    // Atributos privados de la clase
    private String nombre;
    private String domicilio;
    private String telefono;
    private int compraMinima;
    private int diaEntrega;

    /**
     * Constructor que inicializa un laboratorio con todos sus atributos.
     * 
     * @param p_nombre El nombre del laboratorio.
     * @param p_domicilio El domicilio del laboratorio.
     * @param p_telefono El teléfono del laboratorio.
     * @param p_compraMin La cantidad mínima de compra.
     * @param p_diaEnt El día de entrega.
     */
    public Laboratorio(String p_nombre, String p_domicilio, String p_telefono, int p_compraMin, int p_diaEnt) {
        this.nombre = p_nombre;
        this.domicilio = p_domicilio;
        this.telefono = p_telefono;
        this.compraMinima = p_compraMin;
        this.diaEntrega = p_diaEnt;
    }

    /**
     * Constructor que inicializa un laboratorio sin política de compra mínima y día de entrega.
     * 
     * @param p_nombre El nombre del laboratorio.
     * @param p_domicilio El domicilio del laboratorio.
     * @param p_telefono El teléfono del laboratorio.
     */
    public Laboratorio(String p_nombre, String p_domicilio, String p_telefono) {
        this.setNombre(p_nombre);
        this.setDomicilio(p_domicilio);
        this.setTelefono (p_telefono);
        this.setCompraMinima ( 0);  
        this.setDiaEntrega( 0);    
    }

    // Getters y Setters

    /**
     * Obtiene el nombre del laboratorio.
     * 
     * @return El nombre del laboratorio.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * Establece el nombre del laboratorio.
     * 
     * @param nombre El nombre del laboratorio.
     */
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtiene el domicilio del laboratorio.
     * 
     * @return El domicilio del laboratorio.
     */
    public String getDomicilio() {
        return this.domicilio;
    }

    /**
     * Establece el domicilio del laboratorio.
     * 
     * @param domicilio El domicilio del laboratorio.
     */
    private void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    /**
     * Obtiene el teléfono del laboratorio.
     * 
     * @return El teléfono del laboratorio.
     */
    public String getTelefono() {
        return this.telefono;
    }

    /**
     * Establece el teléfono del laboratorio.
     * 
     * @param telefono El teléfono del laboratorio.
     */
    private void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * Obtiene la cantidad mínima de compra.
     * 
     * @return La cantidad mínima de compra.
     */
    public int getCompraMinima() {
        return this.compraMinima;
    }

    /**
     * Establece la cantidad mínima de compra.
     * 
     * @param compraMinima La cantidad mínima de compra.
     */
    private void setCompraMinima(int compraMinima) {
        this.compraMinima = compraMinima;
    }

    /**
     * Obtiene el día de entrega.
     * 
     * @return El día de entrega.
     */
    public int getDiaEntrega() {
        return diaEntrega;
    }

    /**
     * Establece el día de entrega.
     * 
     * @param diaEntrega El día de entrega.
     */
    private void setDiaEntrega(int diaEntrega) {
        this.diaEntrega = diaEntrega;
    }

    // Métodos adicionales

    /**
     * Actualiza la política de compra mínima del laboratorio.
     * 
     * @param p_compraMin La nueva cantidad mínima de compra.
     */
    public void nuevaCompraMinima(int p_compraMin) {
        this.compraMinima = p_compraMin;
    }

    /**
     * Actualiza el día de entrega del laboratorio.
     * 
     * @param p_diaEnt El nuevo día de entrega.
     */
    public void nuevoDiaEntrega(int p_diaEnt) {
        this.diaEntrega = p_diaEnt;
    }

    /**
     * Muestra la información del laboratorio en un formato legible.
     * 
     * @return Una cadena con la información del laboratorio.
     */
    public String mostrar() {
        return "Laboratorio: " + this.getNombre() + "\n" +
               "Domicilio: " + this.getDomicilio() + "-" + " Teléfono: " + this.getTelefono() + "\n" +
               "Compra Mínima: " + this.getCompraMinima() + "\n" +
               "Día de Entrega: " + this.getDiaEntrega();
    }
}

