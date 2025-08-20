import java.util.ArrayList;

public class Campeonato {
  private String nombre;
  private ArrayList<Equipo> equipos;

  public String getNombre() {
    return this.nombre;
  }

  public void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  public ArrayList<Equipo> getEquipos() {
    return this.equipos;
  }

  public void setEquipos(ArrayList<Equipo> p_equipos) {
    this.equipos = p_equipos;
  }

  public Campeonato(String p_nombre, Equipo p_equipo) {
    this.setNombre(p_nombre);
    this.setEquipos(new ArrayList<Equipo>());
    this.agregarEquipo(p_equipo);
  }

  public Campeonato(String p_nombre, ArrayList<Equipo> p_equipos) {
    this.setNombre(p_nombre);
    this.setEquipos(p_equipos);
  }

  public boolean agregarEquipo(Equipo p_equipo) {
    return this.getEquipos().add(p_equipo);
  }

  public boolean quitarEquipo(Equipo p_equipo) {
    boolean seQuitó = false;
    if (this.getEquipos().size() > 1) {
      seQuitó = this.getEquipos().remove(p_equipo);
    }
    return seQuitó;
  }

  public void determinarGanador() {
    double total = 0.0;
    Equipo ganador = null;
    for (Equipo equipo : this.getEquipos()) {
      if (total < equipo.totalKilos()) {
        total = equipo.totalKilos();
        ganador = equipo;
      }
    }
    System.out.format("%s con %.2f kilos --> Equipo Ganador !! del %s", ganador.getNombre(), ganador.totalKilos(),
        this.getNombre());
  }
}
