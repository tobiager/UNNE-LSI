/**
 * Clase que representa a un hombre en el registro civil.
 */
public class Hombre {
    private String nombre;
    private String apellido;
    private int edad;
    private String estadoCivil;
    private Mujer esposa;

    /**
     * Constructor de la clase Hombre.
     * @param p_nombre Nombre del hombre.
     * @param p_apellido Apellido del hombre.
     * @param p_edad Edad del hombre.
     */
    public Hombre(String p_nombre, String p_apellido, int p_edad) {
        this.setNombre(p_nombre);
        this.setApellido(p_apellido);
        this.setEdad(p_edad);
        this.setEstadoCivil("Soltero");
        this.setEsposa(null);
    }
    
    /**
     * Constructor de la clase Hombre con esposa.
     * @param p_nombre Nombre del hombre.
     * @param p_apellido Apellido del hombre.
     * @param p_edad Edad del hombre.
     * @param p_esposa Mujer con la que está casado.
     */
    public Hombre(String p_nombre, String p_apellido, int p_edad, Mujer p_esposa) {
        this.setNombre(p_nombre);
        this.setApellido(p_apellido);
        this.setEdad(p_edad);
        this.setEstadoCivil("Soltero");
        this.setEsposa(p_esposa);
    }
    private void setNombre(String p_nombre){
        this.nombre=p_nombre;
    }
    private void setApellido(String p_apellido){
        this.apellido=p_apellido;
    }
    private void setEdad(int p_edad){
        this.edad=p_edad;
    }    
    private void setEsposa(Mujer p_esposa){
        this.esposa=p_esposa;
    }
    
    public String getNombre(){
        return this.nombre;
    }
    public String getApellido(){
        return this.apellido;
    }
    public int getEdad(){
        return this.edad;
    }
        
    public Mujer getEsposa(){
        return this.esposa;
    }
    /**
     * Se casa con una mujer.
     * @param mujer Mujer con la que se casará.
     */
    public void casarseCon(Mujer mujer) {
        if (this.getEstadoCivil().equals("Soltero")) {
            this.setEstadoCivil("Casado");
            this.setEsposa(mujer);
            mujer.casarseCon(this);  // Se actualiza también la esposa
        }
    }

    /**
     * Realiza el divorcio del hombre.
     */
    public void divorcio() {
        if (this.getEstadoCivil().equals("Casado")) {
            this.setEstadoCivil("Soltero");
            this.setEsposa(null);
        }
    }

    /**
     * Retorna los datos personales del hombre.
     * @return Datos del hombre en formato "Nombre Apellido de Edad años".
     */
    public String datos() {
        return this.getNombre() + " " + this.getApellido() + " de " + this.getEdad() + " años";
    }

    /**
     * Muestra el estado civil del hombre.
     */
    public void mostrarEstadoCivil() {
        System.out.println(datos() + " - " + this.getEstadoCivil());
    }

    /**
     * Muestra con quién está casado el hombre.
     */
    public void casadoCon() {
        if (estadoCivil.equals("Casado")) {
            System.out.println(datos() + " está casado con " + this.getEsposa().datos());
        }
    }
    
    /**
     * Retorna el estado civil del hombre.
     * @return Estado civil del hombre.
     */
    public String getEstadoCivil() {
        return this.estadoCivil;
    }

    /**
     * Establece el estado civil del hombre.
     * @param estadoCivil Nuevo estado civil.
     */
    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }
}



