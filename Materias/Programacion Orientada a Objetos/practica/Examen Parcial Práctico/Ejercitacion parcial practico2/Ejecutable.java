

public class Ejecutable{
    public static void main (String [] args){
     
    Campeonato sekaitaikai = new Campeonato ("Sekai Tai Kai");
    
    Advanced Halcon = new Advanced(232,"Illay Halcon",150,15);
    Rx Miguel = new Rx(1,"Miguel Diaz",200,20);
    Scaled Dimitri = new Scaled(423,"Dimmitri Binario",70,7);
    
    Equipo CobraKai = new Equipo("Cobra Kai", "All Valley");
    CobraKai.agregarAtleta(Halcon);
    CobraKai.agregarAtleta(Miguel);
    CobraKai.agregarAtleta(Dimitri);
    
    Advanced Larusso = new Advanced(100,"Larusso",220,22);
    Scaled Srmiyagui = new Scaled(1000,"Sr miyagui",180,18);
    Rx Sam = new Rx(45,"Sam Larruso",100,10);
    
    Equipo Miyaguido = new Equipo("Miyagui Do", "All Valley");
    Miyaguido.agregarAtleta(Larusso);
    Miyaguido.agregarAtleta(Srmiyagui);
    Miyaguido.agregarAtleta(Sam);
    
    Advanced coscu = new Advanced(534,"Martin disalvo",100,10);
    Rx momo = new Rx(643,"Geronimo Benavides",200,20);
    Scaled zeko = new Scaled(6969,"ZEKO",70,7);
    
    Equipo zz = new Equipo("9z", "Argentina en la casa pa");
    zz.agregarAtleta(coscu);
    zz.agregarAtleta(momo);
    zz.agregarAtleta(zeko);
    
    sekaitaikai.agregarEquipo(CobraKai);
    sekaitaikai.agregarEquipo(Miyaguido);
    sekaitaikai.agregarEquipo(zz);
    
    CobraKai.mostrarEquipo();
    Miyaguido.mostrarEquipo();
    zz.mostrarEquipo();    
    sekaitaikai.determinarGanador();
    }
}
