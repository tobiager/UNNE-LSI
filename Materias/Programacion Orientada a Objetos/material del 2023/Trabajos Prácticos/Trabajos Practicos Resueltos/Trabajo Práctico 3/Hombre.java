/**
 * Ejercicio 10, clase Hombre.
 * 
 * @author Olivarez Alexis E.
 */
public class Hombre {
  private String nombre;
  private String apellido;
  private int edad;
  private String estadoCivil;
  private Mujer esposa;

  /**
   * Constructor de la clase Hombre.
   * 
   * @param pNombre   El nombre del hombre.
   * @param pApellido El apellido del Hombre.
   * @param pEdad     El edad del Hombre.
   */
  Hombre(String pNombre, String pApellido, int pEdad) {
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setEdad(pEdad);
    this.setEstadoCivil("Soltero");
  }

  /**
   * Constructor de la clase Hombre.
   * 
   * @param pNombre   El nombre del hombre.
   * @param pApellido El apellido del Hombre.
   * @param pEdad     El edad del Hombre.
   * @param pEsposa   Mujer con la que esta casado.
   */
  Hombre(String pNombre, String pApellido, int pEdad, Mujer pEsposa) {
    this.setNombre(pNombre);
    this.setApellido(pApellido);
    this.setEdad(pEdad);
    this.casarseCon(pEsposa);
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
   * El método establece el valor del atributo "esposa" proporcionado
   * del valor "pEsposa".
   *
   * @param pEsposa Es un Objeto que representa el nuevo valor para el
   *                atributo "esposo" de tipo Esposa (Objeto).
   */
  private void setEsposa(Mujer pEsposa) {
    this.esposa = pEsposa;
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
   * @return Devuelve el valor actual de la variable de instancia "esposa" que es
   *         un objeto de tipo Mujer.
   */
  public Mujer getEsposa() {
    return this.esposa;
  }

  /**
   * Nuevo valor el atributo "esposa" a la Mujer que se le pase por parámetro y su
   * estado civil cambia a "Casado".
   * 
   * @param pEsposa Mujer con la que se va a casar de tipo Objeto Mujer.
   */
  public void casarseCon(Mujer pEsposa) {
    this.setEsposa(pEsposa);
    this.setEstadoCivil("Casado");
  }

  /**
   * Nuevo valor el atributo "esposa" se lo iguala a null y su estado
   * civil cambia a "Divorciado".
   */
  public void divorcio() {
    this.setEsposa(null);
    this.setEstadoCivil("Divorciado");
  }

  /**
   * @return Cadena de texto concatenando nombre, apellido y edad del hombre.
   */
  public String datos() {
    return String.format("%s %s de %s años", this.getNombre(), this.getApellido(), this.getEdad());
  }

  /**
   * El método "mostrarEstadoCivil" imprime el nombre, apellido y edad del hombre
   * y su estado civil.
   */
  public void mostrarEstadoCivil() {
    System.out.println(String.format("%s - %s", this.datos(), this.getEstadoCivil()));
  }

  /**
   * El método "casadoCon" imprime el datos del hombre (nombre, apellido, edad) y
   * de la mujer (nombre, apellido, edad) con la que esta casado.
   */
  public void casadoCon() {
    System.out.println(String.format("%s está casado con %s.", this.datos(), this.getEsposa().datos()));
  }
}
