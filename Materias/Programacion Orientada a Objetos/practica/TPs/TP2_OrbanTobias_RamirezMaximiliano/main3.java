
/**
 * Clase main3 que contiene el método principal para crear y mostrar un objeto Cliente.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class main3 {
    /**
     * Método principal que crea un objeto Cliente con los datos ingresados como argumentos.
     * @param args Los argumentos pasados a través de la línea de comandos.
     */
    public static void main(String[] args) {
        // Convertir los argumentos de String a los tipos de datos correspondientes
        int nroDNI = Integer.parseInt(args[0]);
        String apellido = args[1];
        String nombre = args[2];
        double saldo = Double.parseDouble(args[3]);
        
        // Crear un objeto Cliente con los datos proporcionados
        Cliente cliente = new Cliente(nroDNI, apellido, nombre, saldo);
        
        // Mostrar la información del cliente
        cliente.mostrar();
    }
}


