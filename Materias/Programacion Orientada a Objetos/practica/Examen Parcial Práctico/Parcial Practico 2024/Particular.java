

public class Particular extends Categoria {

    public Particular(double p_costo) {
        super(p_costo);
    }

    @Override
    public String tipoCategoria() {
        return "Particular";
    }

    @Override
    public double costoTotal(String turno) {
        if (turno != null && turno.equals("Nocturno")) {
            costo += costo * 0.10;
        } 
        return costo;   
    }

    @Override
    public String leyendaCategoria() {
        return " Particular";
    }
}
