
/**
 * Write a description of class OperarVector here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Scanner;

public class OperarVector {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double[] notas = new double[5];
        double suma = 0;
        double mayorNota = Double.MIN_VALUE;

        
        System.out.println("Ingrese 5 notas de alumnos:");
        for (int i = 0; i < notas.length; i++) {
            System.out.print("Nota " + (i + 1) + ": ");
            notas[i] = scanner.nextDouble(); 
            suma += notas[i];
            if (notas[i] > mayorNota) {
                mayorNota = notas[i];
            }
        }

        
        double promedio = suma / notas.length;

        
        System.out.print("Notas ingresadas: ");
        for (double nota : notas) {
            System.out.print(nota + "\t");
        }
        System.out.println();

        
        System.out.printf("Promedio: %.2f%n", promedio);
        System.out.printf("Mayor nota: %.2f%n", mayorNota);
    }
}


