
/**
 * Clase que representa una cocina, que hereda de ArtefactoHogar.
 */
class Cocina extends ArtefactoHogar {
    private int hornallas;
    private int calorias;
    private String dimensiones;

    /**
     * Constructor de Cocina.
     * @param marca la marca de la cocina
     * @param precio el precio de la cocina
     * @param stock la cantidad en stock de la cocina
     * @param hornallas la cantidad de hornallas de la cocina
     * @param calorias las calorías de la cocina
     * @param dimensiones las dimensiones de la cocina
     */
    public Cocina(String marca, float precio, int stock, int hornallas, int calorias, String dimensiones) {
        super(marca, precio, stock);
        this.hornallas = hornallas;
        this.calorias = calorias;
        this.dimensiones = dimensiones;
    }

    @Override
    public void imprimir() {
        System.out.println("**** Cocina ****");
        System.out.println("Marca: " + marca + " - Precio: " + precio + " - Stock: " + stock);
        System.out.println("Hornallas: " + hornallas);
        System.out.println("Calorías: " + calorias);
        System.out.println("Dimensiones: " + dimensiones);
    }

    @Override
    public float creditoConAdicional(int p_cuotas, float p_interes) {
        return cuotaCredito(p_cuotas, p_interes); // No hay adicionales para la cocina
    }
}


