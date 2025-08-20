public class Carrera {
  public static void main(String[] args) {
    // Crear una instancia de Curso y varias de la clase Alumno...
    Curso curso = new Curso("Curso de Programación");
    Alumno pedro = new Alumno(32555, "Pedro", "Gomez");
    Alumno maria = new Alumno(23564, "Maria", "Vasquez");
    Alumno juan = new Alumno(30123, "Juan", "Perez");
    Alumno marcela = new Alumno(32655, "Marcela", "Martinez");
    // Asignarles notas de parciales a los alumnos...
    pedro.setNota1(7);
    pedro.setNota2(7);
    maria.setNota1(6);
    maria.setNota2(5);
    juan.setNota1(7);
    juan.setNota2(9);
    marcela.setNota1(10);
    marcela.setNota2(10);
    // Asignarles notas de parciales a los alumnos...
    curso.inscribirAlumno(pedro);
    curso.inscribirAlumno(maria);
    curso.inscribirAlumno(juan);
    curso.inscribirAlumno(marcela);
    // Imprimir la cantidad y la lista de alumnos inscriptos al curso...
    System.out.format("****-- Cantidad de inscriptos: %s\n", curso.cantidadDeAlumnos());
    curso.mostrarInscriptos();
    // Dar de baja un alumno del curso, y luego verificar que no esté inscripto
    System.out.format("\n****-- Se da de baja a Pedro porque abandona el curso --****\n");
    curso.quitarAlumno(32555);
    System.out.format("Está Pedro Gomez inscripto? -> %s\n\n", curso.estaInscripto(pedro));
    // Imprimir nuevamente la lista de alumnos para ver como que queda
    // definitivamente y la cantidad total de alumnos inscriptos en el curso...
    System.out.format("****-- Alumnos inscriptos actualmente: %s\n", curso.cantidadDeAlumnos());
    curso.mostrarInscriptos();
    // Buscar un alumno por su libreta. Una vez encontrado,
    // mostrarlo con el método apropiado.
    int buscarLu = 30123;
    System.out.format("\n****-- Busca y muestra el alumno con numero de libreta %s --****\n", buscarLu);
    Alumno buscar = curso.buscarAlumno(buscarLu);
    buscar.mostrar();
    // Mostrar el promedio del alumno solicitado, según libreta
    int alumnoLu = maria.getLu();
    System.out.format("\n****-- Mostrar promedio del alumno %s --****\n", alumnoLu);
    curso.imprimirPromedioDelAlumno(alumnoLu);
  }
}