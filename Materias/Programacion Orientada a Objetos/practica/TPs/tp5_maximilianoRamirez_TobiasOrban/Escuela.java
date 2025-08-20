
/**
 * Write a description of class Escuela here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Scanner;
import java.util.ArrayList;

/**
 * La clase Escuela gestiona la información de los alumnos,
 * permitiendo agregar y quitar alumnos de una lista.
 */
public class Escuela {
    static ArrayList<Alumno> alumnos = new ArrayList<>();

    /**
     * Método principal que se ejecuta al iniciar la aplicación.
     * Permite ingresar información sobre un alumno y agregarlo
     * a la lista de alumnos.
     *
     * @param args Argumentos de línea de comandos (no utilizados).
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Ingrese el DNI: ");
        int dni = scanner.nextInt();
        scanner.nextLine(); // Consumir el salto de línea

        System.out.print("Ingrese el nombre: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el año de nacimiento: ");
        int year = scanner.nextInt();

        System.out.print("Ingrese el Lu del alumno: ");
        int lu = scanner.nextInt();

        System.out.print("Ingrese la nota 1 del alumno: ");
        double nota1 = scanner.nextDouble();
        
        System.out.print("Ingrese la nota 2 del alumno: ");
        double nota2 = scanner.nextDouble();

        Persona alum;
        Alumno Per;

        alum = new Persona(dni, nombre, apellido, year);
        alum.mostrar();
        Per = new Alumno(lu, dni, nombre, apellido, year);
        System.out.println("\n");
        agregarAlumno(Per);
        
        // Muestra la información de todos los alumnos
        for (Alumno alumno : alumnos) {
            alumno.mostrar();
        }
    }

    /**
     * Agrega un alumno a la lista de alumnos.
     * 
     * @param p_alumno El alumno a agregar.
     * @return true si el alumno se agregó correctamente, false en caso contrario.
     */
    public static boolean agregarAlumno(Alumno p_alumno) {
        return alumnos.add(p_alumno);
    }

    /**
     * Quita un alumno de la lista de alumnos.
     * 
     * @param p_alumno El alumno a quitar.
     * @return true si el alumno se quitó correctamente, false en caso contrario.
     */
    public static boolean quitarAlumno(Alumno p_alumno) {
        return alumnos.remove(p_alumno);
    }
}

