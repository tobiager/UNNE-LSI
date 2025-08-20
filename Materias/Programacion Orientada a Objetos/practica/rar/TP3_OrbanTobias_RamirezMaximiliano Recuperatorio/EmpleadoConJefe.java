
import java.util.Calendar;

/**
 * Clase que representa a un empleado que puede tener un jefe.
 */
public class EmpleadoConJefe {
    private long cuil;
    private String apellido;
    private String nombre;
    private double sueldoBasico;
    private Calendar fechaIngreso;
    private EmpleadoConJefe jefe;  // Referencia al jefe del empleado

    // Constructores
    public EmpleadoConJefe(long p_cuil, String p_apellido, String p_nombre, double p_importe, Calendar p_fecha, EmpleadoConJefe p_jefe) {
        this.cuil = p_cuil;
        this.apellido = p_apellido;
        this.nombre = p_nombre;
        this.sueldoBasico = p_importe;
        this.fechaIngreso = p_fecha;
        this.jefe = p_jefe;
    }

    public EmpleadoConJefe(long p_cuil, String p_apellido, String p_nombre, double p_importe, Calendar p_fecha) {
        this(p_cuil, p_apellido, p_nombre, p_importe, p_fecha, null);
    }

    // Getters y Setters
    public long getCuil() {
        return this.cuil;
    }

    public void setCuil(long cuil) {
        this.cuil = cuil;
    }

    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public double getSueldoBasico() {
        return this.sueldoBasico;
    }

    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    public Calendar getFechaIngreso() {
        return this.fechaIngreso;
    }

    public void setFechaIngreso(Calendar fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public EmpleadoConJefe getJefe() {
        return this.jefe;
    }

    public void setJefe(EmpleadoConJefe jefe) {
        this.jefe = jefe;
    }

    // Otros métodos
    public int antiguedad() {
        Calendar ahora = Calendar.getInstance();
        return ahora.get(Calendar.YEAR) - fechaIngreso.get(Calendar.YEAR);
    }

    public double descuento() {
        return (this.sueldoBasico * 0.02) + 1500;
    }

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

    public double sueldoNeto() {
        return this.sueldoBasico + adicional() - descuento();
    }

    public String nomYApe() {
        return nombre + " " + apellido;
    }

    public String apeYNom() {
        return apellido + ", " + nombre;
    }

    public void mostrarPantalla() {
        System.out.println("Nombre y Apellido: " + nomYApe());
        System.out.println("CUIL: " + cuil);
        System.out.println("Antigüedad: " + antiguedad() + " años de servicio");
        System.out.printf("Sueldo Neto: $ %.2f%n", sueldoNeto());
        if (jefe != null) {
            System.out.println("Responde a: " + jefe.apeYNom());
        } else {
            System.out.println("Responde a: GERENTE GENERAL");
        }
    }

    public String mostrarLinea() {
        return cuil + " " + apeYNom() + " …………… $ " + sueldoNeto();
    }

    public String emitirPermisoSalida() {
        String permiso = "Permiso de salida emitido para " + nomYApe() + ".";
        if (jefe != null) {
            permiso += " Aprobado por: " + jefe.nomYApe() + ".";
        } else {
            permiso += " Aprobado por: GERENTE GENERAL.";
        }
        return permiso;
    }
}

