# you asked

¿podrias explicar respecto a la teoria y verificar las respuestas?

---

# gemini response

A continuación se presenta la verificación de cada una de las respuestas del parcial y su explicación teórica fundamentada en los documentos de la materia:

---

### **1) Completar cuadro de Direcciones IP**

* **Respuesta en el examen:**
  * `217.61.86.109` $\rightarrow$ Clase C, Máscara `255.255.255.0 (/24)`, Dirección de red `217.61.86.0`.
  * `98.230.0.76` $\rightarrow$ Clase A, Máscara `255.0.0.0 (/8)`, Dirección de red `98.0.0.0`.
  * `163.224.104.41` $\rightarrow$ Clase B, Máscara `255.255.0.0 (/16)`, Dirección de red `163.224.0.0`.
* **Estado:** **Correcto**.
* **Explicación teórica:**
  * En el direccionamiento con clases (*classful addressing* RFC 791):
    * **Clase A:** Primer octeto en el rango $1\text{--}126$. Tiene prefijo de red de 8 bits (`/8`, máscara `255.0.0.0`). La parte de host (los últimos 3 octetos) se pone a 0 para la dirección de red (`98.0.0.0`).
    * **Clase B:** Primer octeto en el rango $128\text{--}191$. Prefijo de red de 16 bits (`/16`, máscara `255.255.0.0`). Los 2 últimos octetos a 0 determinan la red (`163.224.0.0`).
    * **Clase C:** Primer octeto en el rango $192\text{--}223$. Prefijo de red de 24 bits (`/24`, máscara `255.255.255.0`). El último octeto a 0 define la red (`217.61.86.0`).

---

### **2) Tiempos de transmisión y RTT**

* **Datos:** RTT = $36\text{ ms}$, tiempo de transmisión ($T_{tx}$) = $7\text{ ms}$.

#### **a- Esquema Enviar-y-Esperar (Send-and-Wait)**

* **Respuesta en el examen:** $258\text{ ms}$.
* **Estado:** **Correcto**.
* **Explicación teórica:**
  * En enviar-y-esperar, el emisor transmite un paquete y queda inactivo esperando el reconocimiento (ACK) antes de poder transmitir el siguiente.
  * El tiempo de ciclo por paquete es:
    $$T_{\text{paquete}} = T_{tx} + \text{RTT} = 7\text{ ms} + 36\text{ ms} = 43\text{ ms}$$
  * Para $6$ paquetes consecutivos:
    $$\text{Total} = 6 \times 43\text{ ms} = 258\text{ ms}$$

#### **b- Ventana deslizante (tamaño de ventana = 7, para 7 paquetes)**

* **Respuesta en el examen:** $85\text{ ms}$.
* **Estado:** **Correcto**.
* **Explicación teórica:**
  * El mecanismo de ventana deslizante permite enviar múltiples paquetes consecutivos sin esperar confirmación intermedia.
  * Al tener ventana $W = 7$ y exactamente $7$ paquetes por enviar, el emisor inyecta los 7 paquetes uno tras otro:
    $$T_{\text{envío}} = 7 \times 7\text{ ms} = 49\text{ ms}$$
  * Una vez transmitido el último paquete, transcurre el tiempo necesario para completar el ciclo de confirmación (RTT):
    $$\text{Total} = 49\text{ ms} + 36\text{ ms} = 85\text{ ms}$$

---

### **3) Datagrama IPv4 con TTL = 5 en bucle de enrutamiento (R1 $\rightarrow$ R2 $\rightarrow$ R3)**

* **Respuestas en el examen:**
  * a- Se descarta en **R2**, en el salto número **5**.
  * b- Genera un mensaje ICMP **Time Exceeded** y lo envía al **host que originó el datagrama**.
* **Estado:** **Correcto**.
* **Explicación teórica:**
  * El campo TTL (*Time To Live*) se decrementa en 1 unidad en cada router intermedio que reenvía el datagrama. Si llega a 0, el datagrama no puede reenviarse y es descartado inmediatamente.
  * Secuencia salto por salto:
    1. Salto 1 (R1): Recibe con $\text{TTL}=5$, decrementa a $4$ y reenvía a R2.
    2. Salto 2 (R2): Recibe con $\text{TTL}=4$, decrementa a $3$ y reenvía a R3.
    3. Salto 3 (R3): Recibe con $\text{TTL}=3$, decrementa a $2$ y reenvía a R1.
    4. Salto 4 (R1): Recibe con $\text{TTL}=2$, decrementa a $1$ y reenvía a R2.
    5. Salto 5 (R2): Recibe con $\text{TTL}=1$, decrementa a $0 \rightarrow$ **Se descarta en R2 en el salto 5**.
  * Al descartar el datagrama por expiración del tiempo de vida, el enrutador genera un mensaje ICMP de tipo *Time Exceeded* (Tiempo Excedido) dirigido a la IP de origen que emitió el paquete.

---

### **4) Handshake de 3 vías de TCP**

* **Datos:** A inicia con $x=3610$; B inicia con $y=12721$.
* **Respuesta en el examen:**
  1. A: $\text{SEQ} = 3610$, $\text{Flags} = \text{SYN}$.
  2. B: $\text{SEQ} = 12721$, $\text{ACK} = 3611$, $\text{Flags} = \text{SYN+ACK}$.
  3. A: $\text{SEQ} = 3611$, $\text{ACK} = 12722$, $\text{Flags} = \text{ACK}$.
* **Estado:** **Correcto**.
* **Explicación teórica:**
  * El establecimiento de conexión en TCP (*three-way handshake*) sincroniza los números de secuencia iniciales (ISN).
  * Un segmento `SYN` o `FIN` consume lógicamente 1 número de secuencia dentro del flujo:
    * Paso 1: A anuncia su número de secuencia inicial ($x = 3610$) con el bit `SYN`.
    * Paso 2: B confirma el SYN de A solicitando el octeto siguiente ($\text{ACK} = x + 1 = 3611$) y envía su propio ISN ($y = 12721$) con los bits `SYN` y `ACK`.
    * Paso 3: A acusa recibo del SYN de B ($\text{ACK} = y + 1 = 12722$) y utiliza como secuencia $\text{SEQ} = 3611$ con el bit `ACK`.

---

### **5) Concepto de Internetworking**

* **Respuesta en el examen:** Es la interconexión de dos o más redes de computadoras físicamente independientes y heterogéneas.
* **Estado:** **Correcto**.
* **Explicación teórica:** La teoría define textualmente *internetworking* como el concepto arquitectónico y tecnológico de unir dos o más redes de computadoras físicamente independientes y heterogéneas para que funcionen, desde la perspectiva del usuario y aplicaciones, como un sistema de comunicación lógico único y unificado.

---

### **6) Características de TCP/IP**

* **Respuesta en el examen:** Todas las anteriores (Independencia de la tecnología de red, Interconexión universal, Confirmaciones de extremo a extremo, Estándares para protocolos de aplicación).
* **Estado:** **Correcto**.
* **Explicación teórica:** Son exactamente los pilares destacados en la bibliografía de la materia: TCP/IP no depende de tecnologías subyacentes específicas (gracias al datagrama abstracto), permite comunicación global transparente entre cualquier host, garantiza confiabilidad de extremo a extremo y normaliza protocolos en la capa superior (HTTP, FTP, SMTP, etc.).

---

### **7) Objetivo de VLSM (Variable Length Subnet Masking)**

* **Respuesta en el examen:** Utilizar máscaras de distinto tamaño según la cantidad de hosts que necesita cada subred, aprovechando mejor las direcciones IP y evitando desperdiciarlas.
* **Estado:** **Correcto**.
* **Explicación teórica:** A diferencia del subnetting clásico donde todas las subredes poseen la misma máscara prefijada, VLSM permite asignar prefijos de longitudes variables adaptadas al requerimiento puntual de cada segmento, minimizando el desperdicio del espacio de direcciones IPv4.

---

### **8) Definiciones**

* **ARP:** Correcto. Permite resolver la dirección física (MAC) de un equipo dentro de la misma red local a partir de su dirección lógica IP.
* **NDP:** Correcto. *Neighbor Discovery Protocol* es el protocolo utilizado en IPv6 que reemplaza las funciones de ARP e integra el descubrimiento de vecinos y enrutadores dentro de ICMPv6.
* **Dirección de Red:** Correcto. Es la dirección donde todos los bits de host se encuentran fijados en 0. Identifica la red en las tablas de enrutamiento y no es asignable a interfaces de host individuales.
* **Partes del datagrama UDP:** Correcto. Consta conceptualmente de dos partes: el **Encabezado (UDP Header)** de 8 bytes y la **Carga útil (Payload / Data)**.

---

### **9) Proceso de resolución ARP**

* **Respuesta en el examen:** Host A envía una solicitud (*ARP Request*) mediante **broadcast**. El equipo cuya IP coincide responde con un mensaje *ARP Reply* en modo **unicast** directamente al host solicitante.
* **Estado:** **Correcto**.
* **Explicación teórica:** Dado que el host emisor desconoce qué MAC posee el destinatario, envía una trama de difusión (*broadcast*, dirección MAC destino `FF:FF:FF:FF:FF:FF`) para que todos los nodos la procesen. Únicamente la máquina dueña de la dirección IP consultada contesta, pero lo hace mediante *unicast*, ya que en la solicitud venían la IP y la MAC de origen de A.

---

### **10) Propiedades del servicio de entrega confiable de TCP**

* **Respuesta en el examen:**
  1. Orientado a flujo (*Stream*)
  2. Conexión de circuito virtual
  3. Transferencia con buffer
  4. Flujo no estructurado
  5. Comunicación full duplex
* **Estado:** **Correcto**.
* **Explicación teórica:** Corresponde a las 5 características del servicio de transporte confiable de TCP:
  1. **Flujo de octetos:** Los datos son tratados como una secuencia continua de bytes idéntica en emisor y receptor.
  2. **Circuito virtual:** Establece una conexión lógica previa que emula un canal punto a punto dedicado antes de transmitir.
  3. **Transferencia con buffer:** TCP acumula datos en memoria intermedia (*buffers*) para empaquetarlos eficientemente según el MSS.
  4. **Flujo no estructurado:** TCP entrega bytes puros sin interpretar registros, delimitadores o estructuras internas de la aplicación.
  5. **Full duplex:** La información puede circular de manera simultánea e independiente en ambos sentidos de la conexión.

---

### **Conclusión general**

Todas las respuestas del documento evaluado son **conceptualmente exactas y correctas** de acuerdo con la teoría de la materia.
