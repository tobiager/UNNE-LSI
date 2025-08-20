
/**
 * Clase de prueba para la gestión de stock.
 */
public class GestionStock {
    public static void main(String[] args) {
        // Crear un laboratorio
        Laboratorio lab = new Laboratorio("Colgate S.A.", "Scalabrini Ortiz 5524", "54-11-4239-8447");

        // Crear un producto
        Producto producto = new Producto(101, "Perfumería", "Jabón Deluxe", 5.25, 0.2, 100, lab);

        // Ajustar el stock a 500 (promoción del laboratorio)
        producto.ajuste(500);

        // Mostrar información del producto
        producto.mostrar();

        // Simular la baja de 200 productos (destrucción por mal estibado)
        producto.ajuste(-200);

        // Mostrar nuevamente la información del producto
        System.out.println("\nDespués de la destrucción de 200 unidades:");
        producto.mostrar();

        // Mostrar el precio de lista y el precio de contado
        System.out.println("\nConsulta de precio:");
        System.out.println(producto.mostrarLinea());
    }
}


