
import java.util.ArrayList;

public class Gerencia {
  private String nombre;
  private ArrayList<Alojamiento> alojamientoAlquilados;

  /**
   * Constructor de la clase Gerencia.
   * 
   * @param p_nombre El nombre de la gerencia (String).
   */
  public Gerencia(String p_nombre) {
    this.setNombre(p_nombre);
    this.setAlojamientoAlquilados(new ArrayList<Alojamiento>());
  }

  /**
   * Constructor de la clase Gerencia.
   * 
   * @param p_nombre                El nombre de la gerencia (String).
   * @param p_alojamientoAlquilados Una lista de alojamientos
   *                                (ArrayList<Alojamiento>).
   */
  public Gerencia(String p_nombre, ArrayList<Alojamiento> p_alojamientoAlquilados) {
    this.setNombre(p_nombre);
    this.setAlojamientoAlquilados(p_alojamientoAlquilados);
  }

  /**
   * Establece el nombre de la gerencia.
   *
   * @param p_nombre El nombre de la gerencia (String).
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * Asigna una lista de alojamientos alquilados.
   *
   * @param p_alojamientoAlquilados Una lista de alojamientos alquilados
   *                                (ArrayList<Alojamiento>).
   */
  private void setAlojamientoAlquilados(ArrayList<Alojamiento> p_alojamientoAlquilados) {
    this.alojamientoAlquilados = p_alojamientoAlquilados;
  }

  /**
   * Obtiene el nombre de la gerencia.
   *
   * @return El nombre de la gerencia (String).
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Obtiene una lista de los alojamientos alquilados.
   * 
   * @return La cantidad de alojamientos alquilados (ArrayList<Alojamiento>).
   */
  public ArrayList<Alojamiento> getAlojamientoAlquilados() {
    return this.alojamientoAlquilados;
  }

  /**
   * Agrega un alojamiento a la lista de alojamientos de la gerencia.
   *
   * @param p_alojamiento El alojamiento que se va a agregar a la gerencia
   *                      (Alojamiento).
   */
  public boolean agregarAlojamiento(Alojamiento p_alojamiento) {
    return this.getAlojamientoAlquilados().add(p_alojamiento);
  }

  /**
   * Quita un alojamiento a la lista de alojamientos de la gerencia.
   *
   * @param p_alojamiento El alojamiento que se va a agregar a la gerencia
   *                      (Alojamiento).
   */
  public boolean quitarAlojamiento(Alojamiento p_alojamiento) {
    return this.getAlojamientoAlquilados().remove(p_alojamiento);
  }

  /**
   * Cuenta la cantidad de alojamientos alquilados que coinciden con un tipo de
   * alojamiento especificado.
   *
   * @param p_tipoAlojamiento El tipo de alojamiento a buscar (String).
   * @return El número de alojamientos alquilados que coinciden con el tipo
   *         especificado.
   */
  public int contarAlojamientos(String p_tipoAlojamiento) {
    int contador = 0;
    for (Alojamiento alojamiento : this.getAlojamientoAlquilados()) {
      contador += alojamiento.contar(p_tipoAlojamiento);
    }
    return contador;
  }

  /**
   * Imprime por pantalla el nombre del alojamiento, el costo por los dias
   * alquilados y la lista de todos los servicios alquilados de cada alojamiento
   * alquilado.
   */
  public void liquidar() {
    for (Alojamiento alojamiento : this.getAlojamientoAlquilados()) {
      alojamiento.liquidar();
      System.out.println();
    }
  }

  /**
   * Imprime por pantalla el nombre de la gerencia y la liquidación.
   */
  public void mostrarLiquidacion() {
    System.out.format("Gerencia %s\nLiquidación-------------------\n\n", this.getNombre());
    this.liquidar();
    System.out.println("Alojamiento tipo Cabaña: " + this.contarAlojamientos("Cabaña"));
    System.out.println("Alojamiento tipo Hotel: " + this.contarAlojamientos("Hotel"));
  }
}
