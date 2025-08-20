import java.util.HashMap;

public class Comercio {
  private String nombre;
  private HashMap<Long, Empleado> empleados;

  /**
   * Constructor para una colección de empleados vacia.
   * 
   * @param p_nombre Nombre del Comercio de tipo String.
   */
  public Comercio(String p_nombre) {
    this.setNombre(p_nombre);
    this.setEmpleados(new HashMap<Long, Empleado>());
  }

  /**
   * Constructor para una colección de empleados.
   * 
   * @param p_nombre   Nombre del Comercio de tipo String.
   * @param p_empleado Colección de empleados de tipo
   *                   HashMap<Long, Empleado>.
   */
  public Comercio(String p_nombre, HashMap<Long, Empleado> p_empleados) {
    this.setNombre(p_nombre);
    this.setEmpleados(p_empleados);
  }

  /**
   * El método establece el valor del atributo "nombre" de tipo String
   * proporcionado del valor "p_nombre" de tipo String.
   * 
   * @param p_nombre Representa el nuevo valor del atributo "nombre" de tipo
   *                 String.
   * @return No devuelve ningún valor.
   */
  private void setNombre(String p_nombre) {
    this.nombre = p_nombre;
  }

  /**
   * El método establece el valor del atributo "empleados" de tipo
   * HashMap<Long, Empleado> proporcionado del valor "p_empleados" de tipo
   * HashMap<Long, Empleado>.
   * 
   * @param p_empleados Representa el nuevo valor del atributo "empleados" de tipo
   *                    HashMap<Long, Empleado>.
   * @return No devuelve ningún valor.
   */
  private void setEmpleados(HashMap<Long, Empleado> p_empleados) {
    this.empleados = p_empleados;
  }

  /**
   * Devuelve el valor del atributo "nombre".
   * 
   * @return Devuelve un valor de tipo String.
   */
  public String getNombre() {
    return this.nombre;
  }

  /**
   * Devuelve el valor del atributo "empleados".
   * 
   * @return Devuelve una colección de tipo HashMap<Long, Empleado>.
   */
  public HashMap<Long, Empleado> getEmpleados() {
    return this.empleados;
  }

  /**
   * El método agrega un empleado a una colección de empleados
   * usando su único identificador como clave.
   *
   * @param p_empleado Es un objeto de tipo "Empleado".
   */
  public void altaEmpleado(Empleado p_empleado) {
    this.getEmpleados().put(p_empleado.getCuil(), p_empleado);
  }

  /**
   * El método elimina un empleado de una lista de empleados y
   * devuelve el empleado eliminado.
   *
   * @param p_cuil Es de tipo long y representa el CUIL (Clave Única de
   *               Identificación Laboral) de un empleado a dar de baja.
   * @return Retorna un objeto de tipo Empleado.
   */
  public Empleado bajaEmpleado(long p_cuil) {
    Empleado bajaEmpleado = this.buscarEmpleado(p_cuil);
    this.getEmpleados().remove(p_cuil);
    return bajaEmpleado;
  }

  /**
   * El método devuelve el número de empleados.
   *
   * @return El tamaño de la lista de empleados.
   */
  public int cantidadDeEmpleados() {
    return this.getEmpleados().size();
  }

  /**
   * El método comprueba si un determinado cuil está presente en la lista de
   * empleados.
   *
   * @param p_cuil Es de tipo long y representa el CUIL (Clave Única de
   *               Identificación Laboral) de un empleado.
   * @return Devuelve un valor booleano.
   */
  public boolean esEmpleado(long p_cuil) {
    return this.getEmpleados().containsKey(p_cuil);
  }

  /**
   * El métdodo busca un empleado en función de su cuil y devuelve el objeto
   * empleado correspondiente.
   *
   * @param p_cuil Es de tipo long y representa el CUIL (Clave Única de
   *               Identificación Laboral) de un empleado.
   * @return Devuelve un objeto de tipo Empleado.
   */
  public Empleado buscarEmpleado(long p_cuil) {
    return this.getEmpleados().get(p_cuil);
  }

  /**
   * El método calcula e imprime el salario neto de un empleado basado en su
   * CUIL.
   *
   * @param p_cuil Representa la CUIL (Clave Única de
   *               Identificación Laboral) de un empleado. Se utiliza para buscar
   *               al empleado y calcular su salario neto.
   */
  public void sueldoNeto(long p_cuil) {
    Empleado empleado = this.buscarEmpleado(p_cuil);
    if (empleado == null) {
      System.out.format("No se encontró ningún empleado con el cuil %s\n", p_cuil);
      return;
    }
    System.out.format("El sueldo neto de %s es de %s", empleado.nomYApe(), empleado.sueldoNeto());
  }

  /**
   * El método imprime la información de nómina de los empleados de una empresa.
   */
  public void nomina() {
    if (this.getEmpleados().isEmpty()) {
      System.out.println("No hay empleados!\n");
      return;
    }
    System.out.format("**** Nomina de empleados de %s ****\n", this.getNombre());
    for (Empleado empleado : this.getEmpleados().values()) {
      System.out.println(empleado.mostrarLinea());
    }
    
  }
}