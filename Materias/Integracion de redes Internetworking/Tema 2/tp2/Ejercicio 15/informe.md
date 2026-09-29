#### **Falla 1: Segmento inalcanzable por ruta estática faltante**

* **Ubicación:** Router **R2** (`172.16.2.2`).
* **Evidencia observada:**
  * **Consola de PC-A (Captura 4):** Al ejecutar `ping 172.16.4.10` hacia LAN-E, el tráfico se interrumpe en R2, reportando `Reply from 172.16.2.2: Destination host unreachable` con un 100% de pérdida de paquetes.
  * **Modo Simulación (Capturas 5 y 6):** En la inspección del paquete generado por R2 hacia PC-A, la capa 3 del modelo OSI describe *"The device sends back an ICMP Host Unreachable message"* con **TYPE `0x03`** y **CODE `0x01`**.
* **Causa técnica:** R2 no posee en su tabla de enrutamiento una ruta válida hacia la red `172.16.4.0/24` correspondiente a LAN-E, por lo que no puede reenviar el paquete y emite el mensaje de error de vuelta al emisor.
* **Comando de corrección en Cisco IOS:**

  ```text
  R2# configure terminal
  R2(config)# ip route 172.16.4.0 255.255.255.0 Serial0/0/1
  R2(config)# end
  ```

---

#### **Falla 2: Restricción de MTU en enlace serial intermedio**

* **Ubicación:** Interfaz `Serial0/0/1` de **R3** (enlace R3 $\to$ R4).
* **Evidencia observada:**
  * **Configuración aplicada (Captura 3):** En la CLI de R3 se aplicó el comando `ip mtu 500` bajo la interfaz `Serial0/0/1`.
  * **Consola de R1 (Captura 7):** Los pings convencionales pasan, pero al ejecutar un ping extendido de **1500 bytes** hacia `172.16.3.10`, el resultado es nulo con salida `.....` (Success rate is 0 percent).
  * **Modo Simulación (Captura 8):** El datagrama de tamaño completo no puede atravesar el enlace serial R3–R4 debido a que excede la unidad máxima de transferencia configurada en dicho tramo.
* **Causa técnica:** La MTU reducida a 500 bytes bloquea o fragmenta paquetes mayores; al no completarse la transmisión de los datos completos, la comunicación falla por tamaño excesivo de datagrama en el tramo intermedio.
* **Comando de corrección en Cisco IOS:**

  ```text
  R3# configure terminal
  R3(config)# interface Serial0/0/1
  R3(config-if)# no ip mtu
  R3(config-if)# end
  ```

---

#### **Falla 3: Servicio de aplicación DNS apagado (Puerto UDP cerrado)**

* **Ubicación:** Servidor **Server-PT** (`172.16.3.10`).
* **Evidencia observada:**
  * **Configuración del Servidor (Captura 10):** En la pestaña *Services $\to$ DNS*, el servicio figura en estado **Off** a pesar de tener creado el registro tipo A para `[www.ejemplo.com](https://www.ejemplo.com)`.
  * **Consola de PC-A (Captura 11):** Al ejecutar `nslookup [www.ejemplo.com](https://www.ejemplo.com) 172.16.3.10`, la petición no resuelve el nombre y finaliza por tiempo de espera: `DNS request timed out`.
  * **Modo Simulación (Captura 12):** La solicitud llega exitosamente por Capa 3 hasta Server-PT a través del puerto UDP 53. Sin embargo, al estar el servicio inactivo, el host descarta el datagrama y responde con un mensaje ICMP dirigido a PC-A con **TYPE `0x03`** y **CODE `0x03`** (*Port Unreachable*).
* **Causa técnica:** La capa de red y los enlaces funcionan correctamente, pero la capa de transporte del servidor no encuentra ningún socket de aplicación escuchando en el puerto UDP 53, obligando a ICMP a reportar la inalcanzabilidad del puerto.
* **Acción de corrección:**
  * Acceder a **Server-PT** $\to$ pestaña **Services** $\to$ **DNS**.
  * Seleccionar la opción **On** en *DNS Service*.
