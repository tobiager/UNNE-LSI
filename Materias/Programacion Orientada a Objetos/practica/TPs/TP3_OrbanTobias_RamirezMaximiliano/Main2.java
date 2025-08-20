
/**
 * Clase principal para calcular la distancia entre dos puntos.
 * 
 * El programa toma las coordenadas de dos puntos desde los argumentos de la línea de comandos,
 * crea los objetos de tipo Punto y calcula la distancia entre ellos.
 */
public class Main2 {
    /**
     * Método principal que recibe los argumentos de línea de comandos y calcula la distancia
     * entre dos puntos.
     * 
     * @param args Los argumentos de línea de comandos, que deben contener las coordenadas 
     *             de dos puntos en el formato: x1 y1 x2 y2
     */
    public static void main(String[] args) {
        // Verificar que se pasaron suficientes argumentos
        if (args.length < 4) {
            System.out.println("Por favor, ingrese las coordenadas de los dos puntos: x1 y1 x2 y2");
            return;
        }

        // Convertir los argumentos de String a double
        double x1 = Double.parseDouble(args[0]);
        double y1 = Double.parseDouble(args[1]);
        double x2 = Double.parseDouble(args[2]);
        double y2 = Double.parseDouble(args[3]);

        // Crear los puntos usando los valores ingresados
        Punto punto1 = new Punto(x1, y1);
        Punto punto2 = new Punto(x2, y2);

        // Mostrar las coordenadas de ambos puntos
        punto1.mostrar();
        punto2.mostrar();

        // Calcular la distancia entre los dos puntos
        double distancia = punto1.distanciaA(punto2);

        // Mostrar la distancia calculada
        System.out.println("La distancia entre los puntos es: " + distancia);
    }
}

