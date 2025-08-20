
public class Main {
    public static void main(String[] args) {
        // Crear el pedido
        Pedido pedido = new Pedido();

        // Crear etiquetas
        Premium etiqueta1 = new Premium(200, 10);  // Etiqueta Premium con 10 colores
        Comun etiqueta2 = new Comun(100, 100);  // Etiqueta Común con un diseño adicional de $100
        Premium etiqueta3 = new Premium(200, 7);// Otra etiqueta Premium con 7 colores
        

        // Crear renglones (agregar cantidad y etiqueta)
        Renglon renglon1 = new Renglon(7, 1820.0,etiqueta1);  // 7 etiquetas Premium
        Renglon renglon2 = new Renglon(57,5510.0, etiqueta2);  // 57 etiquetas Comunes
        Renglon renglon3 = new Renglon(94, 22748.0,etiqueta3);  // 94 etiquetas Premium
        Renglon renglon4 = new Renglon(1, 22748.0);
        // Agregar renglones al pedido
        pedido.agregarRenglon(renglon1);
        pedido.agregarRenglon(renglon2);
        pedido.agregarRenglon(renglon3);
        
        // Mostrar el pedido
        pedido.mostrar();
    }
}

