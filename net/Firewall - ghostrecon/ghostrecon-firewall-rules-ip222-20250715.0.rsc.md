---
title: ghostrecon-firewall-rules-ip222-20250715.0.rsc
creation date: 2025.07.15—16:25:44 -04:00 — Tuesday
modification date: 2025.07.15—16:25:44 -04:00 — Tuesday
tags:
  - cyberRange
  - cybersecurity
  - infosec
  - homeLab
  - hardware
  - networking
  - security
  - firewall
  - mikrotik
  - routerOS
  - rsc
aliases:
---
### Related

[⚜️ ghostrecon - firewall rules for complete isolation](⚜️%20ghostrecon%20-%20firewall%20rules%20for%20complete%20isolation.md)

[ghostrecon · DHCP Config](ghostrecon%20·%20DHCP%20Config.md)





```rsc
# jul/15/2025 15:51:29 by RouterOS 6.49.19
# software id = FCMT-79YR
#
# model = RB750UPr2
# serial number = HG909PWP9CR
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment="defconf: accept to local loopback" \
    dst-address=127.0.0.1
add action=accept chain=input comment="Allow main network SSH to router" \
    dst-port=22 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input comment="Allow main network HTTP to router" \
    dst-port=80 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input comment="Allow main network HTTPS to router" \
    dst-port=443 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input comment="Allow main network Winbox to router" \
    dst-port=8291 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input comment="Allow main network Telnet to router" \
    dst-port=23 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input comment="Allow main network ping to router" \
    protocol=icmp src-address=192.168.1.0/24
add action=drop chain=input comment="Block NAS from router services" \
    dst-port=22,23,80,443,8291 log=yes protocol=tcp src-address=\
    192.168.100.0/24
add action=drop chain=input comment="Block NAS ICMP to router" log=yes \
    protocol=icmp src-address=192.168.100.0/24
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related
add action=drop chain=forward comment="Block NAS to existing network" \
    dst-address=192.168.1.0/24 log=yes src-address=192.168.100.0/24
add action=drop chain=forward comment="Block NAS to main network" \
    dst-address=192.168.88.0/24 log=yes src-address=192.168.100.0/24
add action=drop chain=forward comment="Block NAS to existing router" \
    dst-address=192.168.1.1 log=yes src-address=192.168.100.0/24
add action=drop chain=forward comment="Block NAS to main router" dst-address=\
    192.168.88.1 log=yes src-address=192.168.100.0/24
add action=accept chain=forward comment="Allow admin SSH to NAS" dst-address=\
    192.168.100.0/24 dst-port=22 protocol=tcp src-address=192.168.88.254
add action=accept chain=forward comment="Allow admin HTTP to NAS" \
    dst-address=192.168.100.0/24 dst-port=80 protocol=tcp src-address=\
    192.168.88.254
add action=accept chain=forward comment="Allow admin HTTPS to NAS" \
    dst-address=192.168.100.0/24 dst-port=443 protocol=tcp src-address=\
    192.168.88.254
add action=accept chain=forward comment="Allow admin SMB to NAS" dst-address=\
    192.168.100.0/24 dst-port=445 protocol=tcp src-address=192.168.88.254
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment="Block all other NAS traffic" \
    src-address=192.168.100.0/24
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
```