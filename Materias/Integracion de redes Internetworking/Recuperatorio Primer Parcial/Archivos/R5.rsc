# 2025-09-30 22:54:56 by RouterOS 7.19.4
# system id = SSeLqW46v0J
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-R4
set [ find default-name=ether2 ] disable-running-check=no name=ether2-R3
set [ find default-name=ether3 ] disable-running-check=no name=ether3-R6
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
/port
set 0 name=serial0
/routing ospf instance
add disabled=no name=ospf
/routing ospf area
add disabled=no instance=ospf name=backbone
add area-id=0.0.0.50 disabled=no instance=ospf name=area50
/ip address
add address=192.0.0.5 interface=lo network=192.0.0.5
add address=10.99.3.2/30 interface=ether2-R3 network=10.99.3.0
add address=10.99.2.2/30 interface=ether1-R4 network=10.99.2.0
add address=172.255.1.1/30 interface=ether3-R6 network=172.255.1.0
/ip dhcp-client
add interface=ether1-R4
/routing ospf interface-template
add area=backbone disabled=no interfaces=lo
add area=backbone cost=10 disabled=no interfaces=ether1-R4
add area=backbone disabled=no interfaces=ether2-R3
add area=area50 disabled=no interfaces=lo type=ptp
add area=area50 disabled=no interfaces=ether3-R6 type=ptp
/system identity
set name=R5
/tool romon
set enabled=yes
