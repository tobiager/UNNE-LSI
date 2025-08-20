
/**
 * Write a description of class Multiplo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Multiplo {
    public static void main(String[] args) {
        
        int inicio = 42;
        int fin = 150;

        
        for (int i = inicio; i <= fin; i++) {
            if (i % 4 == 0) {
                System.out.println(i);
            }
        }
    }
}

