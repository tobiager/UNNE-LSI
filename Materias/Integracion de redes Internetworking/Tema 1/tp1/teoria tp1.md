Para facilitarte la resolución de los ejercicios de tu trabajo práctico de **Internetworking**, aquí tienes una revisión detallada de cada uno de ellos junto con la **explicación teórica exhaustiva y los pasos matemáticos** que necesitas aplicar, todo estrictamente fundamentado en tus fuentes de estudio.

---

### **Ejercicio 1: Topología Física, Segmentos de Red y Enrutamiento**

Este ejercicio te pide identificar los dispositivos de una LAN que pertenecen a la misma red física y describir el camino que sigue un paquete de una red a otra.

* **La Teoría que necesitas:**
  * **¿Qué es una red física o segmento de red?** Tus fuentes explican una regla mental muy sencilla: **para saber cuántos segmentos de red hay en una topología, debes eliminar mentalmente los routers**, ya que estos dispositivos tienen la función específica de interconectar redes físicamente independientes. Todas las partes de la topología que queden aisladas tras esta eliminación mental (aunque se trate de un único cable que une dos equipos) constituyen una red física independiente o subred.
  * **El rol del Switch (Conmutador):** Los switches (como SW1 o SW2) operan a nivel local. Su función principal es interconectar los dispositivos que pertenecen a la **misma red física** para que se comuniquen de forma directa.
  * **El rol del Router (Encaminador):** Se encarga de unir redes heterogéneas y físicamente independientes para que funcionen como un sistema lógico único.
* **Cómo aplicarlo al Ejercicio:**
  * Para la parte **a)**, observa los dispositivos conectados a SW1 sin pasar por ningún router; todos ellos comparten el mismo medio de transmisión física directo y, por ende, pertenecen a la misma red física.
  * Para la parte **b)**, traza el camino físico del paquete desde el host origen en la LAN A. Al querer comunicarse con un host de otra red (LAN C), el paquete no puede ser entregado de manera local por el switch. Debe ser enviado obligatoriamente a su puerta de enlace (la interfaz de R1), viajar por el enlace físico entre routers (R1 a R2), llegar al router destino (R2), ser enviado al switch local (SW2) y finalmente ser recibido por el host destino.

---

### **Ejercicio 2: Características de los Protocolos IP y TCP (Servicios del Nivel de Red y Transporte)**

Aquí debes determinar si el protocolo IP detecta la pérdida de paquetes o si los retransmite, identificar la capa responsable de garantizar la confiabilidad y rellenar una tabla comparativa de servicios orientados y no orientados a conexión.

* **La Teoría que necesitas:**
  * **El servicio Best-Effort de IP (Nivel de Red):** El protocolo de Internet (IP) proporciona un **servicio de entrega de paquetes sin conexión y no confiable**. Tus fuentes definen esto de manera muy clara: IP no ofrece garantías sobre la entrega de datagramas. Realiza el **máximo esfuerzo posible (best-effort)** para transportar cada paquete, pero si un router intermedio experimenta congestión, fallas en un enlace o si expira el tiempo de vida (TTL) del paquete, **el datagrama es descartado y el protocolo IP no intenta retransmitirlo**. Cada datagrama se procesa como una unidad independiente, por lo que IP no garantiza la entrega, el orden original, la ausencia de duplicados ni la recuperación de errores.
  * **El transporte confiable de TCP (Nivel de Transporte):** Las aplicaciones suelen requerir una comunicación libre de errores. Para solucionar las limitaciones de IP, la arquitectura delega la confiabilidad en protocolos de capas superiores. El encargado es el protocolo **TCP (Transmission Control Protocol)** en la capa de transporte, el cual establece una conexión lógica extremo a extremo. TCP divide el flujo de datos en paquetes y espera que el receptor envíe **mensajes de reconocimiento (acknowledgements)** para confirmar la recepción. Si un paquete se pierde o daña, TCP se encarga de **retransmitirlo automáticamente**.
* **Cómo rellenar la Tabla Comparativa:**
  * **Servicio orientado a conexión y confiable (TCP):**
    * *¿Garantiza entrega?* **Sí**, mediante confirmaciones y retransmisiones automáticas.
    * *¿Garantiza el orden?* **Sí**, reconstruye el flujo continuo de datos en el receptor de forma transparente.
    * *¿Establece conexión previa?* **Sí**, requiere establecer una conexión lógica antes de transmitir los datos.
    * *Ejemplo de protocolo:* **TCP**.
  * **Servicio no orientado a conexión / Best-effort (IP):**
    * *¿Garantiza entrega?* **No**, realiza el mejor esfuerzo pero no asegura la recepción.
    * *¿Garantiza el orden?* **No**, cada datagrama viaja de forma independiente y puede llegar desordenado.
    * *¿Establece conexión previa?* **No**, envía los bloques directamente utilizando el direccionamiento de cada paquete.
    * *Ejemplo de protocolo:* **IP**.

---

### **Ejercicio 3: Direccionamiento IPv4 con Clases**

Te pide completar una tabla indicando la clase, máscara por defecto, rango de la clase y dirección de red para diferentes direcciones IP.

* **La Teoría que necesitas:**
  * **El Direccionamiento con Clases:** En las primeras especificaciones de IP (RFC 791) se definió un direccionamiento rígido donde las clases se establecen en base a los primeros bits de la dirección IP.
  * **Cómo identificar la Clase y sus rangos (analizando el primer byte de la IP en decimal):**
    * **Clase A:** El primer bit en binario es `0`. Rango del primer byte: **0 a 127** (nota: el rango de hosts asignables suele considerarse de 1 a 126, y el 127 se reserva para bucle local o loopback). Máscara de red por defecto: **255.0.0.0** (o prefijo **`/8`** en notación CIDR).
    * **Clase B:** Los primeros bits son `10`. Rango del primer byte: **128 a 191**. Máscara de red por defecto: **255.255.0.0** (o prefijo **`/16`**).
    * **Clase C:** Los primeros bits son `110`. Rango del primer byte: **192 a 223**. Máscara de red por defecto: **255.255.255.0** (o prefijo **`/24`**).
    * **Clase D:** Los primeros bits son `1110`. Rango del primer byte: **224 a 239**. Se utiliza exclusivamente para **multidifusión (multicast)**. *Nota:* Al no estar destinadas al direccionamiento de hosts individuales, no tienen una "dirección de red de host" o una "máscara de red por defecto" estándar para hosts.
    * **Clase E:** Los primeros bits son `1111`. Rango del primer byte: **240 a 255**. Están reservadas para investigación.
  * **Cálculo de la Dirección de Red:** Consiste en tomar el prefijo de la red (los primeros N bits definidos por la máscara por defecto) y **fijar a '0' todos los bits correspondientes a la parte de host**.
* **Cómo aplicarlo al Ejercicio:**
  * *Ejemplo 1 (IP `10.5.3.1`):* El primer byte es `10`, por lo que cae en el rango de **Clase A (0-127)**. Su máscara por defecto es **255.0.0.0**. Como la parte de red son los primeros 8 bits, mantienes el `10` y pones a cero los bytes restantes de host, obteniendo la dirección de red: **10.0.0.0**.
  * *Ejemplo 2 (IP `192.168.5.100`):* El primer byte es `192`, lo que corresponde a **Clase C (192-223)**. Su máscara por defecto es **255.255.255.0**. Mantienes los primeros tres bytes de red y pones a cero el último byte de host, resultando en la dirección de red: **192.168.5.0**.
  * *Ejemplo 3 (IP `224.0.0.5`):* El primer byte es `224`, indicando que es **Clase D (multidifusión)**. Al ser de multidifusión, su rango de clase es de **224.0.0.0 a 239.255.255.255**, y no tiene asignable una dirección de red de host convencional ni máscara por defecto de host.

---

### **Ejercicio 4: Cálculo de Direccionamiento CIDR (Subredes, Broadcast y Rango de Hosts)**

Para combinaciones específicas de IP/máscara (ej. `192.168.10.45/26`), debes calcular la dirección de red, de broadcast, primer host válido y último host válido.

* **La Teoría que necesitas:**
  * **Notación CIDR:** La dirección IP de 32 bits se acompaña de un `/N`, donde **`N` es la longitud del prefijo de red** (la cantidad de bits configurados a '1' en la máscara) y los restantes **`32 - N` bits se reservan para identificar a los hosts**.
  * **Cálculo de la Dirección de Red:** Mantienes intacto el prefijo de $(N$) bits y **fijas a '0' todos los $(32 - N$) bits restantes**.
  * **Cálculo de la Dirección de Broadcast:** Mantienes intacto el prefijo de $(N$) bits y **fijas a '1' todos los $(32 - N$) bits de la parte de host**.
  * **Rango de Hosts Válidos:** Las direcciones asignables a los hosts de una subred son aquellas que se encuentran estrictamente entre la dirección de red y la de broadcast:
    * **Primer host válido:** Es la dirección inmediatamente posterior a la dirección de red (**Dirección de Red + 1** en el último byte).
    * **Último host válido:** Es la dirección inmediatamente anterior a la de broadcast (**Dirección de Broadcast - 1** en el último byte).
* **Ejemplo de cómo hacer los cálculos matemáticos paso a paso:**
  * Tomemos la dirección **`192.168.10.45/26`**:
        1. La máscara es `/26`. Los primeros 3 octetos (24 bits) están completos en la parte de red (`192.168.10`). Los 2 bits restantes para completar los 26 caen dentro del **cuarto octeto** (26 - 24 = 2 bits de red).
        2. El cuarto octeto de nuestra IP es **`45`**. Al convertirlo a binario obtenemos un entero de 8 bits:
            $[\mathbf{45} = \mathbf{00}101101_2$]
        3. Dividimos este cuarto octeto según el límite del prefijo (los primeros **2 bits son de red** y los **6 bits restantes son de host**):
            $[\text{Red: } \mathbf{00} \quad \big| \quad \text{Host: } 101101$]
        4. **Dirección de Red:** Deja los bits de red intactos y pon los 6 bits de host en `0`:
            $[\mathbf{00}000000_2 = 0 \quad \rightarrow \quad \mathbf{192.168.10.0/26}$]
        5. **Dirección de Broadcast:** Deja los bits de red intactos y pon los 6 bits de host en `1`:
            $[\mathbf{00}111111_2 = 32 + 16 + 8 + 4 + 2 + 1 = 63 \quad \rightarrow \quad \mathbf{192.168.10.63/26}$]
        6. **Primer host válido:** Dirección de red + 1 $(\rightarrow$) **`192.168.10.1`**.
        7. **Último host válido:** Dirección de broadcast - 1 $(\rightarrow$) **`192.168.10.62`**.

---

### **Ejercicio 5: Diseño de Esquemas de Direccionamiento VLSM**

Debes dividir un bloque principal (`192.168.20.0/24`) en 4 subredes para satisfacer diferentes requisitos de hosts (Ventas: 50, IT: 20, Depósito: 10, Enlace WAN: 2).

* **La Teoría que necesitas:**
  * **¿Qué es VLSM?** Las máscaras de subred de longitud variable permiten adaptar el tamaño de la parte de host a la cantidad exacta de equipos requeridos, optimizando el espacio y evitando el desperdicio de direcciones.
  * **Tres Premisas Fundamentales para el reparto de bloques**:
        1. El tamaño de cada bloque de direcciones asignado a una subred debe ser obligatoriamente una **potencia de dos** ($(2^h$)).
        2. El bloque debe comenzar en una **dirección IP que sea múltiplo exacto de su propio tamaño**.
        3. Los bloques asignados a las diferentes subredes **no deben solaparse**.
* **Procedimiento paso a paso para diseñar tu VLSM:**
    1. **Ordenar los sectores de mayor a menor según la cantidad de hosts requeridos**. En tu caso, el orden correcto es:
        * Ventas (50 hosts) $(\rightarrow$) IT (20 hosts) $(\rightarrow$) Depósito (10 hosts) $(\rightarrow$) Enlace WAN (2 hosts).
    2. **Calcular el tamaño de bloque necesario para cada sector:** Al número de hosts requeridos debes sumarle **2 direcciones especiales obligatorias** (1 para la dirección de red y 1 para la de broadcast). Tras sumarlas, redondeas el resultado a la **potencia de dos inmediata superior**.
        * *Ventas:* $(50 + 2 = 52 \rightarrow$) Redondea a la potencia de dos superior: **64** direcciones ($(2^6$)).
        * *IT:* $(20 + 2 = 22 \rightarrow$) Redondea a la potencia de dos superior: **32** direcciones ($(2^5$)).
        * *Depósito:* $(10 + 2 = 12 \rightarrow$) Redondea a la potencia de dos superior: **16** direcciones ($(2^4$)).
        * *Enlace WAN:* $(2 + 2 = 4 \rightarrow$) Redondea a la potencia de dos superior: **4** direcciones ($(2^2$)).
    3. **Calcular la máscara de subred para cada sector:** Réstale a 32 (la longitud total de una dirección IPv4) el exponente de la potencia de dos de la porción de host ($(h$)).
        * *Ventas (bloque de 64 = $(2^6$)):* Máscara = $(32 - 6 = \mathbf{/26}$).
        * *IT (bloque de 32 = $(2^5$)):* Máscara = $(32 - 5 = \mathbf{/27}$).
        * *Depósito (bloque de 16 = $(2^4$)):* Máscara = $(32 - 4 = \mathbf{/28}$).
        * *Enlace WAN (bloque de 4 = $(2^2$)):* Máscara = $(32 - 2 = \mathbf{/30}$).
    4. **Asignar las direcciones de red e ir desplazando los bloques en orden contiguo:**
        * La primera subred (Ventas) inicia en la dirección base del bloque principal: **`192.168.20.0/26`**.
        * Para hallar la dirección de red de la siguiente subred (IT), sumas el tamaño del bloque anterior (64) al último octeto de la dirección de red actual ($(0 + 64 = 64$)): **`192.168.20.64/27`**.
        * Para la siguiente (Depósito), sumas el bloque de IT (32) a la dirección de red de IT ($(64 + 32 = 96$)): **`192.168.20.96/28`**.
        * Para la última (Enlace WAN), sumas el bloque de Depósito (16) a la de Depósito ($(96 + 16 = 112$)): **`192.168.20.112/30`**.
    5. **Calcular las direcciones de broadcast y rangos de hosts para cada subred:**
        * *Dirección de Broadcast:* Toma la dirección de red de la subred, súmale su tamaño de bloque y réstale 1. (Por ejemplo, para Ventas: $(192.168.20.0 + 64 - 1 \rightarrow 192.168.20.63$)).
        * *Rango de hosts:* Va desde la (Dirección de Red + 1) hasta la (Dirección de Broadcast - 1).

---

### **Ejercicios de Simulación en Packet Tracer (Ejercicios 6, 8, 9 y 10)**

Estos ejercicios experimentales se centran en verificar de manera práctica los conceptos teóricos clave de la interconexión de redes.

* **Ejercicio 6 (Necesidad de Routers para comunicar redes distintas):** Dos redes LAN con identificadores lógicos de red diferentes (`192.168.1.0/24` y `192.168.2.0/24`) representan redes físicas distintas. Las fuentes teóricas explican que un paquete no puede fluir de una red física a otra de forma directa; requiere de un **router** configurado con **tablas de enrutamiento** (rutas estáticas o dinámicas) que analicen la dirección IP de destino y determinen el siguiente salto para que la información se encamine adecuadamente.
* **Ejercicio 8 (Prueba del servicio Best-Effort al cortar el enlace):** Al desconectar el cable serial en plena transmisión del ping, los paquetes comenzarán a fallar ("Request timed out"). La teoría que justifica esto es que el protocolo **IP proporciona un servicio no confiable "best-effort"**. Los dispositivos intermedios no asumen la responsabilidad de garantizar la entrega, por lo que ante la desconexión del enlace, los datagramas se descartan inmediatamente y **el protocolo IP no avisa al emisor ni intenta recuperarlos por sí mismo**. La comunicación se restablece de forma automática únicamente cuando el enlace físico vuelve a estar operativo, y la cantidad de paquetes perdidos se puede calcular analizando la numeración de secuencia en la consola de ICMP.
* **Ejercicio 9 (Configuración de interfaces con clases diferentes):** Al configurar las tres interfaces de tu router con direcciones de Clase A, B y C, debes asignarle a cada una su máscara por defecto correspondiente (/8, /16 o /24). El fundamento teórico de este direccionamiento radica en la **asignación estática de gateways**: es una convención de administración de red configurar la **primera dirección IP válida** de una subred en la interfaz del router (puerta de enlace), mientras que el resto de direcciones utilizables se distribuyen entre los hosts locales.
* **Ejercicio 10 (Comportamiento de direcciones de red y broadcast dentro de una LAN):**
  * **Dirección de Broadcast:** Es aquella que tiene todos los bits de host en `1`. Al enviar tráfico ICMP (ping) a esta dirección, el switch la procesa y, por su naturaleza de difusión, la propaga hacia todos sus puertos activos, provocando que todos los hosts de la LAN reciban el paquete y respondan individualmente al emisor.
  * **Dirección de Red:** Es aquella que tiene todos los bits de host en `0`. Su función es identificar únicamente a la red de forma lógica y **bajo ningún concepto puede asignarse a un host individual**. Tampoco se permite enviar paquetes dirigidos directamente a ella. Por esta razón, Packet Tracer te arrojará un error e impedirá que configures la dirección de red como la IP de una PC.

---

### **Ejercicio 7: Análisis del Encabezado IPv4 (PDU en Packet Tracer)**

Te pide capturar un paquete ICMP y registrar los campos del encabezado de IP, tales como VER, IHL, TTL, SRC IP y DEST IP.

* **La Teoría que necesitas:**
  * Tus fuentes teóricas fundamentan de forma directa tres de estos campos esenciales del encabezado IP:
    * **SRC IP (Dirección de Origen):** Dirección de 32 bits única que identifica al dispositivo que generó y envió el datagrama.
    * **DEST IP (Dirección de Destino):** Dirección de 32 bits única del dispositivo receptor final al cual va dirigido el paquete.
    * **TTL (Time To Live / Tiempo de Vida):** Es un mecanismo fundamental para prevenir que un paquete se quede atrapado viajando en bucles infinitos dentro de la red. Cada router que procesa y encamina el datagrama decrementa este valor en una unidad; si el campo llega a cero, el router descarta el datagrama para evitar la congestión innecesaria.
  * *Nota técnica sobre los campos adicionales:* Aunque tus textos teóricos no definen detalladamente las siglas **VER** e **IHL** en su glosario escrito, corresponden a los campos de control estándar del encabezado IPv4:
    * **VER (Versión):** Define la versión de IP que se está utilizando (en este caso observaras un `4` por ser IPv4).
    * **IHL (Internet Header Length):** Especifica la longitud total del encabezado IP medida en palabras de 32 bits (normalmente verás un valor de `5`, que equivale a un encabezado estándar de 20 bytes sin opciones).

---

Con estas pautas teóricas, fórmulas y explicaciones paso a paso, ya estás completamente listo para resolver y justificar de forma impecable cada punto de tu trabajo práctico.

📊 Si lo necesitas, puedo guiarte paso a paso en el desarrollo matemático completo de la tabla del Ejercicio 4 o la planificación de las subredes de VLSM del Ejercicio 5 para que valides tus propios resultados.
