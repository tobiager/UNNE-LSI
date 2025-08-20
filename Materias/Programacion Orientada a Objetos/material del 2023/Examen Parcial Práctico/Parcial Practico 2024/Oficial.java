
public class Oficial extends Categoria {
    protected String porte;
   

    public String getPorte() {
        return this.porte;
    }

    public void setPorte(String p_porte) {
        this.porte = p_porte;
    }

    public Oficial(double p_costo, String p_porte) {
        super(p_costo);
        this.setPorte(p_porte);
        
    }

    @Override
    public String tipoCategoria() {
        return "Oficial";
    }

    @Override
    public double costoTotal(String turno) {
        if (turno != null && turno.equals("Diurno") && getPorte().equals("Pequeño")) {
            costo = costo * 0.70;
        } else if (turno != null && turno.equals("Diurno") && getPorte().equals("Grande")) {
            costo = costo * 0.90;
        } else {
            costo += costo * 0.10;
        }
        return costo;
    }
    
    @Override
    public String leyendaCategoria() {
        return " Oficial - Porte: " + porte;
    }
}

