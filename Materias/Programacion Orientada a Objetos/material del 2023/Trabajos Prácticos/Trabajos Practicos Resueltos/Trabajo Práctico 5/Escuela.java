public class Escuela {
  public static void main(String[] args) {
    Persona persona = new Persona(25365902, "Juan", "Perez", 1983);
    Alumno alumno = new Alumno(1234, 44542230, "Alexis", "Olivarez", 2002);
    alumno.setNota1(5);
    alumno.setNota2(9);

    persona.mostrar();
    System.out.println();
    alumno.mostrar();
  }
}
