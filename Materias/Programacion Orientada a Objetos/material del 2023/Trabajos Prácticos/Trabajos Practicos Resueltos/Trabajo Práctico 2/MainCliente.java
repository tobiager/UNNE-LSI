public class MainCliente {
  public static void main(String[] args) {
    Cliente cliente = new Cliente(24444333, "Juan", "Perez", 200);
    cliente.mostrar();
    cliente.agregaSaldo(100);
    cliente.mostrar();
    cliente.nuevoSaldo(1000);
    cliente.mostrar();
  }
}
