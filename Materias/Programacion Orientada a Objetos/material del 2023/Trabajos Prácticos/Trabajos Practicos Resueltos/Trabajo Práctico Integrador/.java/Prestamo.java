import java.util.*;

public class Prestamo {
    private Calendar fechaRetiro;
    private Calendar fechaDevolucion;
    private Socio socio;
    private Libro libro;

    public Prestamo(Calendar p_fechaRetiro, Socio p_socio, Libro p_libro) {
        this.setFechaRetiro(p_fechaRetiro);
        this.setSocio(p_socio);
        this.setLibro(p_libro);
    }

    private void setFechaRetiro(Calendar p_fechaRetiro) {
        this.fechaRetiro = p_fechaRetiro;
    }

    public Calendar getFechaRetiro() {
        return this.fechaRetiro;
    }

    private void setFechaDevolucion(Calendar p_fechaDevolucion) {
        this.fechaDevolucion = p_fechaDevolucion;
    }

    public void registrarFechaDevolucion(Calendar p_fechaDevolucion) {
        this.setFechaDevolucion(p_fechaDevolucion);
    }

    public Calendar getFechaDevolucion() {
        return this.fechaDevolucion;
    }

    private void setSocio(Socio p_socio) {
        this.socio = p_socio;
    }

    public Socio getSocio() {
        return this.socio;
    }

    private void setLibro(Libro p_libro) {
        this.libro = p_libro;
    }

    public Libro getLibro() {
        return this.libro;
    }

    public boolean vencido(Calendar p_fecha) {
        Calendar fechaVencimiento = Calendar.getInstance();
        int day = this.getFechaRetiro().get(Calendar.DAY_OF_MONTH);
        int month = this.getFechaRetiro().get(Calendar.MONTH);
        int year = this.getFechaRetiro().get(Calendar.YEAR);

        fechaVencimiento.set(year, month, day);
        // Añade la cantidad de días de préstamo al día de la fecha de retiro
        fechaVencimiento.add(Calendar.DAY_OF_MONTH, this.getSocio().getDiasPrestamo());

        /* LINEAS PARA COMPROBAR FECHAS
        System.out.println("Prestado el: " + day +"/"+ month +"/"+ year);
        System.out.println("Vence el: " + fechaVencimiento.get(Calendar.DAY_OF_MONTH) +"/"+ month +"/"+ year);
        System.out.println("\n Hoy es " + p_fecha.get(Calendar.DAY_OF_MONTH) + "/"  + p_fecha.get(Calendar.MONTH) + "/"  + p_fecha.get(Calendar.YEAR));
         */  
        
        /* LINEAS PARA COMPROBAR SALIDA 
        System.out.print("Es p_fecha despues de fechaVencimiento? ");
        System.out.println(p_fecha.after(fechaVencimiento));
        */
        
        //Pregunta si p_fecha viene despues de fechaVencimiento
        return p_fecha.after(fechaVencimiento);
    }

    public String toString() {
        String retiroStr = "\n\nRetiro: " + this.getFechaRetiro().get(Calendar.YEAR) + "/" + this.getFechaRetiro().get(Calendar.MONTH)
            + "/" + this.getFechaRetiro().get(Calendar.DAY_OF_MONTH);
        String devolucionStr = " - Devolucion: ";

        if (this.getFechaDevolucion() != null) {
            devolucionStr += this.getFechaDevolucion().get(Calendar.YEAR) + "/"
            + this.getFechaDevolucion().get(Calendar.MONTH) + "/"
            + this.getFechaDevolucion().get(Calendar.DAY_OF_MONTH) + "\n";
        } else {
            devolucionStr += "N/A \n";
        }

        String libroStr = "Libro: " + this.getLibro().getTitulo() + "\n";
        String socioStr = "Socio: " + this.getSocio().getNombre();
        return retiroStr + devolucionStr + libroStr + socioStr;
    }
}   