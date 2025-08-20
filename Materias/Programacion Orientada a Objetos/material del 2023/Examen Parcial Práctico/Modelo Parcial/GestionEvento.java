
public class GestionEvento {
  public static void main(String[] args) {
    Atleta pedroFuerza = new Scaled(123, "Pedro Juarez", 100.0, 12);
    Atleta victorFuerza = new Advanced(145, "Victor López", 200.0, 25);
    Atleta lucasFuerza = new Rx(157, "Lucas Vargas", 270, 20);

    Equipo fuerzaBruta = new Equipo("Fuerza Bruta", "Corrientes", pedroFuerza);
    fuerzaBruta.agregarAtleta(victorFuerza);
    fuerzaBruta.agregarAtleta(lucasFuerza);
    
    Atleta jualianDebil = new Scaled(90, "jualian Debil ", 50, 6);
    Atleta victorDebil = new Advanced(129, "victor Debil", 100, 13);
    Atleta lucasDebil = new Rx(110, "lucas Debil", 435, 10);

    Equipo fuerzaDebil = new Equipo("Fuerza Debil", "Chaco", jualianDebil);
    fuerzaDebil.agregarAtleta(victorDebil);
    fuerzaDebil.agregarAtleta(lucasDebil);


    Campeonato torneo = new Campeonato("XV Torneo Nacional de Crossfit", fuerzaBruta);
    torneo.agregarEquipo(fuerzaDebil);
    fuerzaBruta.mostrar();
    fuerzaDebil.mostrar();
    torneo.determinarGanador();
  }
}
