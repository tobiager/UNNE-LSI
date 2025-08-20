

/**
 * Una clase que toma pedidos de sus clientes y lista sus Productos
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
import java.util.Calendar;
import java.util.ArrayList;


public class Pedido {
    private Calendar fecha;
    private Cliente cliente;
    private ArrayList<Producto> productos;
    private Producto producto;

    /**
     * Constructor que inicializa un Pedido con una lista de productos.
     * @param p_fecha Fecha del pedido.
     * @param p_cliente Cliente que realiza el pedido.
     * @param p_productos Lista de productos incluidos en el pedido.
     */
    public Pedido(Calendar p_fecha, Cliente p_cliente, ArrayList<Producto> p_productos) {
        this.setFecha(p_fecha);
        this.setCliente(p_cliente);
        this.setProductos(new ArrayList<Producto>(p_productos));
        this.setProducto(null);
    }

    /**
     * Constructor que inicializa un Pedido con un único producto.
     * @param p_fecha Fecha del pedido.
     * @param p_cliente Cliente que realiza el pedido.
     * @param p_producto Producto incluido en el pedido.
     */
    public Pedido(Calendar p_fecha, Cliente p_cliente, Producto p_producto) {
        this.setFecha(p_fecha);
        this.setCliente(p_cliente);
        this.setProducto(p_producto);
        this.setProductos(new ArrayList<>());
        this.agregarProducto(p_producto);
    }
    //accesors
    public void setFecha(Calendar p_fecha) {
        this.fecha = p_fecha;
    }

    public void setCliente(Cliente p_cliente) {
        this.cliente = p_cliente;
    }

    public void setProductos(ArrayList<Producto> p_productos) {
        this.productos = p_productos;
    }

    public void setProducto(Producto p_producto) {
        this.producto = p_producto;
    }

    public Calendar getFecha() {
        return this.fecha;
    }

    public Cliente getCliente() {
        return this.cliente;
    }

    public ArrayList<Producto> getProductos() {
        return this.productos;
    }

    public Producto getProducto() {
        return this.producto;
    }

    /**
     * Calcula el total a pagar al contado de los productos en el pedido.
     * @return Total al contado.
     */
    public double totalAlContado() {
        double totalContado = 0.0;
        for (Producto producto : productos) {
            totalContado += producto.precioContado();
        }
        return totalContado;
    }

    /**
     * Calcula el total a pagar financiado de los productos en el pedido.
     * @return Total financiado.
     */
    public double totalFinanciado() {
        double totalFina = 0.0;
        for (Producto producto : productos) {
            totalFina += producto.precioLista();
        }
        return totalFina;
    }

    /**
     * Agrega un producto a la lista de productos del pedido.
     * @param p_producto Producto a agregar.
     * @return true si el producto fue agregado correctamente, false en caso contrario.
     */
    public boolean agregarProducto(Producto p_producto) {
        return productos.add(p_producto);
    }

    /**
     * Elimina un producto de la lista de productos del pedido.
     * @param p_producto Producto a eliminar.
     * @return true si el producto fue eliminado correctamente, false en caso contrario.
     */
    public boolean quitarProducto(Producto p_producto) {
        return productos.remove(p_producto);
    }

    /**
     * Muestra el detalle del pedido, incluyendo productos y totales.
     */
    public void mostrar(){
        System.out.println("****** Detalle del pedido ******" + " fecha:" + this.getFecha());
        System.out.println("Producto     "+"precio lista     "+"precio de contado");
        for(Producto producto : productos){
            System.out.println(producto.getDescripcion() +"     "+ producto.precioLista()+"     "+producto.precioContado());
        }
        System.out.println("***Total     "+ this.totalFinanciado()+"     "+this.totalAlContado());
    }
}
