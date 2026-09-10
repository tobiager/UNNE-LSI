import java.net.*;
import java.io.*;
import java.util.Scanner;

public class ClienteUDP {
    private static final int SERVER_PORT = 5000;
    private static final int BUFFER_SIZE = 1024;

    public static void main(String[] args) {
        try {
            Scanner sc = new Scanner(System.in);
            System.out.print("Ingrese la IP del servidor: ");
            String serverIP = sc.nextLine().trim();
            InetAddress servidor = InetAddress.getByName(serverIP);

            DatagramSocket socket = new DatagramSocket(); // no necesita bind
            socket.setSoTimeout(0); // Espera indefinida para recibir
            System.out.print("Ingrese su nombre de usuario: ");
            String nombre = sc.nextLine().trim();
            if (nombre.isEmpty()) nombre = "Anonimo";

            enviar(socket, nombre, servidor); // Primer datagrama = nombre de usuario

            // Hilo receptor para imprimir mensajes entrantes
            Thread receptor = new Thread(() -> {
                byte[] buffer = new byte[BUFFER_SIZE];
                try {
                    while (true) {
                        DatagramPacket paquete = new DatagramPacket(buffer, buffer.length);
                        socket.receive(paquete);
                        String mensaje = new String(paquete.getData(), 0, paquete.getLength(), "UTF-8");
                        System.out.println("\n" + mensaje);
                        System.out.print("> ");
                    }
                } catch (IOException e) {
                    System.out.println("** Conexión finalizada **");
                }
            });
            receptor.setDaemon(true);
            receptor.start();

            System.out.println("Conectado al chat UDP. Comandos: /listar, /quitar");
            while (true) {
                System.out.print("> ");
                String mensaje = sc.nextLine().trim();
                if (mensaje.isEmpty()) continue;
                enviar(socket, mensaje, servidor);
                if (mensaje.startsWith("/quitar")) {
                    socket.close();
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void enviar(DatagramSocket socket, String mensaje, InetAddress servidor) throws IOException {
        byte[] data = mensaje.getBytes("UTF-8");
        DatagramPacket paquete = new DatagramPacket(data, data.length, servidor, SERVER_PORT);
        socket.send(paquete);
    }
}
