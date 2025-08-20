
public abstract class Atleta {
  private int identificador;
  private String nombre;
  private double kilos;

  public int getIdentificador() {
    return this.identificador;
  }

  public void setIdentificador(int identificador) {
    this.identificador = identificador;
  }

  public String getNombre() {
    return this.nombre;
  }

  public void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  public double getKilos() {
    return this.kilos;
  }

  public void setKilos(double p_kilos) {
    this.kilos = p_kilos;
  }

  public Atleta(int p_identificador, String p_nombre, double p_kilos) {
    this.setIdentificador(p_identificador);
    this.setNombre(p_nombre);
    this.setKilos(p_kilos);
  }

  public abstract String imprimirTipo();

  public String mostrarDatos() {
    return String.format("Atleta: %d - %s - Kilos movidos: %.2f", this.getIdentificador(), this.getNombre(),
        this.getKilos());
  }
}
