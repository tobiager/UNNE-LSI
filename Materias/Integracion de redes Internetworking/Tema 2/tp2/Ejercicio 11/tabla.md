

|Parámetro Solicitado|Valor Obtenido en Simulación|Descripción|
|-|:-:|-|
|Router de descarte|R4|Es el router donde el TTL del datagrama llega a 0 en el salto 128.|
|Saltos totales|128|Cada router decrementa en 1 unidad el TTL inicial (128 de Windows).|
|Vueltas completas al anillo|32|$128 / 4 = 32|
|ICMP TYPE|11 (0x0b)|Mensaje Time Exceeded.|
|ICMP CODE|0 (0x00)|Time to Live exceeded in transit.|
|Host destino del error|172.16.1.10 (PC-A)|R4 envía el ICMP de vuelta a la IP de origen que inició el ping.|



