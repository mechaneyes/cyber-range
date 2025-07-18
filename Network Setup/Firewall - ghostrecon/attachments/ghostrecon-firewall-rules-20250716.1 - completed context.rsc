# Cyber Range Firewall Rules - Complete Lab Isolation

# ===== LAB NETWORK COMPLETE ISOLATION =====
# Block lab network from ALL internal networks (production isolation)
/ip firewall filter add action=drop chain=forward comment="Block lab from all internal networks" \
    dst-address=192.168.0.0/16 log=yes src-address=192.168.200.0/24

# Block lab network from accessing router management
/ip firewall filter add action=drop chain=input comment="Block lab from router SSH" \
    dst-port=22 log=yes protocol=tcp src-address=192.168.200.0/24
/ip firewall filter add action=drop chain=input comment="Block lab from router HTTP" \
    dst-port=80 log=yes protocol=tcp src-address=192.168.200.0/24
/ip firewall filter add action=drop chain=input comment="Block lab from router HTTPS" \
    dst-port=443 log=yes protocol=tcp src-address=192.168.200.0/24
/ip firewall filter add action=drop chain=input comment="Block lab from router Winbox" \
    dst-port=8291 log=yes protocol=tcp src-address=192.168.200.0/24
/ip firewall filter add action=drop chain=input comment="Block lab from router Telnet" \
    dst-port=23 log=yes protocol=tcp src-address=192.168.200.0/24
/ip firewall filter add action=drop chain=input comment="Block lab ICMP to router" \
    log=yes protocol=icmp src-address=192.168.200.0/24

# ===== PRODUCTION NETWORK ACCESS TO ROUTER =====
# Allow production network to manage router at 192.168.1.222
/ip firewall filter add action=accept chain=input comment="Allow production SSH to router" \
    dst-address=192.168.1.222 dst-port=22 protocol=tcp src-address=192.168.1.0/24
/ip firewall filter add action=accept chain=input comment="Allow production HTTP to router" \
    dst-address=192.168.1.222 dst-port=80 protocol=tcp src-address=192.168.1.0/24
/ip firewall filter add action=accept chain=input comment="Allow production HTTPS to router" \
    dst-address=192.168.1.222 dst-port=443 protocol=tcp src-address=192.168.1.0/24
/ip firewall filter add action=accept chain=input comment="Allow production Winbox to router" \
    dst-address=192.168.1.222 dst-port=8291 protocol=tcp src-address=192.168.1.0/24
/ip firewall filter add action=accept chain=input comment="Allow production ping to router" \
    dst-address=192.168.1.222 protocol=icmp src-address=192.168.1.0/24

# ===== LAB INTERNET ACCESS ONLY =====
# Allow lab network internet access but NOT to any RFC1918 addresses
/ip firewall filter add action=accept chain=forward comment="Allow lab internet access" \
    dst-address=!192.168.0.0/16,!172.16.0.0/12,!10.0.0.0/8 src-address=192.168.200.0/24

# ===== FINAL BLOCK =====
# Block all other lab traffic (catch-all)
/ip firewall filter add action=drop chain=forward comment="Block all other lab traffic" \
    log=yes src-address=192.168.200.0/24