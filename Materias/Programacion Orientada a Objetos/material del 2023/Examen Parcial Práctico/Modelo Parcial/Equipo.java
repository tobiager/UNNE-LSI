
import java.util.ArrayList;

public class Equipo {
  private String nombre;
  private String procedencia;
  private ArrayList<Atleta> atletas;

  public String getNombre() {
    return this.nombre;
  }

  public void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  public String getProcedencia() {
    return this.procedencia;
  }

  public void setProcedencia(String p_procedencia) {
    this.procedencia = p_procedencia;
  }

  public ArrayList<Atleta> getAtletas() {
    return this.atletas;
  }

  public void setAtletas(ArrayList<Atleta> p_atletas) {
    this.atletas = p_atletas;
  }

  public Equipo(String p_nombre, String p_procedencia, Atleta p_atleta) {
    this.setNombre(p_nombre);
    this.setProcedencia(p_procedencia);
    this.setAtletas(new ArrayList<Atleta>());
    this.agregarAtleta(p_atleta);
  }

  public Equipo(String p_nombre, String p_procedencia, ArrayList<Atleta> p_atletas) {
    this.setNombre(p_nombre);
    this.setProcedencia(p_procedencia);
    this.setAtletas(p_atletas);
  }

  public boolean agregarAtleta(Atleta p_atleta) {
    return this.getAtletas().add(p_atleta);
  }

  public boolean quitarAtleta(Atleta p_atleta) {
    boolean seQuitó = false;
    if (this.getAtletas().size() > 1) {
      seQuitó = this.getAtletas().remove(p_atleta);
    }
    return seQuitó;
  }

  public void listarEquipo() {
    for (Atleta atleta : this.getAtletas()) {
      System.out.println(atleta.mostrarDatos());
    }
  }

  public int cantidadIntegrantes() {
    return this.getAtletas().size();
  }

  public void mostrar() {
    System.out.println("***** Detalle *****");
    System.out.format("Equipo: %s\n", this.getNombre());
    this.listarEquipo();
    System.out.format("Cantidad de integrantes: %s\n", this.cantidadIntegrantes());
    System.out.format("Puntaje total del equipo: %.2f\n", this.totalKilos());
  }

  public double totalKilos() {
    double totalKilos = 0.0;
    for (Atleta atleta : this.getAtletas()) {
      totalKilos += atleta.getKilos();
    }
    return totalKilos;
  }
}