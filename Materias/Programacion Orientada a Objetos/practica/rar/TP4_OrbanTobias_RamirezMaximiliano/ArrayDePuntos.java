

/**
 * esta clase genera un arreglo a bas de la clase puntos
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */

   import java.util.Scanner;

public class ArrayDePuntos {
    private static Punto[] puntos = new Punto[6];

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Ingreso de datos para cada punto
        for (int i = 0; i < puntos.length; i++) {
            System.out.printf("Ingrese las coordenadas del punto %d:%n", i + 1);
            System.out.print("x: ");
            double x = scanner.nextDouble();
            System.out.print("y: ");
            double y = scanner.nextDouble();
            puntos[i] = new Punto(x, y);
        }
        // Imprimir coordenadas de cada punto
        System.out.println("\nCoordenadas de los puntos:");
        for (int i = 0; i < puntos.length; i++) {
            puntos[i].mostrar(); // Usar mostrar() para imprimir coordenadas
        }

        // Imprimir distancia entre puntos consecutivos
        System.out.println("\nDistancias entre puntos consecutivos:");
        for (int i = 0; i < puntos.length - 1; i++) {
            double distancia = puntos[i].distanciaA(puntos[i + 1]); // Usar distanciaA() para calcular distancia
            System.out.printf("Distancia entre punto %d y punto %d: %.2f%n", i + 1, i + 2, distancia);
        }

        scanner.close();
        
    }}