# 2025-09-30 22:55:23 by RouterOS 7.19.4
# system id = 3w1MZFuSYKH
#
/interface bridge
add name=br-LAN
add name=lo1
add name=lo2
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-R5
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
/ip pool
add name=dhcp_pool0 ranges=172.16.50.10-172.16.50.50
/ip dhcp-server
add address-pool=dhcp_pool0 interface=br-LAN name=dhcp1
/port
set 0 name=serial0
/routing ospf instance
add disabled=no name=ospf
/routing ospf area
add area-id=0.0.0.50 disabled=no instance=ospf name=area50
/interface bridge port
add bridge=br-LAN interface=ether3
add bridge=br-LAN interface=ether4
/ip address
add address=192.0.0.6 interface=lo network=192.0.0.6
add address=172.255.1.2/30 interface=ether1-R5 network=172.255.1.0
add address=172.16.50.1/24 interface=br-LAN network=172.16.50.0
add address=190.50.50.1/29 interface=lo1 network=190.50.50.0
add address=5.99.99.1/29 interface=lo2 network=5.99.99.0
/ip dhcp-client
add interface=ether1-R5
/ip dhcp-server network
add address=172.16.50.0/24 gateway=172.16.50.1
/routing ospf interface-template
add area=area50 disabled=no interfaces=lo type=ptp
add area=area50 disabled=no interfaces=br-LAN passive type=ptp
add area=area50 disabled=no interfaces=ether1-R5 type=ptp
add area=area50 disabled=no interfaces=lo1 type=ptp
add area=area50 disabled=no interfaces=lo2 type=ptp
/system identity
set name=R6
/tool romon
set enabled=yes
