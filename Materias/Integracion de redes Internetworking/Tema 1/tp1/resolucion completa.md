# you asked

resolver los ejercicios del 1 al 5 y explicarlos

---

# gemini response

### Ejercicio 1

**a) Dispositivos de la LAN A que pertenecen a la misma red física entre sí**:

* **Dispositivos:** El host `192.168.1.10`, el host `192.168.1.11`, el switch **SW1** y la **interfaz local del router R1** conectada a esa red.
* **Explicación:** Un switch de capa 2 interconecta equipos dentro del mismo medio de difusión y no divide redes lógicas ni físicas. La frontera física y lógica de la LAN termina en la interfaz de red del router R1 (su puerta de enlace o *default gateway*), por lo que todos los elementos conectados al switch SW1 comparten el mismo dominio de colisión/difusión local.

**b) Dispositivos por los que pasa el paquete desde LAN A hasta LAN C (en orden)**:

1. **Host emisor en LAN A** (`192.168.1.10` o `192.168.1.11`).
2. **Switch SW1** (conmuta la trama en Capa 2 hacia el gateway).
3. **Router R1** (desencapsula la trama, consulta su tabla de enrutamiento y reenvía el datagrama hacia R2).
4. **Router R2** (recibe el paquete, identifica que la red `192.168.3.0` está directamente conectada a su interfaz LAN y reenvía hacia SW2).
5. **Switch SW2** (conmuta la trama hacia el puerto físico del destino).
6. **Host receptor en LAN C** (`192.168.3.40`).

---

### Ejercicio 2

**a) ¿El protocolo IP detecta esta pérdida? ¿La retransmite por sí mismo? Justifique.**

* **Respuesta:** No, el protocolo IP no detecta la pérdida ni retransmite datagramas.
* **Justificación:** IP proporciona un servicio de entrega de **"mejor esfuerzo" (*best-effort*)**, no confiable y no orientado a conexión. Cada datagrama es tratado como una unidad independiente y el protocolo carece de mecanismos de seguimiento de estado, números de secuencia de confirmación o temporizadores de retransmisión. Si las colas de memoria de un router se saturan por congestión, los datagramas excedentes se descartan silenciosamente a nivel IP.

**b) ¿Qué protocolo/capa sería responsable de garantizar la entrega confiable de ese dato?**

* La **Capa de Transporte (Capa 4)**, a través del protocolo **TCP (Transmission Control Protocol)**. TCP implementa acuses de recibo (ACK), números de secuencia y temporizadores de retransmisión para reenviar automáticamente cualquier dato perdido durante el tránsito.

**c) Tabla comparativa**:

| Característica | Servicio orientado a conexión y confiable | Servicio no orientado a conexión (*best-effort*) |
| :--- | :--- | :--- |
| **¿Garantiza entrega?** | **Sí** (detecta pérdidas y retransmite mediante ACKs y timeouts). | **No** (los paquetes pueden perderse sin notificación ni reenvío). |
| **¿Garantiza orden?** | **Sí** (reordena los segmentos en destino usando números de secuencia). | **No** (cada datagrama sigue caminos independientes y puede llegar desordenado). |
| **¿Establece conexión previa?** | **Sí** (acuerdo inicial mediante saludo de tres vías o *3-way handshake*). | **No** (los datos se envían directamente sin negociación previa). |
| **Ejemplo de protocolo** | **TCP**. | **IP**, **UDP**. |

---

### Ejercicio 3

Para clasificar las direcciones IP bajo el esquema de direccionamiento con clases (*classful*), se analiza el valor numérico del **primer octeto**:

* **Clase A:** Rango `1` a `126` (bits iniciales `0`), máscara `/8` (`255.0.0.0`). La red `127.0.0.0` está reservada para loopback/pruebas internas y `0.0.0.0` para la red local.
* **Clase B:** Rango `128` a `191` (bits iniciales `10`), máscara `/16` (`255.255.0.0`).
* **Clase C:** Rango `192` a `223` (bits iniciales `110`), máscara `/24` (`255.255.255.0`).
* **Clase D:** Rango `224` a `239` (bits iniciales `1110`), reservada para multidifusión (*multicast*). No utiliza división de red/host ni máscara de subred tradicional.

| Dirección IP | Clase | Máscara por defecto | Rango de la clase | Dirección de red |
| :--- | :---: | :---: | :---: | :---: |
| **10.5.3.1** | **A** | `255.0.0.0` (/8) | `1.0.0.0` – `126.255.255.255` | `10.0.0.0` |
| **172.20.14.9** | **B** | `255.255.0.0` (/16) | `128.0.0.0` – `191.255.255.255` | `172.20.0.0` |
| **192.168.5.100** | **C** | `255.255.255.0` (/24) | `192.0.0.0` – `223.255.255.255` | `192.168.5.0` |
| **224.0.0.5** | **D** | *No aplica* (Multicast) | `224.0.0.0` – `239.255.255.255` | *No aplica* (Grupo multicast) |
| **126.1.1.1** | **A** | `255.0.0.0` (/8) | `1.0.0.0` – `126.255.255.255` | `126.0.0.0` |
| **191.200.10.5** | **B** | `255.255.0.0` (/16) | `128.0.0.0` – `191.255.255.255` | `191.200.0.0` |
| **223.255.255.1** | **C** | `255.255.255.0` (/24) | `192.0.0.0` – `223.255.255.255` | `223.255.255.0` |
| **11.0.0.5** | **A** | `255.0.0.0` (/8) | `1.0.0.0` – `126.255.255.255` | `11.0.0.0` |

---

### Ejercicio 4

Para calcular los parámetros de cada subred:

1. **Bits de host ($h$):** $32 - \text{prefijo CIDR}$.
2. **Tamaño de bloque o salto:** $2^h$ (en el octeto donde cae la frontera de la máscara).
3. **Dirección de red:** Se colocan en 0 todos los bits de la porción de host.
4. **Dirección de broadcast:** Se colocan en 1 todos los bits de la porción de host.
5. **Rango utilizable:** Desde $(\text{Red} + 1)$ hasta $(\text{Broadcast} - 1)$.

* **192.168.10.45/26**: Máscara `255.255.255.192`. $h = 6$ bits, salto de $2^6 = 64$ en el 4° octeto. Como $45$ está en el intervalo de $0$ a $63$:
  * Red: `192.168.10.0` | Broadcast: `192.168.10.63` | Rango: `192.168.10.1` a `192.168.10.62`.
* **10.20.35.130/20**: Máscara `255.255.240.0`. La máscara afecta al 3° octeto; $h = 12$ bits totales ($4$ bits en el 3° octeto, $8$ en el 4°). Salto de $2^4 = 16$ en el 3° octeto. Múltiplos de 16: $0, 16, 32, 48\dots$ El múltiplo menor o igual a 35 es 32:
  * Red: `10.20.32.0` | Broadcast: `10.20.47.255` | Rango: `10.20.32.1` a `10.20.47.254`.
* **172.16.100.5/28**: Máscara `255.255.255.240`. $h = 4$ bits, salto de $2^4 = 16$ en el 4° octeto. Como $5$ cae en el intervalo de $0$ a $15$:
  * Red: `172.16.100.0` | Broadcast: `172.16.100.15` | Rango: `172.16.100.1` a `172.16.100.14`.
* **200.10.5.200/29**: Máscara `255.255.255.248`. $h = 3$ bits, salto de $2^3 = 8$ en el 4° octeto. $200$ es múltiplo exacto de 8 ($200 / 8 = 25$):
  * Red: `200.10.5.200` | Broadcast: `200.10.5.207` | Rango: `200.10.5.201` a `200.10.5.206`.
* **192.168.0.70/25**: Máscara `255.255.255.128`. $h = 7$ bits, salto de $2^7 = 128$ en el 4° octeto. Intervalos: $0-127$ y $128-255$. $70$ cae en el primer bloque:
  * Red: `192.168.0.0` | Broadcast: `192.168.0.127` | Rango: `192.168.0.1` a `192.168.0.126`.

| IP/máscara (CIDR) | Dirección de red | Dirección de broadcast | Primer host válido | Último host válido |
| :--- | :--- | :--- | :--- | :--- |
| **192.168.10.45/26** | `192.168.10.0` | `192.168.10.63` | `192.168.10.1` | `192.168.10.62` |
| **10.20.35.130/20** | `10.20.32.0` | `10.20.47.255` | `10.20.32.1` | `10.20.47.254` |
| **172.16.100.5/28** | `172.16.100.0` | `172.16.100.15` | `172.16.100.1` | `172.16.100.14` |
| **200.10.5.200/29** | `200.10.5.200` | `200.10.5.207` | `200.10.5.201` | `200.10.5.206` |
| **192.168.0.70/25** | `192.168.0.0` | `192.168.0.127` | `192.168.0.1` | `192.168.0.126` |

---

### Ejercicio 5

Bloque base asignado: `192.168.20.0/24`.  
Regla VLSM: Para evitar solapamientos, se ordenan los requerimientos de mayor a menor cantidad de hosts y se aplica la fórmula $2^h - 2 \ge \text{Hosts requeridos}$:

1. **Ventas (50 hosts requeridos)**:
   * $2^6 - 2 = 62 \ge 50 \implies h = 6$ bits.
   * Prefijo: $32 - 6 = \mathbf{/26}$ (Máscara: `255.255.255.192`).
   * Salto: $2^6 = 64$.
   * Red asignada: `192.168.20.0/26`.
2. **IT (20 hosts requeridos)**:
   * $2^5 - 2 = 30 \ge 20 \implies h = 5$ bits.
   * Prefijo: $32 - 5 = \mathbf{/27}$ (Máscara: `255.255.255.224`).
   * Salto: $2^5 = 32$.
   * Red asignada (inicia donde terminó Ventas): `192.168.20.64/27`.
3. **Depósito (10 hosts requeridos)**:
   * $2^4 - 2 = 14 \ge 10 \implies h = 4$ bits.
   * Prefijo: $32 - 4 = \mathbf{/28}$ (Máscara: `255.255.255.240`).
   * Salto: $2^4 = 16$.
   * Red asignada: `192.168.20.96/28`.
4. **Enlace WAN (2 hosts requeridos)**:
   * $2^2 - 2 = 2 \ge 2 \implies h = 2$ bits.
   * Prefijo: $32 - 2 = \mathbf{/30}$ (Máscara: `255.255.255.252`).
   * Salto: $2^2 = 4$.
   * Red asignada: `192.168.20.112/30`.

| Sector (ordenado) | Máscara asignada | Dirección de red | Rango de hosts válidos | Broadcast |
| :--- | :---: | :---: | :---: | :---: |
| **Ventas** (50 hosts) | `255.255.255.192` (/26) | `192.168.20.0` | `192.168.20.1` – `192.168.20.62` | `192.168.20.63` |
| **IT** (20 hosts) | `255.255.255.224` (/27) | `192.168.20.64` | `192.168.20.65` – `192.168.20.94` | `192.168.20.95` |
| **Depósito** (10 hosts) | `255.255.255.240` (/28) | `192.168.20.96` | `192.168.20.97` – `192.168.20.110` | `192.168.20.111` |
| **Enlace WAN** (2 hosts) | `255.255.255.252` (/30) | `192.168.20.112` | `192.168.20.113` – `192.168.20.114` | `192.168.20.115` |
