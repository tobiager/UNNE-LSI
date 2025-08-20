
/**
 * Representa un producto en un sistema de gestión de stock.
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Producto {
    private int codigo;
    private String rubro;
    private String descripcion;
    private double costo;
    private int stock;
    private double porcPtoRepo;
    private int existMinima;
    private Laboratorio laboratorio;

    /**
     * Constructor completo del producto.
     *
     * @param p_codigo Código del producto
     * @param p_rubro Rubro del producto
     * @param p_desc Descripción del producto
     * @param p_costo Costo del producto
     * @param p_porcPtoRepo Porcentaje del punto de reposición
     * @param p_existMinima Existencia mínima
     * @param p_lab Laboratorio del producto
     */
    public Producto(int p_codigo, String p_rubro, String p_desc, double p_costo, double p_porcPtoRepo, int p_existMinima, Laboratorio p_lab) {
        this.codigo = p_codigo;
        this.rubro = p_rubro;
        this.descripcion = p_desc;
        this.costo = p_costo;
        this.porcPtoRepo = p_porcPtoRepo;
        this.existMinima = p_existMinima;
        this.laboratorio = p_lab;
        this.stock = 0;
    }

    /**
     * Constructor alternativo del producto, sin punto de reposición y existencia mínima.
     *
     * @param p_codigo Código del producto
     * @param p_rubro Rubro del producto
     * @param p_desc Descripción del producto
     * @param p_costo Costo del producto
     * @param p_lab Laboratorio del producto
     */
    public Producto(int p_codigo, String p_rubro, String p_desc, double p_costo, Laboratorio p_lab) {
        this.setCodigo(p_codigo);
        this.setRubro(p_rubro);
        this.setDescripcion ( p_desc);
        this.setCosto(p_costo);
        this.setLaboratorio (p_lab);
        this.setStock(0);
    }

    // Accessors (getters y setters)
    public void setLaboratorio(Laboratorio p_labo){
        this.laboratorio=p_labo;
    }
    public Laboratorio getLaboratorio(){
        return this.laboratorio;
    }
    /**
     * @return el código del producto
     */
    public int getCodigo() {
        return codigo;
    }

    /**
     * @param codigo nuevo código del producto
     */
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    /**
     * @return el rubro del producto
     */
    public String getRubro() {
        return rubro;
    }

    /**
     * @param rubro nuevo rubro del producto
     */
    public void setRubro(String rubro) {
        this.rubro = rubro;
    }

    /**
     * @return la descripción del producto
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion nueva descripción del producto
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return el costo del producto
     */
    public double getCosto() {
        return costo;
    }

    /**
     * @param costo nuevo costo del producto
     */
    public void setCosto(double costo) {
        this.costo = costo;
    }

    /**
     * @return el stock disponible del producto
     */
    public int getStock() {
        return stock;
    }

    /**
     * @param stock nuevo stock del producto
     */
    public void setStock(int stock) {
        this.stock = stock;
    }

    /**
     * @return el porcentaje de punto de reposición
     */
    public double getPorcPtoRepo() {
        return porcPtoRepo;
    }

    /**
     * Ajusta el porcentaje de punto de reposición del producto.
     *
     * @param p_porce nuevo porcentaje de reposición
     */
    public void ajustarPtoRepo(double p_porce) {
        this.porcPtoRepo = p_porce;
    }

    /**
     * @return la existencia mínima del producto
     */
    public int getExistMinima() {
        return existMinima;
    }

    /**
     * Ajusta la existencia mínima del producto.
     *
     * @param p_cantidad nueva existencia mínima
     */
    public void ajustarExistMin(int p_cantidad) {
        this.existMinima = p_cantidad;
    }

    /**
     * Realiza un ajuste de stock.
     *
     * @param p_cantidad cantidad de productos a agregar o reducir
     */
    public void ajuste(int p_cantidad) {
        this.stock += p_cantidad;
    }

    /**
     * Calcula el valor del stock actual valorizado.
     *
     * @return el valor del stock multiplicado por el costo y un factor de ajuste
     */
    public double stockValorizado() {
        return stock * costo * 1.12;
    }

    /**
     * Calcula el precio de lista del producto.
     *
     * @return el precio de lista, que es el costo más un 12% de margen
     */
    public double precioLista() {
        return costo * 1.12;
    }

    /**
     * Calcula el precio de contado del producto.
     *
     * @return el precio de lista con un descuento del 5%
     */
    public double precioContado() {
        return precioLista() * 0.95;
    }

    /**
     * Muestra la información completa del producto.
     */
    public void mostrar() {
        System.out.println("Laboratorio: " + laboratorio.getNombre());
        System.out.println("Domicilio: " + laboratorio.getDomicilio() + " - Teléfono: " + laboratorio.getTelefono());
        System.out.println("Rubro: " + rubro);
        System.out.println("Descripción: " + descripcion);
        System.out.println("Precio Costo: " + String.format("%.2f", costo));
        System.out.println("Stock: " + stock + " - Stock Valorizado: $" + String.format("%.2f", stockValorizado()));
    }

    /**
     * Muestra una línea con la descripción y los precios del producto.
     *
     * @return una cadena que contiene la descripción, precio de lista y precio de contado
     */
    public String mostrarLinea() {
        return descripcion + " " + String.format("%.2f", precioLista()) + " " + String.format("%.2f", precioContado());
    }
}
