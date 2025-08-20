public class MainEmpleado {
  public static void main(String[] args) {
    Empleado empleado = new Empleado(
        35123438,
        "Olivarez",
        "Alexis",
        20000,
        2002);
    empleado.mostrar();
    String mostrar = empleado.mostrarLinea();
    System.out.println(mostrar);
  }
}
