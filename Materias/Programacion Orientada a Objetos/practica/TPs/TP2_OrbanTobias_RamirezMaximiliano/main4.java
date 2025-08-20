
/**
 * Clase principal que contiene el método main para crear y mostrar un objeto Alumno.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class main4 {
    /**
     * Método principal que crea un objeto Alumno con los datos ingresados como argumentos.
     * @param args Los argumentos pasados a través de la línea de comandos.
     */
    public static void main(String[] args) {
        // Convertir los argumentos de String a los tipos de datos correspondientes
        int lu = Integer.parseInt(args[0]);
        String nombre = args[1];
        String apellido = args[2];
        double nota1 = Double.parseDouble(args[3]);
        double nota2 = Double.parseDouble(args[4]);

        // Crear un objeto Alumno con los datos proporcionados
        Alumno unAlumno = new Alumno(lu, nombre, apellido);
        unAlumno.setNota1(nota1);
        unAlumno.setNota2(nota2);

        // Mostrar la información del alumno
        unAlumno.mostrar();
    }
}
