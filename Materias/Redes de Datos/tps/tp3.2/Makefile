# TP 3.2 - Redes de Datos (UNNE). Uso: make   |   make clean
CC     = gcc
CFLAGS = -Wall -Wextra -O2 -pthread

all: ej1/servidor_chat ej1/cliente_chat ej2/servidor_inventario ej2/agente_inventario

ej1/servidor_chat: ej1/servidor_chat.c
	$(CC) $(CFLAGS) -o $@ $<
ej1/cliente_chat: ej1/cliente_chat.c
	$(CC) $(CFLAGS) -o $@ $<
ej2/servidor_inventario: ej2/servidor_inventario.c
	$(CC) $(CFLAGS) -o $@ $<
ej2/agente_inventario: ej2/agente_inventario.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f ej1/servidor_chat ej1/cliente_chat ej2/servidor_inventario ej2/agente_inventario

.PHONY: all clean
