# 2025-09-30 22:53:16 by RouterOS 7.19.4
# system id = QHwYOgLfvpA
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-WAN
set [ find default-name=ether2 ] disable-running-check=no name=ether2-R2
set [ find default-name=ether3 ] disable-running-check=no name=ether3-R4
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
/interface eoip
add allow-fast-path=no mac-address=02:7A:6F:D8:07:FE name=eoip-tunnel \
    remote-address=10.200.0.2 tunnel-id=100
/ip pool
add name=pool-l2tp ranges=10.50.50.2-10.50.50.50
/port
set 0 name=serial0
/ppp profile
add local-address=10.50.50.1 name=prof-l2tp remote-address=pool-l2tp \
    use-encryption=yes
/routing ospf instance
add disabled=no name=ospf originate-default=always
/routing ospf area
add disabled=no instance=ospf name=backbone
/interface l2tp-server server
set authentication=mschap1,mschap2 enabled=yes use-ipsec=yes
/ip address
add address=192.0.0.1 interface=lo network=192.0.0.1
add address=10.99.0.1/30 interface=ether2-R2 network=10.99.0.0
add address=10.200.0.1/30 interface=ether3-R4 network=10.200.0.0
add address=10.50.50.1/30 interface=eoip-tunnel network=10.50.50.0
/ip dhcp-client
add interface=ether1-WAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-WAN
/ppp secret
add name=route4 profile=prof-l2tp
/routing ospf interface-template
add area=backbone disabled=no interfaces=lo
add area=backbone disabled=no interfaces=ether2-R2
add area=backbone disabled=yes interfaces=ether3-R4
add area=backbone disabled=no interfaces=eoip-tunnel
/system identity
set name=R1
/tool romon
set enabled=yes
