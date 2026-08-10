import socket
import threading
import os

SERVER_HOST = '192.168.0.12'   # IP o nombre de host del servidor (localhost o 127.0.0.1 si el servidor esta en la misma maquina)
SERVER_PORT = 5000          # Puerto en el que escucha el servidor de chat

# Crear socket TCP del cliente
client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    client_sock.connect((SERVER_HOST, SERVER_PORT))
    print(f"Conectado al servidor de chat en {SERVER_HOST}:{SERVER_PORT}")
except Exception as e:
    print(f"No se pudo conectar al servidor: {e}")
    exit(1)


nombre_usuario = input("Ingrese su nombre de usuario: ")
if not nombre_usuario:
    nombre_usuario = "Anonimo"
client_sock.send(nombre_usuario.encode('utf-8'))


# Funcion que ejecutara el hilo de recepcion
def recibir_mensajes():
    try:
        while True:
            data = client_sock.recv(1024)
            if not data:
                # El servidor cerró la conexión
                print("** Conexión cerrada por el servidor **")
                break
            mensaje = data.decode('utf-8').strip()
            if mensaje:
                print("\r" + mensaje + "\n> ", end="")
                # Imprime el mensaje recibido. "\r" retorna al inicio de línea.
                # Luego muestra el prompt ">" nuevamente para el usuario.
    except Exception as e:
        print(f"[Error] Conexión perdida: {e}")
    finally:
        # Salir del programa cuando se pierde la conexión
        client_sock.close()
        print("\nSaliendo del chat...")
        os._exit(0)  # fuerza la salida de todo el proceso

# Iniciar el hilo receptor
hilo_receptor = threading.Thread(target=recibir_mensajes, daemon=True)
hilo_receptor.start()


print("�Bienvenido al chat! Escriba sus mensajes. Comandos: /listar, /quitar")
while True:
    try:
        mensaje = input("> ")
    except EOFError:
        # Si se presiona Ctrl+D (EOF) terminar
        mensaje = "/quitar"
    if mensaje.strip() == "":
        continue  # ignorar líneas vacías
    if mensaje.startswith("/quitar"):
        # Enviar comando de salir al servidor y cerrar socket
        client_sock.send(mensaje.encode('utf-8'))
        break
    try:
        client_sock.send(mensaje.encode('utf-8'))
    except Exception as e:
        print(f"Error enviando mensaje: {e}")
        break

# Si salimos del bucle, cerramos el socket y terminamos
client_sock.close()
print("Desconectado del chat.")
