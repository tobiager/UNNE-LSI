import java.util.Calendar;

/**
 * Clase que representa a un empleado que puede tener un jefe.
 */
public class EmpleadoConJefe {
    // Atributos privados de la clase
    private long cuil;
    private String apellido;
    private String nombre;
    private double sueldoBasico;
    private Calendar fechaIngreso;
    private EmpleadoConJefe jefe;  // Referencia al jefe del empleado

    // Constructores
    public EmpleadoConJefe(long p_cuil, String p_apellido, String p_nombre, double p_importe, Calendar p_fecha, EmpleadoConJefe p_jefe) {
        this.setCuil(p_cuil);
        this.setApellido(p_apellido);
        this.setNombre(p_nombre);
        this.setSueldoBasico(p_importe);
        this.setFechaIngreso(p_fecha);
        this.setJefe(p_jefe);
    }

    public EmpleadoConJefe(long p_cuil, String p_apellido, String p_nombre, double p_importe, Calendar p_fecha) {
        this.setCuil(p_cuil);
        this.setApellido(p_apellido);
        this.setNombre(p_nombre);
        this.setSueldoBasico(p_importe);
        this.setFechaIngreso(p_fecha);
        this.setJefe(null);
    }
    
    public EmpleadoConJefe(long p_cuil, String p_apellido, String p_nombre, double p_importe, int p_anio) {
        this.setCuil(p_cuil);
        this.setApellido(p_apellido);
        this.setNombre(p_nombre);
        this.setSueldoBasico(p_importe);
        this.setAnioIngreso(p_anio);
        this.setJefe(null);
    }

    // Getters y Setters con doble encapsulamiento

    public long getCuil() {
        return this.cuil;
    }

    private void setCuil(long cuil) {
        this.cuil = cuil;
    }

    public String getNombre() {
        return this.nombre;
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    private void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public double getSueldoBasico() {
        return this.sueldoBasico;
    }

    private void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }
    
    
    public void setAnioIngreso(int anio) {
        if (this.fechaIngreso == null) {
            this.fechaIngreso = Calendar.getInstance(); // Inicializar si está nulo
        }
        this.fechaIngreso.set(anio, Calendar.JANUARY, 1); // Usar 1 de enero como default
    }

    
    public int getAnioIngreso() {
        return this.fechaIngreso.get(Calendar.YEAR);
    }

    public Calendar getFechaIngreso() {
        return this.fechaIngreso;
    }

    private void setFechaIngreso(Calendar fechaIngreso) {
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
        return ahora.get(Calendar.YEAR) - getFechaIngreso().get(Calendar.YEAR);
    }

    public double descuento() {
        return (this.getSueldoBasico() * 0.02) + 1500;
    }

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

    public double sueldoNeto() {
        return this.getSueldoBasico() + adicional() - descuento();
    }

    public String nomYApe() {
        return this.getNombre() + " " + this.getApellido();
    }

    public String apeYNom() {
        return this.getApellido() + ", " + this.getNombre();
    }

    public void mostrarPantalla() {
    System.out.println("Nombre y Apellido: " + nomYApe());
    System.out.println("CUIL: " + cuil);
    System.out.println("Antigüedad: " + antiguedad() + " años de servicio");
    System.out.printf("Sueldo Neto: $ %.2f\n", sueldoNeto());

        // Verificamos si el empleado es el gerente general o no
        if (this instanceof EmpleadoConJefe && jefe == null) {
        // Si el empleado es el gerente general (jefe es null), no se imprime "Responde a:"
        return; // Simplemente no imprimimos nada sobre el jefe
        }

        // Si el empleado tiene un jefe, se imprime el nombre de su jefe
        if (jefe != null) {
            System.out.println("Responde a: " + jefe.apeYNom());
        } else {
            // Si no tiene jefe y no es el gerente general, se imprime "Responde a: GERENTE GENERAL"
            System.out.println("Responde a: GERENTE GENERAL");
        }
    }   

    public String mostrarLinea() {
        return this.getCuil() + " " + this.apeYNom() + " …………… $ " + this.sueldoNeto();
    }

    public String emitirPermisoSalida() {
        String permiso = "Permiso de salida emitido para " + this.nomYApe() + ".";
        if (getJefe() != null) {
            permiso += " Aprobado por: " + this.getJefe().nomYApe() + ".";
        } else {
            permiso += " Aprobado por: GERENTE GENERAL.";
        }
        return permiso;
    }
}


