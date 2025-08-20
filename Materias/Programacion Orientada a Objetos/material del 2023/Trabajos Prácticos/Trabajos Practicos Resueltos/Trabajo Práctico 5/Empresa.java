import java.util.Calendar;

public class Empresa {
  public static void main(String[] args) {
    Persona persona1 = new Persona(44542231, "Juan", "Pérez", 1983);
    Empleado empleado1 = new Empleado(445422306, 44542230, "Olivarez", "Alexis", 2002, 120000, Calendar.getInstance());

    System.out.println("Información de la persona:");
    persona1.mostrar();

    System.out.println("\nInformación del empleado:");
    empleado1.mostrar();
  }
}
