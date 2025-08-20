
/**
 * Write a description of class Multiplo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Multiplo {
    public static void main(String[] args) {
        // Definir el rango
        int inicio = 42;
        int fin = 150;

        // Mostrar los múltiplos de 4 en el rango especificado
        for (int i = inicio; i <= fin; i++) {
            if (i % 4 == 0) {
                System.out.println(i);
            }
        }
    }
}

