import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.ArrayList;

public class GestionPeaje {
    public static void main(String[] args) {
        // Crear el peaje y las cajas
        ArrayList<Caja> cajas = new ArrayList<>();
        ArrayList<Ticket> tickets = new ArrayList<>();
        Peaje peaje = new Peaje("Peaje Chaco-Ctes");

        // Crear cajas con nombres de cajeros distintos
        Cajero cajero1 = new Cajero ("132","Carlos Gomez");
        Caja caja1 = new Caja(1,cajero1);
        //Caja caja2 = new Caja(2, new Cajero ("432","Ana Martinez"));
        //Caja caja3 = new Caja(3, new Cajero ("536","Luis Rodriguez"));
        //Caja caja4 = new Caja(4, new Cajero ("777","Maria Lopez"));
        //Caja caja5 = new Caja(5, new Cajero ("754","Pedro Sanchez"));

        // Agregar cajas al peaje y a la colección de cajas
        //cajas.add(caja1);
        //cajas.add(caja2);
        //cajas.add(caja3);
        //cajas.add(caja4);
        //cajas.add(caja5);

        //for (Caja caja : cajas) {
        //    peaje.agregarCaja(caja);
        //}
        peaje.agregarCaja(caja1);
        
        // Crear tickets y agregarlos a la colección de tickets
        Ticket ticket1 = new Ticket("Diurno", "AD 611 QP", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0));
        Ticket ticket2 = new Ticket("Nocturno", "DQ 321 OW", new GregorianCalendar(2024, Calendar.SEPTEMBER, 9), new Oficial(2700.0,"Grande"));
        //tickets.add(new Ticket("Diurno", "AD 611 QP", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0)));
        //tickets.add(new Ticket("Nocturno", "BC 112 ZF", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0)));
        //tickets.add(new Ticket("Diurno", "CD 324 RD", new GregorianCalendar(2024, Calendar.MARCH, 5), new Oficial(2700.0, "Pequeño")));
        //tickets.add(new Ticket("Diurno", "EF 443 HL", new GregorianCalendar(2024, Calendar.MARCH, 5), new Oficial(2700.0, "Grande")));
        //tickets.add(new Ticket("Nocturno", "FG 555 XY", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0)));
        //tickets.add(new Ticket("Diurno", "GH 666 ZT", new GregorianCalendar(2024, Calendar.MARCH, 5), new Oficial(2700.0, "Alto")));
        //tickets.add(new Ticket("Diurno", "HI 777 ZX", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0)));
        //tickets.add(new Ticket("Nocturno", "IJ 888 XY", new GregorianCalendar(2024, Calendar.MARCH, 5), new Oficial(2700.0, "Pequeño")));
        //tickets.add(new Ticket("Diurno", "KL 999 AB", new GregorianCalendar(2024, Calendar.MARCH, 5), new Oficial(2700.0, "Mediano")));
        //tickets.add(new Ticket("Nocturno", "MN 123 CD", new GregorianCalendar(2024, Calendar.MARCH, 5), new Particular(2700.0)));

        // Asignar tickets a cada caja de manera equitativa
         caja1.agregarTicket(ticket1);
         caja1.agregarTicket(ticket2);
        //caja1.agregarTicket(tickets.get(0));
        //caja1.agregarTicket(tickets.get(1));
        //caja1.agregarTicket(tickets.get(2));

        //caja2.agregarTicket(tickets.get(3));
        //caja2.agregarTicket(tickets.get(4));
        //caja2.agregarTicket(tickets.get(5));

        //caja3.agregarTicket(tickets.get(6));
        //caja3.agregarTicket(tickets.get(7));
        //caja3.agregarTicket(tickets.get(8));

        //caja4.agregarTicket(tickets.get(9));
        //caja4.agregarTicket(tickets.get(6));
        //caja4.agregarTicket(tickets.get(7));

        //caja5.agregarTicket(tickets.get(8));
        //caja5.agregarTicket(tickets.get(9));
        //caja5.agregarTicket(tickets.get(0));

        // Simular informes y mostrar algunos tickets
        peaje.informeTurno();
        ticket1.imprimirTicket();
        ticket2.imprimirTicket();
        //tickets.get(4).imprimirTicket();
        //tickets.get(3).imprimirTicket();
    }
}







