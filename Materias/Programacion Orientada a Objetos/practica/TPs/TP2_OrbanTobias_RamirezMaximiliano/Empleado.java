
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Clase que representa a un Empleado con su nombre, apellido, CUIL, sueldo básico, y fecha de ingreso.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Empleado {
    private String nombre;
    private String apellido;
    private long cuil;
    private double sueldoBasico;
    private LocalDate fechaIngreso;

    /**
     * Constructor que inicializa los atributos del empleado.
     * @param p_nombre Nombre del empleado.
     * @param p_apellido Apellido del empleado.
     * @param p_cuil CUIL del empleado.
     * @param p_sueldoBasico Sueldo básico del empleado.
     * @param p_fechaIngreso Fecha de ingreso del empleado.
     */
    public Empleado(String p_nombre, String p_apellido, long p_cuil, double p_sueldoBasico, LocalDate p_fechaIngreso) {
        this.nombre = p_nombre;
        this.apellido = p_apellido;
        this.cuil = p_cuil;
        this.sueldoBasico = p_sueldoBasico;
        this.fechaIngreso = p_fechaIngreso;
    }

    // Observadores (Getters)
    public String getNombre() {
        return this.nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    public long getCuil() {
        return this.cuil;
    }

    public double getSueldoBasico() {
        return this.sueldoBasico;
    }

    public LocalDate getFechaIngreso() {
        return this.fechaIngreso;
    }

    // Mutadores (Setters)
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setCuil(long cuil) {
        this.cuil = cuil;
    }

    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    public void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    /**
     * Método que calcula la antigüedad del empleado en años.
     * @return La antigüedad del empleado en años.
     */
    public int antiguedad() {
        return (int) ChronoUnit.YEARS.between(fechaIngreso, LocalDate.now());
    }

    /**
     * Método que calcula el descuento aplicado al sueldo.
     * @return El valor del descuento.
     */
    public double descuento() {
        return (this.sueldoBasico * 0.02) + 1500;
    }

    /**
     * Método que calcula el adicional al sueldo basado en la antigüedad.
     * @return El valor del adicional.
     */
    public double adicional() {
        int anos = antiguedad();
        if (anos < 2) {
            return this.sueldoBasico * 0.02;
        } else if (anos >= 2 && anos < 10) {
            return this.sueldoBasico * 0.04;
        } else {
            return this.sueldoBasico * 0.06;
        }
    }

    /**
     * Método que calcula el sueldo neto del empleado.
     * @return El sueldo neto del empleado.
     */
    public double sueldoNeto() {
        return this.sueldoBasico + adicional() - descuento();
    }

    /**
     * Método que muestra la información completa del empleado.
     */
    public void mostrar() {
        System.out.println("Nombre y Apellido: " + nombre + " " + apellido);
        System.out.println("CUIL: " + cuil);
        System.out.println("Antigüedad: " + antiguedad() + " años de servicio");
        System.out.printf("Sueldo Neto: $ %.2f%n", sueldoNeto());
    }

    /**
     * Método que retorna una cadena con el CUIL, apellido y nombre, y el sueldo neto.
     * @return Una cadena con el CUIL, apellido y nombre, y el sueldo neto.
     */
    public String mostrarLinea() {
        return cuil + " " + apellido + ", " + nombre + " …………… $ " + sueldoNeto();
    }
}

