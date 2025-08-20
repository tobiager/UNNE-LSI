public class MainAlumno {
  public static void main(String[] args) {
    Alumno alumno = new Alumno(2020, "Juan", "Perez");
    alumno.setNota1(5.99);
    alumno.setNota2(10);
    alumno.mostrar();
    Alumno alumno2 = new Alumno(2051, "Maria", "Gomez");
    alumno2.setNota1(7.85);
    alumno2.setNota2(8.5);
    alumno2.mostrar();
  }
}
