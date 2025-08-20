import java.util.ArrayList;

/**
 * La clase Profesor representa a un profesor, que extiende
 * la clase Persona. Incluye información sobre el título del
 * profesor y los cargos que tiene asignados.
 */
public class Profesor extends Persona {
    
    private String titulo;
    private ArrayList<Cargo> cargos;

    /**
     * Constructor para crear un objeto de tipo Profesor.
     * 
     * @param p_nroDni El número de DNI del profesor.
     * @param p_nombre El nombre del profesor.
     * @param p_apellido El apellido del profesor.
     * @param p_anioNacimiento El año de nacimiento del profesor.
     * @param p_titulo El título del profesor.
     * @param p_cargo Un cargo inicial a asignar al profesor.
     * @param p_cargos Una lista de cargos asignados al profesor.
     */
    public Profesor(int p_nroDni, String p_nombre, String p_apellido, int p_anioNacimiento, String p_titulo, Cargo p_cargo, ArrayList<Cargo> p_cargos) {
        super(p_nroDni, p_nombre, p_apellido, p_anioNacimiento);
        this.setTitulo(p_titulo);
        this.setCargos(p_cargos);
        if (p_cargo != null) {
            this.agregarCargo(p_cargo);
        }
    }

    /**
     * Establece el título del profesor.
     * 
     * @param p_titulo El título a establecer.
     */
    public void setTitulo(String p_titulo) {
        this.titulo = p_titulo;
    }

    /**
     * Obtiene el título del profesor.
     * 
     * @return El título del profesor.
     */
    public String getTitulo() {
        return this.titulo;
    }

    /**
     * Establece la lista de cargos del profesor.
     * 
     * @param p_cargos La lista de cargos a establecer.
     */
    public void setCargos(ArrayList<Cargo> p_cargos) {
        if (p_cargos != null) {
            this.cargos = p_cargos;
        } else {
            this.cargos = new ArrayList<>(); // Inicializar si es null
        }
    }

    /**
     * Obtiene la lista de cargos del profesor.
     * 
     * @return La lista de cargos.
     */
    public ArrayList<Cargo> getCargos() {
        return this.cargos;
    }

    /**
     * Muestra la información del profesor, incluyendo
     * su título.
     */
    public void mostrar() {
        super.mostrar();
        System.out.println("Título: " + this.getTitulo());
    }

    /**
     * Agrega un cargo a la lista de cargos del profesor.
     * 
     * @param p_cargo El cargo a agregar.
     * @return true si el cargo se agregó correctamente, false si se alcanzó el máximo.
     */
    public boolean agregarCargo(Cargo p_cargo) {
        if (cargos.size() == 3) {
            System.out.println("Ha alcanzado la cantidad máxima de cargos.");
            return false;
        } else {
            return this.getCargos().add(p_cargo);
        }
    }

    /**
     * Quita un cargo de la lista de cargos del profesor.
     * 
     * @param p_cargo El cargo a quitar.
     * @return true si el cargo se quitó correctamente, false si es el último cargo.
     */
    public boolean quitarCargo(Cargo p_cargo) {
        if (cargos.size() == 1) {
            System.out.println("No se puede eliminar el cargo ya que es el último.");
            return false;
        } else {
            return this.getCargos().remove(p_cargo);
        }
    }

    /**
     * Muestra la lista de cargos asignados al profesor.
     */
    public void listaCargos() {
        System.out.println("**** Cargos Asignados ****");
        
        for (Cargo cargo : this.getCargos()) {
            cargo.mostrarCargo();
            System.out.println("\n");
        }
    }

    /**
     * Calcula el sueldo total del profesor sumando
     * los sueldos básicos de todos los cargos asignados.
     * 
     * @return El sueldo total.
     */
    public double sueldoTotal() {
        double sueldoTotal = 0;
        for (Cargo cargo : this.getCargos()) {
            sueldoTotal += cargo.getSBasico();
        }
        return sueldoTotal;
    }

    /**
     * Muestra una línea con la información básica del
     * profesor, incluyendo su DNI y sueldo total.
     * 
     * @return Una cadena con la información del profesor.
     */
    public String mostrarLinea() {
        return "DNI: " + super.getDNI() + " Nombre: " + super.getNombre() + " - Sueldo Total: " + this.sueldoTotal();
    }
}

