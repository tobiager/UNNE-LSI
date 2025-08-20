public class RegistroCivil {
  public static void main(String[] args) {

    Mujer esposa = new Mujer(
        "Maria",
        "Gomez",
        29);

    Hombre esposo = new Hombre(
        "Pedro",
        "Perez",
        28);

    esposa.mostrarEstadoCivil();
    esposo.mostrarEstadoCivil();

    esposa.casarseCon(esposo);
    esposo.casarseCon(esposa);

    esposa.mostrarEstadoCivil();
    esposo.mostrarEstadoCivil();

    esposa.casadaCon();
    esposo.casadoCon();

    esposa.divorcio();
    esposo.divorcio();

    esposa.mostrarEstadoCivil();
    esposo.mostrarEstadoCivil();
  }
}
