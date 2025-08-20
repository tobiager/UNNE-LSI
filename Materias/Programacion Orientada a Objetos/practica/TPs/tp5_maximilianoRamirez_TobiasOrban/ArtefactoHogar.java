
/**
 * Clase abstracta que representa un artefacto del hogar.
 */
abstract class ArtefactoHogar {
    protected String marca;
    protected float precio;
    protected int stock;

    /**
     * Constructor de ArtefactoHogar.
     * @param marca la marca del artefacto
     * @param precio el precio del artefacto
     * @param stock la cantidad en stock del artefacto
     */
    public ArtefactoHogar(String marca, float precio, int stock) {
        this.marca = marca;
        this.precio = precio;
        this.stock = stock;
    }

    /**
     * Método abstracto para imprimir la información del artefacto.
     */
    public abstract void imprimir();

    /**
     * Calcula el valor de la cuota de crédito.
     * @param p_cuotas la cantidad de cuotas
     * @param p_interes el porcentaje de interés
     * @return el valor de la cuota
     */
    public float cuotaCredito(int p_cuotas, float p_interes) {
        float valorCuota = (precio * (1 + p_interes / 100)) / p_cuotas;
        return valorCuota;
    }

    /**
     * Método abstracto para calcular el crédito con adicional.
     * @param p_cuotas la cantidad de cuotas
     * @param p_interes el porcentaje de interés
     * @return el valor del crédito con adicional
     */
    public abstract float creditoConAdicional(int p_cuotas, float p_interes);
}


