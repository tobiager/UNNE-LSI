public class MainPedido {
  public static void main(String[] args) {
    Renglon renglon1 = new Renglon(7, new Premium(200.0, 10));
    Pedido pedido = new Pedido(renglon1);
    Renglon renglon2 = new Renglon(57, new Comun(100.0, 100.0));
    pedido.agregarRenglon(renglon2);
    Renglon renglon3 = new Renglon(94, new Premium(200.0, 7));
    pedido.agregarRenglon(renglon3);
    pedido.mostrar();
  }
}
