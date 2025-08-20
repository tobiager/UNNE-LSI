import java.util.ArrayList;

/**
 * La clase Facultad representa una facultad que contiene
 * una lista de profesores. Permite gestionar la información
 * sobre los profesores y calcular los sueldos a pagar.
 */
public class Facultad {
    private String nombre;
    private ArrayList<Profesor> profesores;

    /**
     * Constructor para crear un objeto de tipo Facultad.
     * 
     * @param p_nombre El nombre de la facultad.
     * @param p_profesor Un profesor inicial a agregar a la facultad.
     */
    public Facultad(String p_nombre, Profesor p_profesor) {
        this.setNombre(p_nombre);
        this.setProfesores(new ArrayList<Profesor>());
        this.agregarProfesor(p_profesor);
    }

    /**
     * Establece el nombre de la facultad.
     * 
     * @param p_nombre El nombre a establecer.
     */
    public void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    /**
     * Obtiene el nombre de la facultad.
     * 
     * @return El nombre de la facultad.
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establece la lista de profesores de la facultad.
     * 
     * @param p_profesores La lista de profesores a establecer.
     */
    public void setProfesores(ArrayList<Profesor> p_profesores) {
        this.profesores = p_profesores;
    }

    /**
     * Obtiene la lista de profesores de la facultad.
     * 
     * @return La lista de profesores.
     */
    public ArrayList<Profesor> getProfesores() {
        return this.profesores;
    }

    /**
     * Muestra la nómina de profesores de la facultad,
     * incluyendo el total a pagar.
     */
    public void nominaProfesores() {
        System.out.println("******** Nómina Facultad FaCENA ********");
        System.out.println("______________________________");
        for (Profesor profesor : this.getProfesores()) {
            profesor.mostrarLinea();
        }
        System.out.println("______________________________");
        System.out.println("Total a pagar: " + this.totalAPagar());
    }

    /**
     * Agrega un profesor a la lista de profesores de la facultad.
     * 
     * @param p_profesor El profesor a agregar.
     * @return true si el profesor se agregó correctamente, false en caso contrario.
     */
    public boolean agregarProfesor(Profesor p_profesor) {
        return profesores.add(p_profesor);
    }

    /**
     * Remueve un profesor de la lista de profesores de la facultad.
     * 
     * @param p_profesor El profesor a remover.
     * @return true si el profesor se eliminó correctamente, false si solo queda un profesor.
     */
    public boolean removerProfesor(Profesor p_profesor) {
        if (profesores.size() <= 1) {
            System.out.println("No se puede eliminar, ya que solo queda un profesor...");
            return false;
        } else {
            return profesores.remove(p_profesor);
        }
    }

    /**
     * Calcula el total a pagar a todos los profesores de la facultad.
     * 
     * @return El total a pagar.
     */
    public double totalAPagar() {
        double totalPa = 0;
        for (Profesor profesor : this.getProfesores()) {
            totalPa += profesor.sueldoTotal();
        }
        return totalPa;
    }

    /**
     * Lista los detalles de los profesores y sus cargos en la facultad.
     */
    public void listarProfesoresCargos() {
        int numeroProfe = 0;
        System.out.println("***** Detalle de Profesores y Cargos de Facultad: FaCENA *****");
        for (Profesor profesor : this.getProfesores()) {
            profesor.mostrar();
            profesor.listaCargos();
            numeroProfe++;
        }
        System.out.println("Número de profesores: " + numeroProfe);
    }
}

