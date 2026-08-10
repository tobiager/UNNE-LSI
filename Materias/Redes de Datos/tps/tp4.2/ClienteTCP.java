import java.io.*;
import java.net.*;
import java.util.Scanner;

public class ClienteTCP {
    private static final int PORT = 5000;

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.print("Ingrese la IP del servidor: ");
            String serverIP = sc.nextLine().trim();

            Socket socket = new Socket(serverIP, PORT);
            System.out.println("Conectado al servidor de chat en " + serverIP + ":" + PORT);

            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream(), "UTF-8"));
            PrintWriter out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream(), "UTF-8"), true);

            System.out.print("Ingrese su nombre de usuario: ");
            String nombre = sc.nextLine().trim();
            if (nombre.isEmpty()) nombre = "Anonimo";
            out.println(nombre); // Enviar nombre al servidor

            // Hilo receptor de mensajes
            Thread receptor = new Thread(() -> {
                try {
                    String linea;
                    while ((linea = in.readLine()) != null) {
                        System.out.println("\n" + linea);
                        System.out.print("> ");
                    }
                } catch (IOException e) {
                    System.out.println("\n** Conexión cerrada por el servidor **");
                }
            });
            receptor.setDaemon(true);
            receptor.start();

            System.out.println("¡Bienvenido al chat! Comandos: /listar, /quitar");
            while (true) {
                System.out.print("> ");
                String mensaje = sc.nextLine().trim();
                if (mensaje.isEmpty()) continue;
                out.println(mensaje);
                if (mensaje.startsWith("/quitar")) {
                    break;
                }
            }

            socket.close();
            System.out.println("Desconectado del chat.");

        } catch (IOException e) {
            System.out.println("No se pudo conectar al servidor: " + e.getMessage());
        }
    }
}
