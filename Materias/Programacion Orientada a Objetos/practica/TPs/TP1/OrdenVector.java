
/**
 * Write a description of class OrdenVector here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Scanner;

public class OrdenVector {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double[] elementos = new double[4];

        
        System.out.println("Ingrese 4 elementos de tipo doble:");
        for (int i = 0; i < elementos.length; i++) {
            System.out.print("Elemento " + (i + 1) + ": ");
            elementos[i] = scanner.nextDouble();
        }

        
        double menorElemento = elementos[0];
        for (double elemento : elementos) {
            if (elemento < menorElemento) {
                menorElemento = elemento;
            }
        }
        System.out.println("Menor elemento: " + menorElemento);

        
        for (int i = 0; i < elementos.length - 1; i++) {
            for (int j = 0; j < elementos.length - 1 - i; j++) {
                if (elementos[j] > elementos[j + 1]) {
                    
                    double temp = elementos[j];
                    elementos[j] = elementos[j + 1];
                    elementos[j + 1] = temp;
                }
            }
        }

        
        System.out.print("Elementos ordenados: ");
        for (double elemento : elementos) {
            System.out.print(elemento + "\t");
        }
        

        
    }
}

