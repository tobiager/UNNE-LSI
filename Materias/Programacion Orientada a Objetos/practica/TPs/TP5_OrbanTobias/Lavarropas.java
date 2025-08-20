
/**
 * Clase que representa un lavarropas, que hereda de ArtefactoHogar.
 */
class Lavarropas extends ArtefactoHogar {
    private int programas;
    private float kilos;
    private boolean automatico;

    /**
     * Constructor de Lavarropas.
     * @param marca la marca del lavarropas
     * @param precio el precio del lavarropas
     * @param stock la cantidad en stock del lavarropas
     * @param programas la cantidad de programas del lavarropas
     * @param kilos la capacidad en kilos del lavarropas
     * @param automatico si es automático
     */
    public Lavarropas(String marca, float precio, int stock, int programas, float kilos, boolean automatico) {
        super(marca, precio, stock);
        this.programas = programas;
        this.kilos = kilos;
        this.automatico = automatico;
    }

    @Override
    public void imprimir() {
        System.out.println("**** Lavarropas ****");
        System.out.println("Marca: " + marca + " - Precio: " + precio + " - Stock: " + stock);
        System.out.println("Programas: " + programas);
        System.out.println("Kilos: " + kilos);
        System.out.println("Automático: " + (automatico ? "Si" : "No"));
    }

    @Override
    public float creditoConAdicional(int p_cuotas, float p_interes) {
        float valorCuota = cuotaCredito(p_cuotas, p_interes);
        if (!automatico) {
            valorCuota *= 0.98; // Descuento del 2% si no es automático
        }
        return valorCuota;
    }
}


