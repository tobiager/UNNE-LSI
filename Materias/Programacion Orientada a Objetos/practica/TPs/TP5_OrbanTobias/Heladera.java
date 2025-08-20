
/**
 * Clase que representa una heladera, que hereda de ArtefactoHogar.
 */
class Heladera extends ArtefactoHogar {
    private int pies;
    private int puertas;
    private boolean compresor;

    /**
     * Constructor de Heladera.
     * @param marca la marca de la heladera
     * @param precio el precio de la heladera
     * @param stock la cantidad en stock de la heladera
     * @param pies la cantidad de pies de la heladera
     * @param puertas la cantidad de puertas de la heladera
     * @param compresor si tiene compresor
     */
    public Heladera(String marca, float precio, int stock, int pies, int puertas, boolean compresor) {
        super(marca, precio, stock);
        this.pies = pies;
        this.puertas = puertas;
        this.compresor = compresor;
    }

    @Override
    public void imprimir() {
        System.out.println("**** Heladera ****");
        System.out.println("Marca: " + marca + " - Precio: " + precio + " - Stock: " + stock);
        System.out.println("Pies: " + pies);
        System.out.println("Puertas: " + puertas);
        System.out.println("Compresor: " + (compresor ? "Si" : "No"));
    }

    @Override
    public float creditoConAdicional(int p_cuotas, float p_interes) {
        float valorCuota = cuotaCredito(p_cuotas, p_interes);
        if (compresor) {
            valorCuota += 50; // Seguro adicional si tiene compresor
        }
        return valorCuota;
    }
}

