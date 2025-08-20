

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;
/**
 * esta clase instancia la clase pedido, Laboratorio, producto y cliente. 
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class TomarPedido {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
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
        
        Laboratorio lab2 = new Laboratorio("el chino", "Martina Cespedez 2024", "54-11-4249-5447");

        // Mostrar nuevamente la información del producto
        System.out.println("\nDespués de la destrucción de 200 unidades:");
        producto.mostrar();

        // Mostrar el precio de lista y el precio de contado
        System.out.println("\nConsulta de precio:");
        System.out.println(producto.mostrarLinea());
    
        // Crear cliente
        Cliente cliente = new Cliente("Juan Pérez", "12345678");

        // Crear lista de productos
        ArrayList<Producto> productosDisponibles = new ArrayList<>();
        productosDisponibles.add(new Producto(101, "Perfumería", "Jabón Deluxe", 5.25, 0.2, 100, lab));
        productosDisponibles.add(new Producto(20, "supermercado", "carne molida", 8.50, 0.4, 200,  lab2));
        

        // Crear un pedido
        Calendar fecha = Calendar.getInstance();
        Pedido pedido = new Pedido(fecha, cliente, new Producto(101, "Perfumería", "Jabón Deluxe", 5.25, 0.2, 100, lab)); // Producto inicial

        int opcion;
        //menú
        do {
            System.out.println("\nMenu:");
            System.out.println("1. mostrar productos disponibles");
            System.out.println("2. agregar producto");
            System.out.println("3. Quitar producto");
            System.out.println("4. Mostrar detalle del pedido");
            System.out.println("5. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = scanner.nextInt();

            switch (opcion) {
                case 1:
                    System.out.println("\nProductos disponibles:");
                    for (int i = 0; i < productosDisponibles.size(); i++) {
                        Producto p = productosDisponibles.get(i);
                        System.out.printf("%d. %s\tPrecio Lista: %.2f\tPrecio Contado: %.2f%n", 
                            i + 1, p.getDescripcion(), p.precioLista(), p.precioContado());
                    }
                    
                    break;
                case 2:
                    System.out.print("Seleccione el número del producto a agregar: ");
                    int indiceAgregar = scanner.nextInt() - 1;
                    if (indiceAgregar >= 0 && indiceAgregar < productosDisponibles.size()) {
                        pedido.agregarProducto(productosDisponibles.get(indiceAgregar));
                        System.out.println("Producto agregado.");
                    } else {
                        System.out.println("Opción no válida.");
                    }
                    
                    break;

                case 3:
                    System.out.println("\nProductos en el pedido:");
                    for (int i = 0; i < pedido.getProductos().size(); i++) {
                        Producto p = pedido.getProductos().get(i);
                        System.out.printf("%d. %s%n", i + 1, p.getDescripcion());
                    }
                    System.out.print("Seleccione el número del producto a quitar: ");
                    int indiceQuitar = scanner.nextInt() - 1;
                    if (indiceQuitar >= 0 && indiceQuitar < pedido.getProductos().size()) {
                        pedido.quitarProducto(pedido.getProductos().get(indiceQuitar));
                        System.out.println("Producto quitado.");
                    } else {
                        System.out.println("Opción no válida.");
                    }
                    break;

                case 4:
                    pedido.mostrar();
                    break;

                case 5:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opción no válida. Intente nuevamente.");
                    break;
            }
        } while (opcion != 5);

        scanner.close();
    }
}
