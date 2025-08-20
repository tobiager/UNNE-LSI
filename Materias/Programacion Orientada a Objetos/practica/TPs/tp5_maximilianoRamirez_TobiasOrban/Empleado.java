
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;


/**
 * Clase que representa a un Empleado con su nombre, apellido, CUIL, sueldo básico, y fecha de ingreso.
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Empleado extends Persona {
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
    public Empleado(int p_dni, String p_nombre, String p_apellido,int p_anio, long p_cuil, double p_sueldoBasico, LocalDate p_fechaIngreso) {
        super(p_dni,  p_nombre, p_apellido, p_anio);
        this.setCuil(p_cuil);
        this.setSueldoBasico(p_sueldoBasico);
        this.setFechaIngreso(p_fechaIngreso);
    }

    // Observadores (Getters)

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
    

    private void setCuil(long cuil) {
        this.cuil = cuil;
    }

    private void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    private void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    /**
     * Método que calcula la antigüedad del empleado en años.
     * @return La antigüedad del empleado en años.
     */
    public int antiguedad() {
        return (int) ChronoUnit.YEARS.between(this.getFechaIngreso(), LocalDate.now());
    }

    /**
     * Método que calcula el descuento aplicado al sueldo.
     * @return El valor del descuento.
     */
    public double descuento() {
        return (this.getSueldoBasico() * 0.02) + 1500;
    }

    /**
     * Método que calcula el adicional al sueldo basado en la antigüedad.
     * @return El valor del adicional.
     */
    public double adicional() {
        int anos = antiguedad();
        if (anos < 2) {
            return this.getSueldoBasico() * 0.02;
        } else if (anos >= 2 && anos < 10) {
            return this.getSueldoBasico() * 0.04;
        } else {
            return this.getSueldoBasico() * 0.06;
        }
    }

    /**
     * Método que calcula el sueldo neto del empleado.
     * @return El sueldo neto del empleado.
     */
    public double sueldoNeto() {
        return this.getSueldoBasico() + this.adicional() - this.descuento();
    }

    /**
     * Método que muestra la información completa del empleado.
     */
    public void mostrar() {
        super.mostrar();
        System.out.println("CUIL: " + this.getCuil());
        System.out.println("Antigüedad: " + this.antiguedad() + " años de servicio");
        System.out.printf("Sueldo Neto: $ %.2f%n", this.sueldoNeto());
    }

    /**
     * Método que retorna una cadena con el CUIL, apellido y nombre, y el sueldo neto.
     * @return Una cadena con el CUIL, apellido y nombre, y el sueldo neto.
     */
    public String mostrarLinea() {
        return this.getCuil() + " " + super.getApellido() + ", " + super.getNombre() + " …………… $ " + this.sueldoNeto();
    }
    
    public boolean esAniversario() {
        LocalDate hoy = LocalDate.now();
        return hoy.getMonth() == fechaIngreso.getMonth() && hoy.getDayOfMonth() == fechaIngreso.getDayOfMonth();
    }
}
