/**
 * Clase que representa a una mujer en el registro civil.
 */
public class Mujer {
    private String nombre;
    private String apellido;
    private int edad;
    private String estadoCivil;
    private Hombre esposo;

    /**
     * Constructor de la clase Mujer.
     * @param p_nombre Nombre de la mujer.
     * @param p_apellido Apellido de la mujer.
     * @param p_edad Edad de la mujer.
     */
    public Mujer(String p_nombre, String p_apellido, int p_edad) {
        this.setNombre(p_nombre);
        this.setApellido(p_apellido);
        this.setEdad(p_edad);
        this.setEstadoCivi("Soltera");
        this.setEsposo(null);
    }
    
    /**
     * Constructor de la clase Mujer con esposo.
     * @param p_nombre Nombre de la mujer.
     * @param p_apellido Apellido de la mujer.
     * @param p_edad Edad de la mujer.
     * @param p_esposo Hombre con el que está casada.
     */
    public Mujer(String p_nombre, String p_apellido, int p_edad, Hombre p_esposo) {
        this.setNombre(p_nombre);
        this.setApellido(p_apellido);
        this.setEdad(p_edad);
        this.setEstadoCivi("Soltera");
        this.setEsposo(p_esposo);
    }

    /**
     * Se casa con un hombre.
     * @param hombre Hombre con el que se casará.
     */
    public void casarseCon(Hombre hombre) {
        if (this.estadoCivil.equals("Soltera")) {
            this.estadoCivil = "Casada";
            this.esposo = hombre;
            hombre.casarseCon(this);  // Se actualiza también el esposo
        }
    }
    private void setNombre(String p_nombre){
        this.nombre=p_nombre;
    }
    private  void setApellido(String p_apellido){
        this.apellido=p_apellido;
    }
    private void setEdad(int p_edad){
        this.edad=p_edad;
        }
    private void setEsposo(Hombre p_esposo){
        this.esposo=p_esposo;
    }

    public String getNombre(){
        return this.nombre;
    }
    public  String  getApellido(){
        return this.apellido;
    }
    public int getEdad(){
            return this.edad;
        }
    
    public Hombre getEsposo(){
        return this.esposo;
    }

    /**
     * Realiza el divorcio de la mujer.
     */
    public void divorcio() {
        if (this.getEstadoCivi().equals("Casada")) {
            this.setEstadoCivi( "Divorciada");
            this.setEsposo(null);
        }
    }

    /**
     * Retorna los datos personales de la mujer.
     * @return Datos de la mujer en formato "Nombre Apellido de Edad años".
     */
    public String datos() {
        return this.getNombre() + " " + this.getApellido() + " de " + this.getEdad() + " años";
    }

    /**
     * Muestra el estado civil de la mujer.
     */
    public void mostrarEstadoCivil() {
        System.out.println(datos() + " - " + this.getEstadoCivi());
    }

    /**
     * Muestra con quién está casada la mujer.
     */
    public void casadaCon() {
        if (estadoCivil.equals("Casada")) {
            System.out.println(datos() + " está casada con " + this.getEsposo().datos());
        }
    }
    
    /**
     * Retorna el estado civil de la mujer.
     * @return Estado civil de la mujer.
     */
    public String getEstadoCivi() {
        return this.estadoCivil;
    }

    /**
     * Establece el estado civil de la mujer.
     * @param estadoCivil Nuevo estado civil.
     */
    public void setEstadoCivi(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }
}

