public class AplicacionFacultad {
  public static void main(String[] args) {
    Cargo cargoJuan1 = new Cargo("JTP-Programación OO", 800.0, 2010, 10);
    Cargo cargoJuan2 = new SemiExclusivo("Titular-TFA", 1400.0, 2017, 20, 0);
    Cargo cargoJuan3 = new Cargo("JTP-Analisis de Sistemas", 800.0, 2014, 10);

    Profesor juan = new Profesor("Lic. en Sistemas de Información", 28596132, "Juan", "Perez", 1986, cargoJuan1);

    Cargo cargoMirta1 = new Cargo("JTP-TP-II", 1200, 2011, 10);
    Cargo cargoMirta2 = new Exclusivo("JTP-Ing.Sof", 1800, 2014, 10, 20, 10);

    Profesor mirta = new Profesor("Lic. en Sistemas de Información", 34519921, "Mirta", "Lopez", 1993, cargoMirta1);

    Facultad UNNE = new Facultad("FaCENA", juan);
    juan.agregarCargo(cargoJuan2);
    juan.agregarCargo(cargoJuan3);
    UNNE.agregarProfesor(mirta);
    mirta.agregarCargo(cargoMirta2);
    UNNE.listarProfesorCargos();
    System.out.println();
    UNNE.nominaProfesores();
  }
}