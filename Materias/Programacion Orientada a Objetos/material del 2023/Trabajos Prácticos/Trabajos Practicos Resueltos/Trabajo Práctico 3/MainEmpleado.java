import java.util.Calendar;
import java.util.GregorianCalendar;

public class MainEmpleado {
  public static void main(String[] args) {
    Calendar fechaIngreso = new GregorianCalendar();
    fechaIngreso.set(2000, Calendar.SEPTEMBER, 8);
    
    Empleado empleado = new Empleado(
        35123438,
        "Olivarez",
        "Alexis",
        20000,
        fechaIngreso);

    if (empleado.esAniversario()) {
      System.out.println("Puede salir una hora antes por que hoy cumple 1 año más en nuestra empresa!");
    }
    empleado.mostrar();
    String mostrar = empleado.mostrarLinea();
    System.out.println(mostrar);
    
    Empleado empleado2 = new Empleado(
        67345352,
        "Perez",
        "Jose",
        20000,
        2000);
    
    empleado2.mostrar();
    String mostrar2 = empleado2.mostrarLinea();
    System.out.println(mostrar);
  }
}
