import java.util.GregorianCalendar;
import java.util.Calendar;

public class MainEmpleadoConJefe {
  public static void main(String[] args) {
    Calendar fechaIngreso = new GregorianCalendar();
    fechaIngreso.set(2001, Calendar.SEPTEMBER, 2);

    EmpleadoConJefe bulgheri = new EmpleadoConJefe(
        12345,
        "Bulgheri",
        "Gregorio",
        150000,
        2000);

    EmpleadoConJefe empleado = new EmpleadoConJefe(
        12346,
        "Perez",
        "Juan",
        100000,
        fechaIngreso,
        bulgheri);

    empleado.mostrar();
    bulgheri.mostrar();
  }
}
