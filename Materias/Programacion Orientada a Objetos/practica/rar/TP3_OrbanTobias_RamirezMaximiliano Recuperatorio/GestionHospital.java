
import java.util.Scanner;

/**
 * Clase principal para gestionar la información del hospital y los pacientes.
 */
public class GestionHospital {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        
        System.out.print("Ingrese la localidad de nacimiento: ");
        String localidadNacidoNombre = scanner.nextLine();
        System.out.print("Ingrese la provincia de nacimiento: ");
        String provinciaNacido = scanner.nextLine();
        Localidad localidadNacido = new Localidad(localidadNacidoNombre, provinciaNacido);

        
        System.out.print("Ingrese la localidad donde vive: ");
        String localidadViveNombre = scanner.nextLine();
        System.out.print("Ingrese la provincia donde vive: ");
        String provinciaVive = scanner.nextLine();
        Localidad localidadVive = new Localidad(localidadViveNombre, provinciaVive);

        
        System.out.print("Ingrese el nombre del paciente: ");
        String nombrePaciente = scanner.nextLine();
        System.out.print("Ingrese el número de historia clínica: ");
        int historiaClinica = scanner.nextInt();
        scanner.nextLine();  
        System.out.print("Ingrese el domicilio del paciente: ");
        String domicilioPaciente = scanner.nextLine();
        Paciente paciente = new Paciente(historiaClinica, nombrePaciente, domicilioPaciente, localidadNacido, localidadVive);

        
        System.out.print("Ingrese el nombre del hospital: ");
        String nombreHospital = scanner.nextLine();
        System.out.print("Ingrese el nombre del director del hospital: ");
        String nombreDirector = scanner.nextLine();
        Hospital hospital = new Hospital(nombreHospital, nombreDirector);

        
        hospital.consultaDatosFiliatorios(paciente);

        scanner.close();
    }
}



