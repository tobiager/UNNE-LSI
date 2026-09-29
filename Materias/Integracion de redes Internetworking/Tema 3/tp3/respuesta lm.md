A continuación se presenta la revisión exhaustiva y ordenada de los **Ejercicios 1 al 7 de la Práctica Tema 3**, acompañada de todas las fórmulas, fundamentos teóricos y desgloses paso a paso para que puedas resolverlos por ti mismo de forma independiente.

---

### **Ejercicio 1: Comparación entre Enviar-y-Esperar y Ventana Deslizante**

#### **Enunciado**

Una conexión tiene un RTT (tiempo de ida y vuelta) de *40 ms*, y cada paquete tarda *5 ms* en transmitirse por el enlace.

* **A.** Calcula el tiempo total necesario para enviar 8 paquetes usando el esquema de enviar-y-esperar (*send-and-wait*).
* **B.** Calcula el tiempo total necesario para enviar los mismos 8 paquetes usando un protocolo de ventana deslizante con tamaño de ventana $W = 8$.
* **C.** Compara el rendimiento obtenido en ambos casos y explica a qué se debe la diferencia.

#### **Fundamento Teórico**

1. **Esquema Enviar-y-Esperar (*Send-and-Wait*)**:
   * En este protocolo simple de confirmación positiva, el emisor transmite **un solo paquete a la vez** y debe detenerse a esperar la recepción del ACK correspondiente antes de poder transmitir el siguiente.
   * El tiempo total consumido por cada paquete individual ($T_{\text{paquete}}$) es la suma del **tiempo de transmisión del paquete** ($t_{\text{trans}}$) más el **tiempo de ida y vuelta del ACK** ($RTT$):
     $$T_{\text{paquete}} = t_{\text{trans}} + RTT$$
2. **Protocolo de Ventana Deslizante**:
   * Permite al emisor mantener hasta $W$ paquetes en tránsito (sin confirmar) simultáneamente antes de detenerse a esperar confirmaciones.
   * Si la ventana $W$ coincide con la cantidad total de paquetes a enviar ($W = 8$), el emisor inyecta los 8 paquetes de manera continua uno tras otro.
   * El tiempo total hasta confirmar la ráfaga completa abarca el **tiempo necesario para transmitir todos los paquetes en el enlace** ($8 \times t_{\text{trans}}$) más el **retraso de propagación e ida y vuelta del último ACK** ($RTT$).

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  Calcula el tiempo de un solo ciclo ($5\text{ ms} + 40\text{ ms} = 45\text{ ms}$) y multiplícalo por los 8 paquetes.
* **Parte B**:
  Calcula el tiempo de emisión continua de los 8 paquetes ($8 \times 5\text{ ms} = 40\text{ ms}$) y súmale el tiempo que tarda en regresar la confirmación ($40\text{ ms}$).
* **Parte C**:
  Observa que *enviar-y-esperar* mantiene el enlace inactivo durante gran parte del tiempo esperando los ACK (desperdiciando capacidad de red), mientras que la *ventana deslizante* elimina el tiempo de inactividad manteniendo el canal saturado de datos, lo que incrementa sustancialmente el rendimiento (*throughput*).

---

### **Ejercicio 2: Mecanismo de Confirmación Acumulativa y Retransmisión ante Pérdida**

#### **Enunciado**

Un emisor transmite una ventana de 5000 octetos que comienza en la posición 101 del flujo, dividida en 5 segmentos de 1000 octetos cada uno (101-1100, 1101-2100, 2101-3100, 3101-4100, 4101-5100). El primer segmento (101-1100) se pierde en la red; los otros cuatro llegan correctamente y en orden.

* **A.** Indica qué número de confirmación (ACK) enviará el receptor al recibir cada uno de los cuatro segmentos que sí llegan.
* **B.** Cuando expira el temporizador del emisor por falta de confirmación del primer segmento, ¿qué dos opciones de retransmisión tiene disponibles y por qué ambas resultan ineficientes?
* **C.** Si el emisor retransmite únicamente el primer segmento y este llega correctamente, ¿qué número de confirmación enviará entonces el receptor?

#### **Fundamento Teórico**

1. **Confirmaciones Acumulativas (*Cumulative ACKs*)**:
   * TCP numera los datos a nivel de octeto y utiliza un esquema acumulativo. El campo `ACK` que envía un receptor **especifica el número de secuencia del siguiente octeto contiguo que espera recibir**.
   * El receptor siempre confirma el prefijo contiguo más largo que ha recibido libre de errores.
2. **Recepción Desordenada y Huecos en el Flujo**:
   * Si se pierde el primer segmento (octetos 101 al 1100), el último octeto recibido de forma contigua antes del hueco es el octeto 100.
   * Aunque los segmentos posteriores (1101 a 5100) lleguen correctamente, el receptor no puede avanzar la frontera del prefijo contiguo. Por ello, ante la llegada de cada segmento posterior a la pérdida, el receptor emite un ACK duplicado solicitando el primer octeto faltante (ACK 101).
3. **Estrategias de Retransmisión por Timeout**:
   * **Opción 1**: Retransmitir **únicamente** el segmento faltante.
   * **Opción 2**: Retransmitir **todos** los segmentos a partir del faltante.
   * **Ineficiencia**: La Opción 1 resulta ineficiente si se hubieran perdido múltiples segmentos en la ventana, ya que obligaría a esperar *timeouts* sucesivos para descubrir cada hueco. La Opción 2 es ineficiente porque retransmite datos que el receptor ya recibió correctamente y tiene en su buffer, malgastando ancho de banda.

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  Al recibir los segmentos 2, 3, 4 y 5, el receptor detecta la falta del rango 101-1100. En los cuatro casos el prefijo contiguo no ha avanzado del octeto 100, por lo que responderá con **ACK 101** cuatro veces consecutivas.
* **Parte B**:
  Detalla las dos opciones (retransmitir solo el primer segmento o retransmitir la ventana completa) mencionando las desventajas de cada una según los fallos de timeout o duplicación inútil.
* **Parte C**:
  Al retransmitirse y llegar el segmento 101-1100, el receptor junta este bloque con los bloques 1101-5100 que ya tenía guardados. Ahora posee en orden del 101 al 5100, por lo que responderá solicitando el octeto **5101**.

---

### **Ejercicio 3: Establecimiento de Conexión mediante el Three-Way Handshake**

#### **Enunciado**

La máquina A inicia una conexión TCP hacia la máquina B. A elige como número de secuencia inicial $x = 2000$; B elige como número de secuencia inicial $y = 9000$.

* **A.** Indica el número de secuencia (SEQ) y los bits de código activados en el primer segmento del handshake.
* **B.** Indica los campos SEQ y ACK del segundo segmento del handshake, enviado por B.
* **C.** Indica los campos SEQ y ACK del tercer y último segmento del handshake, enviado por A.
* **D.** Si A hubiera enviado 100 octetos de datos junto con el primer segmento SYN, ¿qué valor de ACK debería usar B en su respuesta?

#### **Fundamento Teórico**

1. **El Algoritmo Handshake de Tres Pasos**:
   * **Paso 1 (Solicitud de conexión)**: A envía un segmento con el bit **SYN = 1** activado e informa su número de secuencia inicial $SEQ = x$.
   * **Paso 2 (Respuesta y confirmación)**: B responde activando **SYN = 1** y **ACK = 1**. Envía su propio número inicial $SEQ = y$ y confirma la bandera SYN de A incrementando en 1 su secuencia: $ACK = x + 1$.
   * **Paso 3 (Confirmación final)**: A confirma la conexión activando únicamente **ACK = 1**. Utiliza $SEQ = x + 1$ y confirma la secuencia de B mediante $ACK = y + 1$.
2. **Consumo de Números de Secuencia por Banderas y Datos**:
   * La bandera **SYN** consume lógicamente 1 número de secuencia en el flujo.
   * Si además de la bandera SYN se transportan $N$ octetos de datos en el segmento inicial, el número de secuencia consumido abarcará $1 + N$ octetos.

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  Primer segmento (A $\to$ B): $SEQ = 2000$, bit de código **SYN = 1**.
* **Parte B**:
  Segundo segmento (B $\to$ A): $SEQ = 9000$, $ACK = 2000 + 1 = 2001$, bits de código **SYN = 1, ACK = 1**.
* **Parte C**:
  Tercer segmento (A $\to$ B): $SEQ = 2001$, $ACK = 9000 + 1 = 9001$, bit de código **ACK = 1**.
* **Parte D**:
  Si el SYN contiene 100 octetos (del 2000 al 2099 más el consumo del propio SYN), B deberá responder solicitando el octeto $ACK = x + 1 + 100 = 2101$.

---

### **Ejercicio 4: Identificación Única de Conexiones TCP y Puntos Finales**

#### **Enunciado**

Un servidor DNS con dirección IP 150.10.5.1 escucha en el puerto TCP 53. Recibe simultáneamente solicitudes de tres clientes distintos con puntos finales locales: (200.1.1.10, 1050), (200.1.1.20, 1050) y (200.1.1.10, 2200).

* **A.** Escribe el par de puntos finales que identifica cada una de las tres conexiones TCP resultantes en el servidor.
* **B.** Explica por qué no existe ambigüedad, aunque dos clientes distintos usen el mismo número de puerto local (1050) y aunque las tres conexiones compartan el mismo puerto 53 en el servidor.

#### **Fundamento Teórico**

1. **Identificación por Tupla de 4 Elementos**:
   * En TCP, una conexión completa se define de manera unívoca mediante la combinación de **sus dos puntos finales**.
   * Cada punto final es un par compuesto por `(Dirección IP, Número de Puerto)`. Por tanto, la conexión queda caracterizada por la tupla:
     $$\text{Conexión} = (\text{IP}*{\text{origen}}, \text{Puerto}*{\text{origen}}, \text{IP}*{\text{destino}}, \text{Puerto}*{\text{destino}})$$
2. **Demultiplexado sin Ambigüedad**:
   * El sistema operativo puede mantener múltiples conexiones activas sobre un mismo puerto de servidor (como el puerto 53) siempre que la tupla completa de 4 elementos difiera en al menos uno de los valores para cada cliente.

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  Escribe la combinación de pares para cada cliente conectándose al servidor (150.10.5.1, 53):
  1. `(200.1.1.10, 1050)` y `(150.10.5.1, 53)`
  2. `(200.1.1.20, 1050)` y `(150.10.5.1, 53)`
  3. `(200.1.1.10, 2200)` y `(150.10.5.1, 53)`
* **Parte B**:
  Justifica que la conexión 1 y la 2 se distinguen por la IP de origen (200.1.1.10 vs 200.1.1.20), y la conexión 1 y la 3 se distinguen por el puerto de origen (1050 vs 2200). La tupla global resultante es 100% única en todos los casos.

---

### **Ejercicio 5: Control de Flujo Extremo a Extremo y Anuncio de Ventana**

#### **Enunciado**

Un receptor dispone de un buffer de 8000 octetos, inicialmente vacío. Los datos llegan por la red más rápido de lo que la aplicación los va leyendo.

* **A.** Si el receptor ha almacenado 3000 octetos sin que la aplicación los haya leído todavía, ¿qué tamaño de ventana anunciará en su próximo ACK?
* **B.** Si el buffer llega a llenarse por completo antes de que la aplicación lea ningún dato, ¿qué valor de ventana anunciará el receptor, y qué efecto provoca ese valor en el emisor?
* **C.** Si a continuación la aplicación lee 2000 octetos del buffer lleno, ¿qué nuevo tamaño de ventana puede anunciar el receptor en su siguiente ACK?

#### **Fundamento Teórico**

1. **Control de Flujo Extremo a Extremo**:
   * TCP evita que un emisor veloz desborde la capacidad de almacenamiento de un receptor más lento regulando dinámicamente el flujo mediante el campo `WINDOW` en los encabezados.
2. **Cálculo de la Ventana Anunciada (*Window Advertisement*)**:
   * El valor anunciado en el campo `WINDOW` refleja la **cantidad de espacio libre disponible en el buffer del receptor**:
     $$\text{Ventana Anunciada} = \text{Capacidad Total del Buffer} - \text{Octetos Almacenados sin Leer}$$
3. **Ventana Cero (*Zero Window*)**:
   * Anunciar una ventana de 0 bloquea al emisor, forzándolo a detener la transmisión de datos inmediatamente hasta que el receptor libere espacio y reanude la comunicación con un anuncio positivo.

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  Resta al buffer total de 8000 los 3000 octetos ocupados: $8000 - 3000 = 5000\text{ octetos}$.
* **Parte B**:
  Si los 8000 octetos están ocupados, el espacio libre es $8000 - 8000 = 0$. Anuncia **ventana 0**, lo que detiene la transmisión del emisor.
* **Parte C**:
  Al leer la aplicación 2000 octetos, se liberan en el buffer. La nueva ventana disponible pasa a ser **2000 octetos**.

---

### **Ejercicio 6: Estimación Adaptativa del RTT (Promedio Ponderado Exponencial)**

#### **Enunciado**

Usando la fórmula $\text{EstimatedRTT} = \alpha \times \text{EstimatedRTT} + (1 - \alpha) \times \text{SampleRTT}$, con $\alpha = 0.9$ y una estimación inicial $\text{EstimatedRTT}_0 = 100\text{ ms}$, calcula paso a paso el nuevo valor de $\text{EstimatedRTT}$ tras cada una de las siguientes muestras sucesivas de RTT: $140\text{ ms}$, luego $180\text{ ms}$, luego $120\text{ ms}$.

#### **Fundamento Teórico**

1. **Algoritmo Adaptativo de RTT de TCP**:
   * Debido a la naturaleza variable del tráfico en Internet, TCP mide continuamente las muestras de tiempo de ida y vuelta ($\text{SampleRTT}$) para estimar el RTT promedio ($\text{EstimatedRTT}$) y ajustar sus temporizadores de retransmisión.
2. **Promedio Ponderado Exponencial Móvil (EWMA)**:
   * La fórmula suaviza las variaciones mediante una constante de ponderación $\alpha$ ($0 \le \alpha < 1$):
     $$\text{EstimatedRTT}*{\text{nuevo}} = \alpha \cdot \text{EstimatedRTT}*{\text{anterior}} + (1 - \alpha) \cdot \text{SampleRTT}$$
   * Un $\alpha = 0.9$ pondera con gran fuerza el historial previo (90%), haciendo que el promedio sea estable e inmune a fluctuaciones esporádicas de la red.

#### **Guía de Resolución Paso a Paso**

* **Muestra 1 ($\text{SampleRTT}_1 = 140\text{ ms}$)**:
  $$\text{EstimatedRTT}_1 = (0.9 \times 100) + (0.1 \times 140) = 90 + 14 = 104\text{ ms}$$
* **Muestra 2 ($\text{SampleRTT}_2 = 180\text{ ms}$)**:
  $$\text{EstimatedRTT}_2 = (0.9 \times 104) + (0.1 \times 180) = 93.6 + 18 = 111.6\text{ ms}$$
* **Muestra 3 ($\text{SampleRTT}_3 = 120\text{ ms}$)**:
  $$\text{EstimatedRTT}_3 = (0.9 \times 111.6) + (0.1 \times 120) = 100.44 + 12 = 112.44\text{ ms}$$

---

### **Ejercicio 7: Temporizador de Retransmisión, Timer Backoff y Algoritmo de Karn**

#### **Enunciado**

El timeout actual de una conexión es de $200\text{ ms}$. El emisor transmite un segmento, el temporizador expira sin recibir confirmación, y el emisor retransmite. Se usa un factor de retroceso multiplicativo $\gamma = 2$.

* **A.** Calcula el valor del timeout tras la primera retransmisión, y el valor tras una eventual segunda retransmisión del mismo segmento.
* **B.** Según el algoritmo de Karn, ¿debe usarse la muestra de RTT obtenida a partir del ACK de un segmento retransmitido para actualizar la estimación del RTT? Justifica la respuesta.

#### **Fundamento Teórico**

1. **Retroceso del Temporizador (*Timer Backoff*)**:
   * Cuando ocurre un timeout, TCP asume la existencia de congestión o pérdida en la red y aplica un retroceso exponencial a su temporizador duplicando el valor de expiración en cada retransmisión sucesiva mediante el factor multiplicativo $\gamma$:
     $$\text{nuevo\_timeout} = \gamma \times \text{timeout\_actual}$$
2. **Ambigüedad de Confirmación (*ACK Ambiguity*)**:
   * Cuando se retransmite un paquete y posteriormente llega su ACK, el emisor no puede determinar si la confirmación responde a la primera emisión (que sufrió un retraso severo) o a la retransmisión posterior.
3. **Regla del Algoritmo de Karn**:
   * Para no distorsionar las mediciones de RTT con datos ambiguos, el **Algoritmo de Karn** prohíbe taxativamente actualizar el $\text{EstimatedRTT}$ con muestras de paquetes retransmitidos.
   * Adicionalmente, exige mantener el timeout elevado (producto del retroceso) para las transmisiones siguientes hasta obtener una confirmación válida no ambigua.

#### **Guía de Resolución Paso a Paso**

* **Parte A**:
  * Tras la 1ª retransmisión: $\text{Timeout}_1 = 2 \times 200\text{ ms} = 400\text{ ms}$.
  * Tras la 2ª retransmisión: $\text{Timeout}_2 = 2 \times 400\text{ ms} = 800\text{ ms}$.
* **Parte B**:
  Responde que **no se debe usar** dicha muestra. Justifica indicando que el esquema de confirmación acumulativa genera *ambigüedad de confirmación*, impidiendo saber a qué envío corresponde el ACK; usarla provocaría un cálculo erróneo del RTT medio en la conexión.

---

💡 ¿Te gustaría resolver estos ejercicios por tu cuenta y que revisemos juntos tus resultados numéricos finales para confirmar que todo esté correcto?
