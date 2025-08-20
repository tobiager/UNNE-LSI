/**
 * Ejercicio 10, clase Mujer.
 * 
 * @author Olivarez Alexis E.
 */
public class Mujer {
  private String nombre;
  private String apellido;
  private int edad;
  private String estadoCivil;
  private Hombre esposo;

  /**
   * Constructor de la clase Mujer.
   * 
   * @param pNombre   El nombre de la Mujer.
   * @param pApellido El apellido de la Mujer.
   * @param pEdad     El edad de la Mujer.
   */
  Mujer(String pNombre, String pApellido, int pEdad) {
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setEdad(pEdad);
    this.setEstadoCivil("Soltera");
  }

  /**
   * Constructor de la clase Mujer.
   * 
   * @param pNombre   El nombre de la Mujer.
   * @param pApellido El apellido de la Mujer.
   * @param pEdad     El edad de la Mujer.
   * @param pEsposo   Hombre con la que esta casada.
   */
  Mujer(String pNombre, String pApellido, int pEdad, Hombre pEsposo) {
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setEdad(pEdad);
    this.casarseCon(pEsposo);
  }

  /**
   * El método establece el valor del atributo "nombre" proporcionado
   * del valor "pNombre".
   *
   * @param pNombre Es un String que representa el nuevo valor para el
   *                atributo "nombre".
   *                Debe ser un String no nulo y no vacío.
   */
  private void setNombre(String pNombre) {
    this.nombre = pNombre;
  }

  /**
   * El método establece el valor del atributo "apellido" proporcionado
   * del valor "pApellido".
   *
   * @param pApellido Es un String que representa el nuevo valor para el
   *                  atributo "apellido".
   *                  Debe ser un String no nulo y no vacío.
   */
  private void setApellido(String pApellido) {
    this.apellido = pApellido;
  }

  /**
   * El método establece el valor del atributo "edad" proporcionado
   * del valor "pEdad".
   *
   * @param pEdad Es un entero que representa el nuevo valor para el atributo "edad".
   */
  private void setEdad(int pEdad) {
    this.edad = pEdad;
  }

  /**
   * El método establece el valor del atributo "estadoCivil" proporcionado
   * del valor "pEstadoCivil".
   *
   * @param pEstadoCivil Es un String que representa el nuevo valor para el
   *                     atributo "estadoCivil".
   *                     Debe ser un String no nulo y no vacío.
   */
  private void setEstadoCivil(String pEstadoCivil) {
    this.estadoCivil = pEstadoCivil;
  }

  /**
   * El método establece el valor del atributo "pEsposo" proporcionado
   * del valor "pEsposo".
   *
   * @param pEsposo Es un Objeto que representa el nuevo valor para el
   *                atributo "esposo" de tipo Esposo (Objeto).
   */
  private void setEsposo(Hombre pEsposo) {
    this.esposo = pEsposo;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "nombre".
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "apellido".
   */
  public String getApellido() {
    return this.apellido;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "edad".
   */
  public int getEdad() {
    return this.edad;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "estadoCivil".
   */
  public String getEstadoCivil() {
    return this.estadoCivil;
  }

  /**
   * @return Devuelve el valor actual de la variable de instancia "esposo" que es
   *         un objeto de tipo Hombre.
   */
  public Hombre getEsposo() {
    return this.esposo;
  }

  /**
   * Nuevo valor el atributo "esposo" a la Hombre que se le pase por parámetro y
   * su estado civil cambia a "Casada".
   * 
   * @param pEsposo Hombre con la que se va a casar de tipo Objeto Hombre.
   */
  public void casarseCon(Hombre pEsposo) {
    this.setEsposo(pEsposo);
    this.setEstadoCivil("Casada");
  }

  /**
   * Nuevo valor el atributo "esposo" se lo iguala a null y su estado
   * civil cambia a "Divorciada".
   */
  public void divorcio() {
    this.setEsposo(null);
    this.setEstadoCivil("Divorciada");
  }

  /**
   * @return Cadena de texto concatenando nombre, apellido y edad de la mujer.
   */
  public String datos() {
    return String.format("%s %s de %s años", this.getNombre(), this.getApellido(), this.getEdad());
  }

  /**
   * El método "mostrarEstadoCivil" imprime el nombre, apellido y edad de la mujer
   * y su estado civil.
   */
  public void mostrarEstadoCivil() {
    System.out.println(String.format("%s - %s", this.datos(), this.getEstadoCivil()));
  }

  /**
   * El método "casadaCon" imprime el datos de la mujer (nombre, apellido, edad) y
   * del hombre (nombre, apellido, edad) con la que esta casado.
   */
  public void casadaCon() {
    System.out.println(String.format("%s está casada con %s.", this.datos(), this.getEsposo().datos()));
  }
}
