# 2025-09-30 22:54:33 by RouterOS 7.19.4
# system id = X4vN+iv3hkB
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-R1
set [ find default-name=ether2 ] disable-running-check=no name=ether2-R5
set [ find default-name=ether3 ] disable-running-check=no name=ether3-LAN
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
/interface l2tp-client
add add-default-route=yes connect-to=10.200.0.1 disabled=no name=l2tp-client \
    use-ipsec=yes user=router4
/interface eoip
add allow-fast-path=no mac-address=02:16:F8:4A:1D:AE name=eoip-tunnel \
    remote-address=10.200.0.1 tunnel-id=100
/ip pool
add name=dhcp_pool0 ranges=172.16.0.10-172.16.0.50
add name=pool-l2tp ranges=10.50.50.2-10.50.50.50
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3-LAN name=dhcp1
/port
set 0 name=serial0
/routing ospf instance
add disabled=no name=ospf
/routing ospf area
add disabled=no instance=ospf name=backbone
/interface l2tp-server server
set authentication=mschap1,mschap2 use-ipsec=yes
/ip address
add address=192.0.0.4 interface=lo network=192.0.0.4
add address=10.200.0.2/30 interface=ether1-R1 network=10.200.0.0
add address=10.99.2.1/30 interface=ether2-R5 network=10.99.2.0
add address=172.16.0.1/24 interface=ether3-LAN network=172.16.0.0
add address=10.50.50.2/30 interface=eoip-tunnel network=10.50.50.0
/ip dhcp-client
add interface=ether1-R1
/ip dhcp-server network
add address=172.16.0.0/24 gateway=172.16.0.1
/ppp secret
add local-address=10.50.50.1 name=router4 profile=default-encryption \
    remote-address=10.50.50.2
/routing ospf interface-template
add area=backbone disabled=no interfaces=lo
add area=backbone disabled=yes interfaces=ether1-R1
add area=backbone disabled=no interfaces=ether2-R5
add area=backbone disabled=no interfaces=ether3-LAN
add area=backbone disabled=no interfaces=eoip-tunnel
/system identity
set name=R4
/tool romon
set enabled=yes
