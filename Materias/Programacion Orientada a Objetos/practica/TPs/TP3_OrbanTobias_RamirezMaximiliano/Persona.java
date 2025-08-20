import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Scanner;

/**
 * La clase Persona representa a una persona con DNI, nombre, apellido y fecha de nacimiento.
 * @version 5.4.1
 */
public class Persona {
    private int nroDni;
    private String nombre;
    private String apellido;
    private Calendar fechaNacimiento;
    
     /**
     * Método estático para crear una instancia de Persona utilizando Scanner.
     * @param scanner Objeto Scanner para leer la entrada del usuario.
     * @return Una nueva instancia de Persona.
     */
    public static Persona crearPersona(Scanner scanner) {
        System.out.print("Ingrese el DNI: ");
        int dni = scanner.nextInt();
        scanner.nextLine(); // Consumir el salto de línea

        System.out.print("Ingrese el nombre: ");
        String nombre = scanner.nextLine();

        System.out.print("Ingrese el apellido: ");
        String apellido = scanner.nextLine();

        System.out.print("Ingrese el año de nacimiento: ");
        int year = scanner.nextInt();

        System.out.print("Ingrese el mes de nacimiento (1-12): ");
        int month = scanner.nextInt();

        System.out.print("Ingrese el día de nacimiento: ");
        int day = scanner.nextInt();

        Calendar fechaNacimiento = new GregorianCalendar(year, month - 1, day);

        return new Persona(dni, nombre, apellido, fechaNacimiento);
    }
    /**
     * Constructor de la clase Persona.
     * @param p_dni Número de DNI de la persona.
     * @param p_nombre Nombre de la persona.
     * @param p_apellido Apellido de la persona.
     * @param p_fecha Fecha de nacimiento de la persona.
     */
    public Persona(int p_dni, String p_nombre, String p_apellido, Calendar p_fecha) {
        this.setDNI(p_dni);
        this.setNombre(p_nombre);
        this.setApellido(p_apellido);
        this.fechaNacimiento = p_fecha;
    }

    // Getters y setters
    public void setDNI(int p_dni) { this.nroDni = p_dni; }
    public void setNombre(String p_nombre) { this.nombre = p_nombre; }
    public void setApellido(String p_apellido) { this.apellido = p_apellido; }
    public void setFechaNacimiento(int year, int month, int day) {
        this.fechaNacimiento = new GregorianCalendar(year, month - 1, day);
    }
    public int getDNI() { return this.nroDni; }
    public String getNombre() { return this.nombre; }
    public String getApellido() { return this.apellido; }
    public Calendar getFechaNacimiento() { return this.fechaNacimiento; }

    /**
     * Calcula y retorna la edad actual de la persona basada en la fecha de nacimiento.
     * @return Edad actual de la persona.
     */
    public int edad() {
        Calendar fechaHoy = new GregorianCalendar();
        int anioHoy = fechaHoy.get(Calendar.YEAR);
        int anioNacimiento = fechaNacimiento.get(Calendar.YEAR);
        int edad = anioHoy - anioNacimiento;

        if (fechaHoy.get(Calendar.MONTH) < fechaNacimiento.get(Calendar.MONTH) || 
            (fechaHoy.get(Calendar.MONTH) == fechaNacimiento.get(Calendar.MONTH) &&
             fechaHoy.get(Calendar.DAY_OF_MONTH) < fechaNacimiento.get(Calendar.DAY_OF_MONTH))) {
            edad--;
        }
        return edad;
    }

    /**
     * Retorna el nombre y apellido de la persona en formato "Nombre Apellido".
     * @return Nombre y apellido en formato "Nombre Apellido".
     */
    public String nomYApe() {
        return this.getNombre() + " " + this.getApellido();
    }

    /**
     * Retorna el apellido y nombre de la persona en formato "Apellido, Nombre".
     * @return Apellido y nombre en formato "Apellido, Nombre".
     */
    public String apeYNom() {
        return this.getApellido() + ", " + this.getNombre();
    }

    /**
     * Muestra la información de la persona en la consola.
     */
    public void mostrar() {
        System.out.println("Nombre y Apellido: " + this.nomYApe());
        System.out.println("DNI: " + this.getDNI());
        System.out.println("Fecha de Nacimiento: " + fechaNacimiento.get(Calendar.DAY_OF_MONTH) + "/" +
                (fechaNacimiento.get(Calendar.MONTH) + 1) + "/" + fechaNacimiento.get(Calendar.YEAR));
        System.out.println("Edad: " + this.edad() + " años");
    }

    /**
     * Verifica si hoy es el cumpleaños de la persona.
     * @return true si hoy es el cumpleaños, false en caso contrario.
     */
    public boolean esCumpleaños() {
        Calendar hoy = new GregorianCalendar();
        return hoy.get(Calendar.MONTH) == fechaNacimiento.get(Calendar.MONTH) &&
               hoy.get(Calendar.DAY_OF_MONTH) == fechaNacimiento.get(Calendar.DAY_OF_MONTH);
    }

    
    
}


