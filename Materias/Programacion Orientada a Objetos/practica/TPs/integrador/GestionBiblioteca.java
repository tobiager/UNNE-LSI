import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;
import java.util.GregorianCalendar;

/**
 * Programa ejecutable que administra una
 * biblioteca, agregando socios, libros y
 * creando prestamos
 */
public class GestionBiblioteca {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        Calendar fecha_inicial = Calendar.getInstance();
        
        Biblioteca biblioteca = new Biblioteca("Biblioteca Central");
        
        biblioteca.nuevoLibro("Progamando con Java", 1, "Fuente", 2008);
        biblioteca.nuevoLibro("POO avanzado", 2, "TechBooks", 2004);
        biblioteca.nuevoLibro("el extranjero", 2, "sudestada", 2001);
        biblioteca.nuevoLibro("la nausea", 1, "caseres", 2009);
        biblioteca.nuevoLibro("Biologia II", 4, "Sevilla", 2012);
        
        biblioteca.nuevoSocioDocente(1111, "Matias", "Filosofia");
        biblioteca.nuevoSocioEstudiante(2222, "Agustin", "Biologia");
        biblioteca.nuevoSocioEstudiante(3333, "Nahuel", "Sistemas");
        biblioteca.nuevoSocioEstudiante(4444, "Alejandro", "Artes");
        biblioteca.nuevoSocioEstudiante(5555, "Maxi", "Matematica");
        biblioteca.nuevoSocioDocente(6666, "Tobias", "Derecho");
        
        
        //prestamo vencidos
        Libro unLibro = biblioteca.getLibros().get(1);
        Socio unDocente = biblioteca.getSocios().get(0);
        Calendar fecha_vencido = (Calendar)(new GregorianCalendar(2024, 1, 10));
        
        biblioteca.prestarLibro(fecha_vencido, unDocente, unLibro);
        try{
            biblioteca.devolverLibro(biblioteca.getLibros().get(1));
        }catch(LibroNoPrestadoException e){
            System.out.println(e.getMessage());
        }
        
        int option;
        
        do {
            System.out.println("===== MENÚ DE BIBLIOTECA =====");
            System.out.println("1. Agregar un nuevo libro");
            System.out.println("2. Agregar un nuevo socio docente");
            System.out.println("3. Agregar un nuevo socio estudiante");
            System.out.println("4. Prestar un libro");
            System.out.println("5. Devolver un libro");
            System.out.println("6. Mostrar cantidad de socios por tipo");
            System.out.println("7. Listar préstamos vencidos");
            System.out.println("8. Listar docentes responsables");
            System.out.println("9. Consultar quién tiene un libro");
            System.out.println("10. Listar todos los socios");
            System.out.println("11. Listar todos los libros");
            System.out.println("0. Salir");
            System.out.print("Seleccione una opción: ");
            
            option = scanner.nextInt();
            scanner.nextLine();
            
            switch (option) {
                //********************agregar libro********************
                case 1:
                    System.out.print("--Ingrese el título del libro: ");
                    String titulo = scanner.nextLine();
                    
                    System.out.print("--Ingrese la edición del libro: ");
                    int edicion = scanner.nextInt();
                    scanner.nextLine();
                    
                    System.out.print("--Ingrese la editorial del libro: ");
                    String editorial = scanner.nextLine();
                    
                    System.out.print("--Ingrese el año de publicación del libro: ");
                    int anio = scanner.nextInt();
                    biblioteca.nuevoLibro(titulo, edicion, editorial, anio);
                    
                    System.out.println("--Libro agregado exitosamente.");
                    break;
                //********************agregar docente********************
                case 2:
                    System.out.print("--Ingrese el DNI del socio docente: ");
                    int dniDocente = scanner.nextInt();
                    scanner.nextLine();
                    
                    System.out.print("--Ingrese el nombre del docente: ");
                    String nombreDocente = scanner.nextLine();
                    
                    System.out.print("--Ingrese el área del docente: ");
                    String area = scanner.nextLine();
                    
                    biblioteca.nuevoSocioDocente(dniDocente, nombreDocente, area);
                    System.out.println("--Socio docente agregado exitosamente.");
                    
                    break;
                //********************agregar estudiante********************
                case 3: 
                    System.out.print("--Ingrese el DNI del socio estudiante: ");
                    int dniEstudiante = scanner.nextInt();
                    scanner.nextLine();
                    
                    System.out.print("--Ingrese el nombre del estudiante: ");
                    String nombreEstudiante = scanner.nextLine();
                    
                    System.out.print("--Ingrese la carrera del estudiante: ");
                    String carrera = scanner.nextLine();
                    
                    biblioteca.nuevoSocioEstudiante(dniEstudiante, nombreEstudiante, carrera);
                    System.out.println("--Socio estudiante agregado exitosamente.");
                    break;
                
                //********************prestar libro********************
                case 4:
                    {
                        int socio_seleccionado = 0;
                        int libro_seleccionado = 0;
                        
                        //seleccionar libro por prestar
                        int i = 0;
                        ArrayList<Libro> libros = biblioteca.getLibros();
                        System.out.println("--libros disponibles: ");
                        for(Libro l : libros){
                            System.out.println("\t" + i + ". " + l.getTitulo());
                            i++;
                        }
                        System.out.print("--ingrese el libro por prestar: ");
                        libro_seleccionado = scanner.nextInt();
                        
                        if( !(libro_seleccionado >= 0 && libro_seleccionado < libros.size()) ){
                            System.out.println("--Ingreso invalido.");
                            continue;
                        }
                        Libro libroSeleccionado = libros.get(libro_seleccionado);
                        
                        if (libroSeleccionado.prestado()) {
                            System.out.println("--El libro '" + libroSeleccionado.getTitulo() + "' ya está prestado y no se puede prestar nuevamente.");
                            break;
                        }
                        //seleccionar socio al que prestar
                        i = 0;
                        ArrayList<Socio> socios = biblioteca.getSocios();
                        System.out.println("--socios disponibles: ");
                        for(Socio s : socios){
                            System.out.println("\t" + i + ". " + s.getNombre());
                            i++;
                        }
                        System.out.print("--ingrese socio al que prestar: ");
                        socio_seleccionado = scanner.nextInt();
                        
                        if( !(socio_seleccionado >= 0 && socio_seleccionado < socios.size()) ){
                            System.out.println("--Ingreso invalido.");
                            continue;
                        }
                        
                        //realizar el prestamo
                        Socio socio = socios.get(socio_seleccionado);                    
                        fecha_inicial.add(Calendar.DATE, 3);
                        Calendar fechaRetiro = fecha_inicial;
                        
                        biblioteca.prestarLibro(fechaRetiro, socio, libros.get(libro_seleccionado));
                        System.out.println("--Préstamo realizado exitosamente.");
                    }
                    
                    break;
                //********************devolver libro********************
                case 5:
                    
                   {
                        int libro_seleccionado = 0;
                        
                        //seleccionar libro a devolver
                        int i = 0;
                        ArrayList<Libro> libros = biblioteca.getLibros();
                        System.out.println("--libros disponibles: ");
                        for(Libro l : libros){
                            System.out.println("\t" + i + ". " + l.getTitulo());
                            i++;
                        }
                        System.out.print("--ingrese el libro a devolver: ");
                        libro_seleccionado = scanner.nextInt();
                        
                        // Verificar que la selección esté en el rango de índices válidos
                            if (libro_seleccionado >= 0 && libro_seleccionado < libros.size()) {
                                // Intentar devolver el libro
                                Libro libro = libros.get(libro_seleccionado);
                                try {
                                    biblioteca.devolverLibro(libro);
                                    System.out.println("-- Libro devuelto exitosamente");
                                } catch (LibroNoPrestadoException e) {
                                    System.out.println(e.getMessage());
                                }
                                break;
                            } else {
                                System.out.println("-- Selección inválida. Por favor, elija un número dentro del rango.");
                            }
                        
                        
                    }
                    
                    break;  
                //********************mostrar socio por tipo********************
                case 6:
                    System.out.print("--Ingrese el tipo de socio (Docente o Estudiante): ");
                    String tipoSocio = scanner.nextLine();
                    int cantidadSocios = biblioteca.cantidadDeSociosPorTipo(tipoSocio);
                    System.out.println("Cantidad de socios del tipo " + tipoSocio + ": " + cantidadSocios);
                    break;
                
                //********************mostrar prestamos vencidos********************
                case 7:
                    ArrayList<Prestamo> prestamosVencidos = biblioteca.prestamosVencidos();
                    if (prestamosVencidos.isEmpty()) {
                        System.out.println("--No hay préstamos vencidos.");
                    } else {
                        System.out.println("--Préstamos vencidos:");
                        for (Prestamo prestamo : prestamosVencidos) {
                            System.out.println(prestamo.toString());
                        }
                    }
                    break;
                
                //********************mostrar docentes deudores********************
                case 8: 
                    ArrayList<Socio> docentesResponsables = biblioteca.docentesResponsables();
                    if (docentesResponsables.isEmpty()) {
                        System.out.println("--No hay docentes con libros pendientes.");
                    } else {
                        System.out.println(biblioteca.listaDeDocentesResponsables());
                    }
                    break;
                
                //********************consultar quien tiene libro********************
                case 9:
                    System.out.println("--Seleccione al libro a consultar: ");
                    
                    int libro_seleccionado = 0;
                    int i = 0;
                    ArrayList<Libro> libros = biblioteca.getLibros();
                    for(Libro l : libros){
                        System.out.println("--" + i + ". " + l.getTitulo());
                        i++;
                    }
                    libro_seleccionado = scanner.nextInt();
                    
                    if(!(libro_seleccionado >= 0 && libro_seleccionado < libros.size())){
                        System.out.println("--Ingreso invalido.");
                        continue;
                    }
                    
                    Libro libroConsulta = libros.get(libro_seleccionado);
                    try {
                        System.out.println(biblioteca.quienTieneElLibro(libroConsulta));
                    } catch (LibroNoPrestadoException e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                
                    //********************listar socios********************
                case 10:
                    System.out.println(biblioteca.listaDeSocios());
                    break;
                    //********************listar socios********************
                case 11:
                    System.out.println(biblioteca.listaDeLibros());
                    break;
                    //********************salir********************
                case 0:
                    System.out.println("--Saliendo del sistema de biblioteca.");
                    break;

                default:
                    System.out.println("--Opción no válida. Intente nuevamente.");
                    break;
            }
        }while (option != 0);
    }
    
}
