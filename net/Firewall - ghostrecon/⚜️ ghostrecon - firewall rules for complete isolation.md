---
title: ⚜️ ghostrecon - firewall rules for complete isolation
creation date: 2025.07.16—14:25:24 -04:00 — Wednesday
modification date: 2025.07.18—09:19:45 -04:00 — Friday
tags:
  - cyberRange
  - cybersecurity
  - infosec
  - homeLab
  - hardware
  - networking
  - security
  - firewall
aliases:
---

### Related

[ghostrecon-firewall-rules-ip222-20250715.0.rsc](ghostrecon-firewall-rules-ip222-20250715.0.rsc.md)

[ghostrecon · DHCP Config](ghostrecon%20·%20DHCP%20Config.md)







The rules below create **complete isolation** with access as specified:

## Features
### ✅ Production Network Access:

- Production network (`192.168.1.0/24`) can manage the router at `192.168.1.222`
- SSH, HTTP, HTTPS, Winbox, and ping access maintained

### ✅ Lab Network Isolation:

- Lab network (`192.168.200.0/24`) is completely blocked from ALL internal networks
- No access to production, NAS, or any other internal segments
- Cannot manage the router from lab network

### ✅ Internet-Only Access for Lab:

- Lab VMs get internet access for updates/downloads
- Blocked from all private IP ranges (RFC1918: 192.168.x.x, 172.16.x.x, 10.x.x.x)
- Perfect for downloading vulnerable apps, pentest tools, etc.

### ✅ Security:

- All blocked traffic is logged for monitoring
- Zero chance of lab contaminating production
- Physical network switching required for different environments

This setup provides a true **air-gapped cyber range** that only touches the internet, while keeping the production network management intact. The lab is completely contained!





## Temporary access rule

Configuring access while setting up the range. This will be disabled after configured and before the party really starts.

### Add SSH access through Winbox GUI:

#### Step 1: Navigate to Firewall

- Open Winbox, connect to 192.168.1.222
- Click **IP** in the left menu
- Click **Firewall** in the submenu

#### Step 2: Open Filter Rules

- Click **Filter Rules** tab
- You'll see your current firewall rules listed

#### Step 3: Add New Rule

- Click the **+** (plus) button to add a new rule
- This opens the "New Firewall Rule" dialog

#### Step 4: Configure the Rule

- **General Tab:**
    - Chain: `forward`
    - Action: `accept`
    - Comment: `TEMP: Allow prod SSH to lab for Proxmox setup`
- **Src. Address Tab:**
    - Src. Address: `192.168.1.0/24`
- **Dst. Address Tab:**
    - Dst. Address: `192.168.200.0/24`
- **Protocol Tab:**
    - Protocol: `tcp`
    - Dst. Port: `22`

#### Step 5: Position the Rule

- Click **OK** to create the rule
- In the rules list, **drag the new rule to the TOP** (very important!)
- Or select it and use the **up arrow** to move it to position 0

#### Step 6: Test

- Try SSH from prod network: `ssh user@192.168.200.x`

#### To disable later:

- Right-click the rule → **Disable**
- Or double-click rule → check **Disabled** box







# Code
### On Killing Machine

```
'/Users/mechaneyes/Documents/ Projects/Security/cyber-range/ghostrecon - mikrotik/ghostrecon-firewall-rules-20250716.1 - completed context.rsc'
```

### RSC File

![[ghostrecon-firewall-rules-20250716.1 - completed context.rsc]]

### RSC

```
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
```




## Voices
#### by [John Talabot](https://perm-vac.bandcamp.com/)

https://perm-vac.bandcamp.com/album/voices


### As reminded by Bonobo

https://www.nts.live/shows/bonobo/episodes/bonobo-16th-december-2016

![[Pasted image 20250716150416.png]]


