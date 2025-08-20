
public class PruebaCalculadora {

    public static void main(String[] args) {
        Calculadora calc = new Calculadora();
        
        int ResSuma = calc.sumar(43, 79);
        System.out.println("Resultado de la Suma: " + ResSuma);
        
        double ResDiv = calc.dividir(15, 0);
        System.out.println("Resultado de la División: " + ResDiv);
    }
}
