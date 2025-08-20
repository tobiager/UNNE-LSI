import java.util.ArrayList;
import java.util.Calendar;

public class Biblioteca {
    private String nombre;
    private ArrayList<Libro> libros;
    private ArrayList<Socio> socios;

    public Biblioteca(String p_nombre) {
        this.setNombre(p_nombre);
        this.setLibro(new ArrayList<Libro>());
        this.setSocios(new ArrayList<Socio>());
    }

    private void setNombre(String p_nombre) {
        this.nombre = p_nombre;
    }

    public String getNombre() {
        return this.nombre;
    }

    private void setLibro(ArrayList<Libro> p_libros) {
        this.libros = p_libros;
    }

    public ArrayList<Libro> getLibros() {
        return this.libros;
    }

    private void setSocios(ArrayList<Socio> p_socios) {
        this.socios = p_socios;
    }

    public ArrayList<Socio> getSocios() {
        return this.socios;
    }

    public void addSocio(Socio p_socio) {
        this.getSocios().add(p_socio);
    }

    public void removeSocio(Socio p_socio) {
        this.getSocios().remove(p_socio);
    }

    public void addLibro(Libro p_libro) {
        this.getLibros().add(p_libro);
    }

    public void removeLibro(Libro p_libro) {
        this.getLibros().remove(p_libro);
    }

    public void nuevoLibro(String p_titulo, int p_edicion, String p_editoral, int p_anio) {
        Libro libro = new Libro(p_titulo, p_edicion, p_editoral, p_anio);
        this.getLibros().add(libro);
    }

    public void nuevoSocioEstudiante(int p_dniSocio, String p_nombre, String p_carrera) {
        Estudiante unEstudiante = new Estudiante(p_dniSocio, p_nombre, p_carrera);
        this.addSocio(unEstudiante);
    }

    public void nuevoSocioDocente(int p_dniSocio, String p_nombre, String p_area) {
        Docente unDocente = new Docente(p_dniSocio, p_nombre, p_area);
        this.addSocio(unDocente);
    }

    public int cantidadSociosPorTipo(String p_objeto) {
        int contar = 0;
        for (Socio socioAux : this.getSocios()) {
            if (socioAux.getClass().getName().equals(p_objeto)) {
                contar += 1;
            }
        }
        return contar;
    }

    public boolean prestarLibro(Calendar p_fechaRetiro, Socio p_socio, Libro p_libro) {
        if (p_socio.puedePedir() && p_libro.prestado() == false) {
            Prestamo unPrestamo = new Prestamo(p_fechaRetiro, p_socio, p_libro);
            p_socio.addPrestamo(unPrestamo);
            p_libro.addPrestamo(unPrestamo);
            return true;
        } else {
            return false;
        }
    }

    public void devolverLibro(Libro p_libro) {
        Prestamo prestamo = p_libro.getPrestamo();
        if (p_libro.prestado() == true) {
            p_libro.getPrestamo().registrarFechaDevolucion(Calendar.getInstance());
            prestamo.getSocio().removePrestamo(prestamo);
            p_libro.removePrestamo(prestamo);
        }
    }

    public ArrayList<Prestamo> prestamosVencidos() {
        ArrayList<Prestamo> prestamosVencidos = new ArrayList<>();
        Calendar fechaHoy = Calendar.getInstance();
        for (Socio socioAux : this.getSocios()) {
            for (Prestamo prestamoAux : socioAux.getPrestamos()) {
                if (prestamoAux.vencido(fechaHoy)) {
                    prestamosVencidos.add(prestamoAux);
                }
            }
        }
        return prestamosVencidos;
    }

    public String quienTieneElLibro(Libro p_libro) {
        String mensaje = "El libro se encuentra en la biblioteca";
        for (Socio socioAux : this.getSocios()) {
            for (Prestamo prestamoAux : socioAux.getPrestamos()) {
                if (p_libro == prestamoAux.getLibro()) {
                    mensaje = socioAux.getNombre() + " tiene el libro";
                }
            }
        }
        return mensaje;
    }

    public String listaDeSocios() {
        String lista = "";
        int numero = 1;
        for (Socio socioAux : this.getSocios()) {
            lista += "\n" + (numero++) + ")" + socioAux.toString();
        }
        return lista;
    }

    public ArrayList<Docente> docentesResponsables() {
        ArrayList<Docente> docenteResponsables = new ArrayList<Docente>();
        for (Socio s : this.getSocios()) {
            if (s.soyDeLaClase() == "Docente") {
                Docente d = (Docente) s;
                if (d.esResponsable() == true) {
                    docenteResponsables.add(d);
                }
            }
        }
        return docenteResponsables;
    }

    public String listaDeDocentesResponsables() {
        String listaDocentesResp = "Lista de Docentes Responsables: \n";
        for (Socio s : this.docentesResponsables()) {
            if (s.soyDeLaClase() == "Docente") {
                Docente d = (Docente) s;
                if (d.esResponsable() == true) {
                    listaDocentesResp += "\n" + "* " + d.toString();
                } else {
                    listaDocentesResp = "";
                }
            }
        }
        return listaDocentesResp;
    }

    public String listaDeLibros() {
        String listaCompleta = "Lista de Libros:\n";
        ArrayList<Libro> listaLibros = this.getLibros();
        int numero = 1;
        if (listaLibros != null) {
            for (Libro unLibro : listaLibros) {
                if (unLibro.prestado() == true) {
                    listaCompleta += "\n" + (numero++) + ")" + unLibro.toString() + " || Prestado : (Si)";
                } else {
                    listaCompleta += "\n" + (numero++) + ")" + unLibro.toString() + " || Prestado : (No)";
                }
            }
        } else {
            listaCompleta += "La lista de libros es nula.";
        }
        return listaCompleta;
    }

    public Socio buscarSocio(int p_dni) {
        for (Socio unSocio : this.getSocios()) {
            if (unSocio.getDniSocio() == p_dni) {
                return unSocio;
            }
        }
        return null;
    }
}