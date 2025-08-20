import java.util.*;
/**
 * Write a description of class Biblioteca here.
 * 
 * @author (Noir Nahuel) 
 * @version (1.0.1)
 */
public class Biblioteca
{
    private String nombre;
    private ArrayList<Socio> socios;
    private ArrayList<Libro> libros;
    
    /**
     * Constructor que inicializa una biblioteca con un nombre, una lista de socios y una lista de libros.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socios Lista de socios de la biblioteca.
     * @param p_libros Lista de libros disponibles en la biblioteca.
     */
    public Biblioteca(String p_nombre, ArrayList<Socio> p_socios, ArrayList<Libro> p_libros){
        this.setNombre(p_nombre);
        this.setSocios(p_socios);
        this.setLibros(p_libros);
    }
    
    /**
     * Constructor que inicializa una biblioteca con un nombre y una lista de socios.
     * Se inicializa una lista vacía de libros.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socios Lista de socios de la biblioteca.
     */
    public Biblioteca(String p_nombre, ArrayList<Socio> p_socios){
        this.setNombre(p_nombre);
        this.setSocios(p_socios);
        this.setLibros(new ArrayList<Libro>());
    }
      
    /**
     * Constructor que inicializa una biblioteca con una lista de libros y un nombre.
     * Se inicializa una lista vacía de socios.
     * @param p_libros Lista de libros disponibles en la biblioteca.
     * @param p_nombre Nombre de la biblioteca.
     */
    public Biblioteca(ArrayList<Libro> p_libros, String p_nombre){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.setLibros(p_libros);
    }
     
    /**
     * Constructor que inicializa una biblioteca con un nombre, una lista de socios y un libro.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socios Lista de socios de la biblioteca.
     * @param p_libro Libro que se agrega a la biblioteca.
     */
    public Biblioteca(String p_nombre, ArrayList<Socio> p_socios, Libro p_libro){
        this.setNombre(p_nombre);
        this.setSocios(p_socios);
        this.setLibros(new ArrayList<Libro>());
        this.agregarLibro(p_libro);
    }
    
    /**
     * Constructor que inicializa una biblioteca con un nombre, un socio y una lista de libros.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socio Socio que se agrega a la biblioteca.
     * @param p_libros Lista de libros disponibles en la biblioteca.
     */
    public Biblioteca(String p_nombre, Socio p_socio, ArrayList<Libro> p_libros){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.agregarSocio(p_socio);
        this.setLibros(p_libros);
    }
    
    /**
     * Constructor que inicializa una biblioteca con un nombre, un socio y un libro.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socio Socio que se agrega a la biblioteca.
     * @param p_libro Libro que se agrega a la biblioteca.
     */
    public Biblioteca(String p_nombre, Socio p_socio, Libro p_libro){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.agregarSocio(p_socio);
        this.setLibros(new ArrayList<Libro>());
        this.agregarLibro(p_libro);
    }
    
    /**
     * Constructor que inicializa una biblioteca con un nombre y un libro.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_libro Libro que se agrega a la biblioteca.
     */
    public Biblioteca(String p_nombre, Libro p_libro){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.setLibros(new ArrayList<Libro>());
        this.agregarLibro(p_libro);
    }
    
    /**
     * Constructor que inicializa una biblioteca con un nombre y un socio.
     * Se inicializa una lista vacía de libros.
     * @param p_nombre Nombre de la biblioteca.
     * @param p_socio Socio que se agrega a la biblioteca.
     */
    public Biblioteca(String p_nombre, Socio p_socio){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.agregarSocio(p_socio);
        this.setLibros(new ArrayList<Libro>());
    }
    
    /**
     * Constructor que inicializa una biblioteca con solo un nombre.
     * Se inicializan listas vacías para socios y libros.
     * @param p_nombre Nombre de la biblioteca.
     */
    public Biblioteca(String p_nombre){
        this.setNombre(p_nombre);
        this.setSocios(new ArrayList<Socio>());
        this.setLibros(new ArrayList<Libro>());
    }
    
    //Setters
    private void setNombre(String p_nombre){
        this.nombre = p_nombre;
    }
    
    private void setSocios(ArrayList<Socio> p_socios){
        this.socios = p_socios;
    }
    
    private void setLibros(ArrayList<Libro> p_libros){
        this.libros = p_libros;
    }
    
    //Getters
    public String getNombre(){
        return this.nombre;
    }
    
    public ArrayList<Socio> getSocios(){
        return this.socios;
    }
    
    public ArrayList<Libro> getLibros(){
        return this.libros;
    }
    
    //Metodos Nahuel
    /**
     * Método para agregar un socio a la lista de socios.
     * @param p_socio Socio que se agrega a la biblioteca.
     */
    public void agregarSocio(Socio p_socio){
        this.getSocios().add(p_socio);
    }
    
    /**
     * Método para quitar un socio de la lista de socios.
     * @param p_socio Socio que se quita de la biblioteca.
     */
    public void quitarSocio(Socio p_socio){
        this.getSocios().remove(p_socio);
    }
    
    /**
     * Método para agregar un libro a la lista de libros.
     * @param p_libro Libro que se agrega a la biblioteca.
     */
    public void agregarLibro(Libro p_libro){
        this.getLibros().add(p_libro);
    }
    
    /**
     * Método para quitar un libro de la lista de libros.
     * @param p_libro Libro que se quita de la biblioteca.
     */
    public void quitarLibro(Libro p_libro){
        this.getLibros().remove(p_libro);
    }
    
    //Parte Nahuel
    /**
     * Crea un nuevo libro y lo agrega a la lista de libros de la biblioteca.
     * @param p_titulo Título del libro.
     * @param p_edicion Número de edición del libro.
     * @param p_editorial Editorial del libro.
     * @param p_anio Año de publicación del libro.
     */
    public void nuevoLibro(String p_titulo, int p_edicion, String p_editorial, int p_anio){
        Libro libro = new Libro(p_titulo, p_edicion, p_editorial, p_anio);
        this.getLibros().add(libro);
    }
    
    /**
     * Crea un nuevo socio de tipo Docente y lo agrega a la lista de socios.
     * @param p_dniSocio DNI del docente.
     * @param p_nombre Nombre del docente.
     * @param p_area Área de especialización del docente.
     */
    public void nuevoSocioDocente(int p_dniSocio, String p_nombre, String p_area){
        Docente docente = new Docente(p_dniSocio, p_nombre, p_area);
        this.getSocios().add(docente);
    }
    
    /**
     * Crea un nuevo socio de tipo Estudiante y lo agrega a la lista de socios.
     * @param p_dniSocio DNI del estudiante.
     * @param p_nombre Nombre del estudiante.
     * @param p_carrera Carrera del estudiante.
     */
    public void nuevoSocioEstudiante(int p_dniSocio, String p_nombre, String p_carrera){
        Estudiante estudiante = new Estudiante(p_dniSocio, p_nombre, p_carrera);
        this.getSocios().add(estudiante);
    }

    
    //Parte Mati
    /**
     * Se verifica si el socio puede acceder al prestamo y
     * luego se crea y archiva tanto en el libro como en el socio
     * 
     * @author: Matias Nahuel Montie
     * @version: (1.0.0)
     */
    public boolean prestarLibro(Calendar p_fechaRetiro, Socio p_socio, Libro p_libro){
        boolean prestado = false;
       
       if(p_socio.soyDeLaClase().equals("Estudiante")){
           if(p_socio.puedePedir()){
               //Calendar fechaDevolucion = p_fechaRetiro;
               //fechaDevolucion.add(Calendar.DAY_OF_MONTH, p_socio.getDiasPrestamos());
               
               Prestamo prestamo = new Prestamo(p_fechaRetiro, p_socio, p_libro);
               
               p_libro.agregarPrestamo(prestamo);
               p_socio.agregarPrestamo(prestamo);
                
               prestado = true;
           }
       }
       
       if(p_socio.soyDeLaClase().equals("Docente")){
           if(p_socio.puedePedir()){
               System.out.println("Docente puede pedir");
               int diasPrestados = 5;
               if(((Docente)p_socio).esResponsable()){
                   ((Docente)p_socio).cambiarDiasDePrestamo(p_socio.getDiasPrestamos() + 1);
               }
               
               //
               //Calendar fechaDevolucion = p_fechaRetiro;
               //fechaDevolucion.add(Calendar.DAY_OF_MONTH, p_socio.getDiasPrestamos());
               
               Prestamo prestamo = new Prestamo(p_fechaRetiro, p_socio, p_libro);
               
               p_libro.agregarPrestamo(prestamo);
               p_socio.agregarPrestamo(prestamo);
               
               prestado = true;
           }
       }
       
       return prestado;
    }

    
    /**
     * Se registra la devolucion de un libro
     * o lanza una excepcion en caso de que el libro no este prestado
     * @author: Matias Nahuel Montiel
     * @version: (1.0.0)
     */
    public void devolverLibro(Libro p_libro) throws LibroNoPrestadoException{
         if(p_libro.prestado()){
             Prestamo prestamo = p_libro.ultimoPrestamo();
             Socio socio =prestamo.getSocio();
             
             prestamo.registrarFechaDevolucion(Calendar.getInstance());
             socio.quitarPrestamo(prestamo);
             
        }else{
            throw new LibroNoPrestadoException("El libro" + p_libro.getTitulo() + " no se puede devolver ya que se encuentra en la biblioteca");
        }
    }
    
    /**
     * Se calcula la cantidad de socios segun el
     * tipo pasado por parametro
     * 
     * @author: Matias Nahuel Montiel
     * @version: 1.0.0
     */
    public int cantidadDeSociosPorTipo(String p_objeto){
        int contador = 0;
        
        for(Socio s : this.getSocios()){
            if(s.soyDeLaClase().equals(p_objeto)){
                contador += 1;
            }
        }
        
        return contador;
    }
    
    /**
     * Se crea un arraylist con todos los prestamos actualmente
     * vencidos segun los registros de los libros.
     * 
     * @author: Matias Nahuel Montiel
     * @version: 1.0.0
     */
    public ArrayList<Prestamo> prestamosVencidos(){
        
        ArrayList<Prestamo> prestamos = new ArrayList<Prestamo>();
        
        for(Libro libro : this.getLibros()){
            for(Prestamo prestamo : libro.getPrestamos()){
                if(prestamo.vencido(prestamo.getFechaDevolucion())){
                    prestamos.add(prestamo);
                }
            }
        }
        
        return prestamos;
    }
    /**
     * Se crea un ArrayList con todos 
     * los docentes que no deben libros
     * 
     * @author: Matias Nahuel Montiel
     * @version: 1.0.0
     */
    public ArrayList<Socio> docentesResponsables(){
        ArrayList<Socio> docentes = new ArrayList<>();
       for(Socio socio : this.getSocios()){
            if(socio.soyDeLaClase().equals("Docente") && ((Docente)socio).esResponsable()){
                    docentes.add(socio);
            }
        }
        return docentes;
    }
    
    
    //Parte Agus
    /**
     * Devuelve al socio que tiene el libro en su poder junto al titulo del libro
     * caso contrario si no se encuentra prestado lanza una excepción de tipo 
     * LibroNoPrestadoException con un mensaje descriptivo.
     * @param p_libro
     * @throw LibroNoPrestadoException
     * @return String
     */
    public String quienTieneElLibro(Libro p_libro) throws LibroNoPrestadoException{
        if(p_libro.prestado()){            
            return p_libro.ultimoPrestamo().getSocio().toString();
        }else{
            throw new LibroNoPrestadoException("El libro no esta prestado");
        }
        
    }
    
    /**
     * Realiza una lista de todos los socios de la biblioteca y podemos saber 
     * cuantos son Docentes y cuantos son Estudiantes
     * @return String 
     */
    public String listaDeSocios(){
        String listar = "\tLista de Socios: \n";
        int cantEstudiantes = 0;
        int cantDocentes = 0;
        int item = 0;
        
        for(Socio socio : this.getSocios()){
            item++;
            listar += item + ")" + socio.toString() + "\n";
        }
        cantDocentes = this.cantidadDeSociosPorTipo("Docente");
        cantEstudiantes = this.cantidadDeSociosPorTipo("Estudiante");
        
        listar += "\n**************************************\n";
        listar += "Cantidad de Socios del tipo Estudiante: " + cantEstudiantes + "\n";
        listar += "Cantidad de Socios del tipo Docente: " + cantDocentes + "\n";
        listar += "**************************************";
    
        return listar;
    }
    
    /**
     * Devuelve el Socio que tiene el dni que recibe como parametro, 
     * o null si no lo encuentra
     * @param p_dni
     * @return {@code true} devuelve el socio, {@code false} si no null
     */
    public Socio buscarSocio(int p_dni){
        Socio pers = null;
        for(Socio socio : this.getSocios()){
            if(socio.getDniSocio() == p_dni){
               pers = socio; 
            }else{
               pers = null; 
            }
        }
        return pers;
    }
    
    /**
     * Lista los titulos de libros con los que cuenta la biblioteca, lo hace sin repetir elemento
     * @return String
     */
    public String listaDeTitulos(){
        //Hago un conjunto de titulos (sin repetir titulos) 
        HashSet<String> listaTitulos = new HashSet<>();
        for(Libro libro : this.getLibros()){
            listaTitulos.add(libro.getTitulo());
        }
        // Convertimos el conjunto de títulos en una cadena, separada por saltos de línea
        return String.join("\n", listaTitulos);
    }
    
    /**
     * Lista los libros de la biblioteca y si estos fueron o no prestados
     * @return String
     */
    public String listaDeLibros(){
        StringBuilder lista = new StringBuilder("\tLista de Libros:\n");
        int item = 0;
        for(Libro libro : this.getLibros()){
            item++;
            String si_no = libro.prestado() ? "SI" : "NO";
            lista.append(item).append(") ").append(libro.toString()).append("|| Prestado: ").append(si_no).append("\n");
        }
        //cambia el contenido de StringBuilder a String
        return lista.toString();
    }
    
    /**
     * Lista de Docentes Responsables 
     * @return String
     */
    public String listaDeDocentesResponsables(){
        StringBuilder texto = new StringBuilder("\n\tLista de Docentes Responsables: \n");
        for(Socio socio : this.docentesResponsables()){
            texto.append("* ").append(socio).append("\n");
        }
        return texto.toString();
    }
}
