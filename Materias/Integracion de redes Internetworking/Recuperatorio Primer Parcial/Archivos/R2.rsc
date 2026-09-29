# 2025-09-30 22:53:42 by RouterOS 7.19.4
# system id = n+X8kelQ61I
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-R1
set [ find default-name=ether2 ] disable-running-check=no name=ether2-R3
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
/port
set 0 name=serial0
/routing ospf instance
add disabled=no name=ospf
/routing ospf area
add disabled=no instance=ospf name=backbone
/ip address
add address=192.0.0.2 interface=lo network=192.0.0.2
add address=10.99.0.2/30 interface=ether1-R1 network=10.99.0.0
add address=10.99.1.1/30 interface=ether2-R3 network=10.99.1.0
/ip dhcp-client
add interface=ether1-R1
/routing ospf interface-template
add area=backbone disabled=no interfaces=lo
add area=backbone disabled=no interfaces=ether1-R1
add area=backbone disabled=no interfaces=ether2-R3
/system identity
set name=R2
/tool romon
set enabled=yes
