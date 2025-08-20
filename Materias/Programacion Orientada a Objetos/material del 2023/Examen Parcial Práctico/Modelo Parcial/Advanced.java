
public class Advanced extends Atleta {
  private int barMuscleUps;

  public int getBarMuscleUps() {
    return this.barMuscleUps;
  }

  public void setBarMuscleUps(int p_barMuscleUps) {
    this.barMuscleUps = p_barMuscleUps;
  }

  public Advanced(int p_identificador, String p_nombre, double p_kilos, int p_barMuscleUps) {
    super(p_identificador, p_nombre, p_kilos);
    this.setBarMuscleUps(p_barMuscleUps);
  }

  @Override
  public String imprimirTipo() {
    return "(Advanced)";
  }

  @Override
  public String mostrarDatos() {
    return String.format("%s ** Bar Muscle Ups realizados: %d %s", super.mostrarDatos(), this.getBarMuscleUps(),
        this.imprimirTipo());
  }
}
