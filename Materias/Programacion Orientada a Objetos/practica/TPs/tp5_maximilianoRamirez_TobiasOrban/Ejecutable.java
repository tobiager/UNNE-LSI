import java.util.ArrayList;
import java.util.Scanner;

/**
 * La clase Ejecutable contiene el método principal para ejecutar la aplicación,
 * donde se gestionan los pedidos y los renglones asociados a etiquetas.
 */
public class Ejecutable {
    static ArrayList<Renglon> tickets = new ArrayList<>();

    /**
     * Método principal que ejecuta la aplicación.
     * Crea renglones de diferentes tipos de etiquetas y los agrega a un pedido.
     * Luego, muestra los detalles del pedido.
     * 
     * @param args Argumentos de línea de comandos (no se utilizan).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Agregar renglones con etiquetas premium y simples a la lista de tickets
        tickets.add(new Renglon(10, (new Premium(10.0, 0.0, 4))));
        tickets.add(new Renglon(10, (new Simple(10.0, 2, 0))));
        tickets.add(new Renglon(10, (new Premium(10.0, 0.0, 2))));

        // Crear un nuevo renglón
        Renglon ti = new Renglon(10, (new Premium(4.0, 0.0, 3)));
        
        // Crear un pedido con los renglones existentes y el nuevo renglón
        Pedidos pedido = new Pedidos(tickets, ti);
        
        // Mostrar los detalles del pedido
        pedido.mostrar();
    }
}

