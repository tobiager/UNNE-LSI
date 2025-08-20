/**
 * 
 * se busca ingresar el saldo actual del cliente y luego nuevo.
 * 
 * @author Ariel Ramirez
 * @author Tobias Orban
 * @version 5.4.1
 */
public class Cliente {
    
    private int nroDNI;
    private String apellido;
    private String nombre;
    private double saldo;

    /**
     * el constructor cliente tiene como parametros
     * @param p_dni.
     * @param p_nombre.
     * @param p_apellido.
     * @param p_importe.
     * carga valores a los atributos pasando como parametros a los metros set
     */
    public Cliente(int p_dni, String p_apellido, String p_nombre, double p_importe) {
        this.setDNI(p_dni);
        this.setApe(p_apellido);
        this.setNom(p_nombre);
        this.setImporte(p_importe);
    }
    private void setDNI(int p_dni){
         this.nroDNI=p_dni;
    }
    private void setApe(String p_apellido){
         this.apellido=p_apellido;
    }
    private void setNom(String p_nombre){
         this.nombre=p_nombre;
    }
    private void setImporte(double p_importe){
         this.saldo=p_importe;
    }
    public int getDNI(){
        return this.nroDNI;
    }
    public String getNombre(){
        return this.nombre;
    }
    public String getApe(){
        return this.apellido;
    }
    public double getImporte(){
        return this.saldo;
    }
    public double agregaSaldo(double p_importe) {
        this.saldo+=p_importe;
        return this.saldo;
    }

    
    public double nuevoSaldo(double p_importe) {
        this.saldo = p_importe;
        return this.saldo;
    }

    
    public String apeYnom() {
        return this.getApe() + " " + this.getNombre();
    }

    
    public String nomYApe() {
        return this.nombre + " " + this.apellido;
    }

    
    public void mostrar() {
        System.out.println("- Cliente -");
        System.out.println("Nombre y Apellido: " + nomYApe() + " (" + nroDNI + ")");
        System.out.printf("Saldo: $%.2f%n", saldo);
    }
}


