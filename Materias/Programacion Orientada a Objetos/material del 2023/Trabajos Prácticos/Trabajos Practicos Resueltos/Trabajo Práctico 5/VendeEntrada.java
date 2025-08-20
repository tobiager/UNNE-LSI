import java.util.Calendar;

public class VendeEntrada {
  public static void main(String[] args) {
    Zoologico zoologico = new Zoologico("El Caribú");
    Calendar fecha22_09_2016 = Calendar.getInstance();
    fecha22_09_2016.set(2016, Calendar.SEPTEMBER, 22);

    // * Instanciar tres individuos que asistieron al zoológico
    // * Uno de ellos en forma independiente
    Individuo juan = new Individuo(new Persona(1, "Juan", "Perez", 1990), fecha22_09_2016);

    // * Los otros dos formando parte de la delegación “PAMI”
    Persona alexis = new Persona(44542230, "Alexis", "Olivarez", 1994);
    Persona axel = new Persona(44622223, "Axel", "Vega", 1995);
    Delegacion pami = new Delegacion("PAMI", fecha22_09_2016, new Individuo(alexis, fecha22_09_2016));
    pami.inscribirIndividuo(new Individuo(axel, fecha22_09_2016));

    // * Inscribimos los individuos y la delegación al zoológico
    zoologico.nuevoVisitante(juan);
    zoologico.nuevoVisitante(pami);

    // * Listar todos los visitantes que acudieron al zoológico el día 22/09/2016
    zoologico.listaVisitantePorFecha(fecha22_09_2016);

    // * Listar la recaudación del último mes
    Calendar fechaActual = Calendar.getInstance();
    double recaudacionUltimoMes = zoologico.recaudacion(fecha22_09_2016, fechaActual);
    System.out.println("Recaudación del último mes: $" + recaudacionUltimoMes);

    // * Listar las delegaciones que acudieron el día 22/09/2016
    System.out.println("Delegaciones el 22/09/2016:");
    zoologico.listaTipoVisitantePorFecha(fecha22_09_2016, "Delegación");
  }
}
