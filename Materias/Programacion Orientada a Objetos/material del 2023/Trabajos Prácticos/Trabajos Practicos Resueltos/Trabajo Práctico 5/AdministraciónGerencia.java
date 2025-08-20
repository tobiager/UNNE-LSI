public class AdministraciónGerencia {
  public static void main(String[] args) {
    Gerencia gerencia = new Gerencia("Los Arroyos");

    // * Crea una cabaña
    Cabaña cabaña = new Cabaña("Cabañas La Alondra", 120.0, 5, 3);
    cabaña.agregarServicio(new Servicio("Alquiler de auto", 100));
    cabaña.agregarServicio(new Servicio("Lavanderia", 20));
    gerencia.agregarAlojamiento(cabaña);

    // * Crea un hotel
    Hotel hotel = new Hotel("Hotel Guaraní", 70, 7, "Single");
    hotel.agregarServicio(new Servicio("Internet", 5));
    hotel.agregarServicio(new Servicio("Alquiler de auto", 100));
    gerencia.agregarAlojamiento(hotel);

    // * Realizar la liquidación de la estadía
    gerencia.mostrarLiquidacion();
  }
}