
public abstract class Categoria {
    protected double costo;

    public double getCosto() {
        return this.costo;
    }

    public void setCosto(double p_costo) {
        this.costo = p_costo;
    }

    public Categoria(double p_costo) {
        this.setCosto(p_costo);
    }

    public abstract String tipoCategoria();

    public abstract double costoTotal(String turno);

    public abstract String leyendaCategoria();
}

