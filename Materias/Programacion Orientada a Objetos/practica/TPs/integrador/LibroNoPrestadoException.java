
/**
 * Excepcion personalizada que extiende de la clase {@Exception}
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class LibroNoPrestadoException extends Exception
{
    public LibroNoPrestadoException(String message){
        super(message);
    }
}
