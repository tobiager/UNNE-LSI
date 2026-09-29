

|Prueba|Condición / Procedimiento|CODE obtenido (TYPE = 3)|Router / Host emisor|Comando Cisco IOS / Causa|
|-|-|-|-|-|
|1|Ruta hacia 172.16.3.0/24 eliminada en R3. Ping desde PC-A a Server D.|CODE 0 (Net Unreachable)|R3|no ip route 172.16.3.0 ... en R3. La tabla de ruteo carece de destino hacia la red.|
|2|SERVER D apagado físicamente. Ping desde PC-A a Server D.|CODE 1 (Host Unreachable)|R4|Servidor apagado. R4 tiene ruta local pero la consulta ARP expira sin respuesta del host físico.|
|3|SERVER D encendido con servicio TFTP en Off. Copia de configuración desde R4.|CODE 3 (Port Unreachable)|SERVER D|copy running-config tftp:. El servidor recibe el datagrama UDP en el puerto 69 pero no hay ningún proceso escuchando ese puerto.|



