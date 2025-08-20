import java.util.ArrayList;

public class Banco {
  private String nombre;
  private int nroSucursal;
  private Localidad localidad;
  private ArrayList<Empleado> empleados;
  private ArrayList<CuentaBancaria> cuentaBancaria;

  /**
   * Constructor para los empleados de ArrayList.
   * 
   * @param p_nombre      Nombre del Banco de tipo String.
   * @param p_localidad   Localidad de tipo Localidad (Objeto).
   * @param p_nroSucursal Número de sucursal de tipo int.
   * @param p_empleados   Lista de empleados de tipo
   *                      ArrayList<Empleado>.
   */
  public Banco(String p_nombre, Localidad p_localidad, int p_nroSucursal, ArrayList<Empleado> p_empleados) {
    this.setNombre(p_nombre);
    this.setLocalidad(p_localidad);
    this.setNroSucursal(p_nroSucursal);
    this.setEmpleados(p_empleados);
    this.setCuentaBancaria(new ArrayList<CuentaBancaria>());
  }

  /**
   * Constructor para un solo empleado.
   * 
   * @param p_nombre      Nombre del Banco de tipo String.
   * @param p_localidad   Localidad de tipo Localidad (Objeto).
   * @param p_nroSucursal Número de sucursal de tipo int.
   * @param p_empleado    Un empleados de tipo Empleado (Objeto).
   */
  public Banco(String p_nombre, Localidad p_localidad, int p_nroSucursal, Empleado p_empleado) {
    this.setNombre(p_nombre);
    this.setLocalidad(p_localidad);
    this.setNroSucursal(p_nroSucursal);
    this.setEmpleados(new ArrayList<Empleado>());
    this.agregarEmpleado(p_empleado);
    this.setCuentaBancaria(new ArrayList<CuentaBancaria>());
  }

  /**
   * Constructor para una lista de empleados y una lista de cuentas bancarias.
   * 
   * @param p_nombre      Nombre del Banco de tipo String.
   * @param p_localidad   Localidad de tipo Localidad (Objeto).
   * @param p_nroSucursal Número de sucursal de tipo int.
   * @param p_empleado    Lista de empleados de tipo
   *                      ArrayList<Empleado>.
   * @param p_cuentas     Lista de cuentas bancarias de tipo
   *                      ArrayList<CuentaBancaria>
   */
  public Banco(String p_nombre, Localidad p_localidad, int p_nroSucursal, ArrayList<Empleado> p_empleados,
      ArrayList<CuentaBancaria> p_cuentas) {
    this.setNombre(p_nombre);
    this.setLocalidad(p_localidad);
    this.setNroSucursal(p_nroSucursal);
    this.setEmpleados(p_empleados);
    this.setCuentaBancaria(p_cuentas);
  }
  
    /**
   * Constructor con tres parámetros.
   * 
   * @param p_nombre      Nombre del Banco de tipo String.
   * @param p_localidad   Localidad de tipo Localidad (Objeto).
   * @param p_nroSucursal Número de sucursal de tipo int.
   */
  public Banco(String p_nombre, Localidad p_localidad, int p_nroSucursal) {
    this.setNombre(p_nombre);
    this.setLocalidad(p_localidad);
    this.setNroSucursal(p_nroSucursal);
    this.setEmpleados(new ArrayList<Empleado>());
    this.setCuentaBancaria(new ArrayList<CuentaBancaria>());
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
   * El método establece el valor del atributo "nroSucursal" de tipo int
   * proporcionado del valor "p_nroSucursal" de tipo int.
   * 
   * @param p_nroSucursal Representa el nuevo valor del atributo "nroSucursal" de
   *                      tipo int.
   * @return No devuelve ningún valor.
   */
  private void setNroSucursal(int p_nroSucursal) {
    this.nroSucursal = p_nroSucursal;
  }

  /**
   * El método establece el valor del atributo "localidad" de tipo Localidad
   * (Objeto) proporcionado del valor "p_localidad" de tipo Localidad (Objeto).
   * 
   * @param p_localidad Representa el nuevo valor del atributo "localidad" de
   *                    tipo Localidad (Objeto).
   * @return No devuelve ningún valor.
   */
  private void setLocalidad(Localidad p_localidad) {
    this.localidad = p_localidad;
  }

  /**
   * El método establece el valor del atributo "empleados" de tipo
   * ArrayList<Empleado> proporcionado del valor "p_empleados" de tipo
   * ArrayList<Empleado>.
   * 
   * @param p_empleados Representa el nuevo valor del atributo "empleados" de
   *                    tipo ArrayList<Empleado>.
   * @return No devuelve ningún valor.
   */
  private void setEmpleados(ArrayList<Empleado> p_empleados) {
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
   * Devuelve el valor del atributo "nroSucursal".
   * 
   * @return Devuelve un valor de tipo int.
   */
  public int getNroSucursal() {
    return this.nroSucursal;
  }

  /**
   * Devuelve el valor del atributo "localidad".
   * 
   * @return Devuelve un Objeto de tipo Localidad.
   */
  public Localidad getLocalidad() {
    return this.localidad;
  }

  /**
   * Devuelve el valor del atributo "empleados".
   * 
   * @return Devuelve un Objeto de tipo ArrayList<Empleado>.
   */
  public ArrayList<Empleado> getEmpleados() {
    return this.empleados;
  }

  /**
   * El método agrega un empleado al ArrayList<Empleado> y si lo agrega devuelve
   * true caso contrario false.
   * 
   * @param p_empleado El empleado que se agregará al ArrayList<Empleado> de tipo
   *                   Empleado (Objeto).
   * @return Devuelve un valor booleano (true o false).
   */
  public boolean agregarEmpleado(Empleado p_empleado) {
    return this.getEmpleados().add(p_empleado);
  }

  /**
   * El método quita un empleado del ArrayList<Empleado> y si lo quita devuelve
   * true caso contrario false.
   * 
   * @param p_empleado El empleado que se quitará del ArrayList<Empleado> de tipo
   *                   Empleado (Objeto).
   * @return Devuelve un valor booleano (true o false).
   */
  public boolean quitarEmpleado(Empleado p_empleado) {
    if (this.getEmpleados().size() == 1) {
      return false;
    }
    return this.getEmpleados().remove(p_empleado);
  }

  /**
   * El método acumula los sueldos netos de lista de empleados y devuelve el
   * total de la suma de todo los sueldos netos de lista de cada empleado.
   * 
   * @return Devuelve un valor de tipo double.
   */
  public double sueldosAPagar() {
    double totalPagar = 0;
    for (Empleado empleado : this.getEmpleados()) {
      totalPagar += empleado.sueldoNeto();
    }
    return totalPagar;
  }

  /**
   * El método muestra información del banco, cuil, apellido, nombre, y sueldo
   * neto de cada empleado y el total que deberá pagar la empresa.
   */
  public void listarSueldos() {
    System.out.format("\nBanco %s\tSucursal: %s\n", this.getNombre(), this.getNroSucursal());
    System.out.format("%s\n\n", this.getLocalidad().mostrar());
    for (Empleado empleado : this.getEmpleados()) {
      System.out.format("%s\n", empleado.mostrarLinea());
    }
    System.out.format("\nTotal a Pagar:------------------------------ $%s\n", this.sueldosAPagar());
  }

  /**
   * El método establece el valor del atributo "cuentaBancaria" de tipo
   * ArrayList<CuentaBancaria> proporcionado del valor "p_cuentaBancaria"
   * de tipo ArrayList<CuentaBancaria>.
   * 
   * @param p_cuentaBancaria Representa el nuevo valor del atributo
   *                         "cuentaBancaria" de tipo ArrayList<CuentaBancaria>
   *                         .
   * @return No devuelve ningún valor.
   */
  public void setCuentaBancaria(ArrayList<CuentaBancaria> p_cuentaBancaria) {
    this.cuentaBancaria = p_cuentaBancaria;
  }

  /**
   * Devuelve el valor del atributo "cuentaBancaria".
   * 
   * @return Devuelve un Objeto de tipo ArrayList<CuentaBancaria>.
   */
  public ArrayList<CuentaBancaria> getCuentaBancaria() {
    return this.cuentaBancaria;
  }

  /**
   * El método agrega una cuenta bancaria al ArrayList<CuentaBancaria> y si lo
   * agrega devuelve true caso contrario false.
   * 
   * @param p_empleado La cuenta que se agregará al ArrayList<CuentaBancaria> de
   *                   tipo CuentaBancaria (Objeto).
   * @return Devuelve un valor booleano (true o false).
   */
  public boolean agregarCuentaBancaria(CuentaBancaria p_cuenta) {
    return this.getCuentaBancaria().add(p_cuenta);
  }

  /**
   * El método quita una cuenta bancaria del ArrayList<CuentaBancaria> y si lo
   * quita devuelve true caso contrario false.
   * 
   * @param p_cuentaBancaria El cuenta que se quitará del
   *                         ArrayList<CuentaBancaria>de tipo CuentaBancaria
   *                         (Objeto).
   * @return Devuelve un valor booleano (true o false).
   */
  public boolean quitarCuentaBancaria(CuentaBancaria p_cuenta) {
    return this.getCuentaBancaria().remove(p_cuenta);
  }

  /**
   * El método "mostrarSaldoCero" Muestra una lista de las cuentas con saldo en
   * 0, número de cuenta, apellido y nombre del titular de la cuenta.
   */
  private void mostrarSaldoCero() {
    System.out.println("------------------------------------------------------");
    System.out.println("Titulares con Cuenta en Saldo Cero");
    System.out.println("------------------------------------------------------");
    if (this.getCuentaBancaria().size() - this.cuentasSaldoActivo() == 0) {
      System.out.println("No hay cuentas con saldo cero");
      System.out.println("------------------------------------------------------");
      return;
    }
    for (CuentaBancaria cuenta : this.getCuentaBancaria()) {
      if (cuenta.getSaldo() == 0) {
        System.out.format("%s\t%s\n", cuenta.getNroCuenta(), cuenta.getTitular().apeYNom());
      }
    }
    System.out.println("------------------------------------------------------");
  }

  /**
   * Devuelve la cantidad de cuentas activas (Saldo mayor a 0).
   * 
   * @return Devuelve un entero.
   */
  private int cuentasSaldoActivo() {
    int cuentasActivas = 0;
    for (CuentaBancaria cuenta : this.getCuentaBancaria()) {
      if (cuenta.getSaldo() > 0) {
        cuentasActivas += 1;
      }
    }
    return cuentasActivas;
  }

  /**
   * El método muestra un resumen de las cuentas bancarias.
   * - Número total de Cuentas Bancarias.
   * - Cuentas Activas.
   * - Cuentas Saldo Cero.
   */
  public void mostrarResumen() {
    System.out.println("************************************************************");
    System.out.println("RESUMEN DE CUENTAS BANCARIAS");
    System.out.println("************************************************************");
    System.out.format("Número total de Cuentas Bancarias: %s\n", this.getCuentaBancaria().size());
    System.out.format("Cuentas Activas: %s\n", this.cuentasSaldoActivo());
    System.out.format("Cuentas Saldo Cero: %s\n", this.getCuentaBancaria().size() - this.cuentasSaldoActivo());
  }

  /**
   * Muestra datos del banco, un resumen de las cuentas bancarias y una lista de
   * las cuentas de saldo en 0.
   */
  public void mostrar() {
    System.out.format("Banco %s\tSucursal: %s\n", this.getNombre(), this.getNroSucursal());
    System.out.format("%s\n", this.getLocalidad().mostrar());
    this.mostrarResumen();
    this.mostrarSaldoCero();
  }
}



