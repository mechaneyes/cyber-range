---
title: Network Design for hackerlab
creation date: 2025.07.16—13:02:27 -04:00 — Wednesday
modification date: 2025.07.16—13:02:27 -04:00 — Wednesday
tags:
  - cyberRange
  - cybersecurity
  - infosec
  - homeLab
  - hardware
  - networking
aliases:
---

### Related

[Cyber Range Environment Design](Cyber%20Range%20Environment%20Design.md)

[Cyber Range Hardware](Cyber%20Range%20Hardware.md)

<br>

> [!NOTE]  
> This design was built assuming the Mikrotik hEX would serve as my main router. I also have the RB2011UiAS which will now handle that job, so the hEX will serve primarily as my firewall for now;

<br>

You want complete isolation for the vulnerable VMs to prevent any potential lateral movement or security issues.

Based on existing segmentation pattern, this is the approach:

<br>

# Network Design for Cyber Range / Cybersecurity Lab

**Create a new isolated network segment:**

- Lab network: `192.168.200.0/24` (or similar)
- Proxmox host: `192.168.200.1`
- Vulnerable VMs: `192.168.200.10-254`

<br>

## Pentesting VMs

For the penetration testing VMs, you have a few strategic options:

### Option 1: Same Proxmox Host, Different Network Segment

- **Proxmox host**: `192.168.200.1` (manages both networks)
- **Vulnerable VMs**: `192.168.200.10-254`
- **Pentest VMs**: `192.168.210.10-254` (new network segment)

### Option 2: Pentest VMs in Admin/Main Network

- **Vulnerable VMs**: `192.168.200.10-254` (isolated)
- **Pentest VMs**: `192.168.88.x` or `192.168.1.x` (your main networks)
- This simulates external attackers more realistically

### Option 3: Separate Physical Host

- **Lab Proxmox**: `192.168.200.1` (vulnerable VMs only)
- **Pentest Box**: `192.168.88.x` (separate machine for Kali, etc.)

<br><br>

# Network Layout 

## Complete Isolation Approach

### Lab Network (`192.168.200.0/24`):

- Proxmox host: `192.168.200.1`
- Vulnerable VMs: `192.168.200.10-254`
- Pentest VMs: `192.168.200.100-199` (or similar range)
- **Completely isolated** from production networks

### Physical Workflow:

1. **Plug into lab network** → Access Proxmox, manage VMs, run attacks
2. **Plug back into main network** → Normal internet, work, etc.


### [[⚜️ ghostrecon - firewall rules for complete isolation]]

<br>

These rules create **complete isolation** with the exact access you need:


<br><br>

## What This Configuration Does:

**✅ Production Network Access:**

- Your production network (`192.168.1.0/24`) can manage the router at `192.168.1.222`
- SSH, HTTP, HTTPS, Winbox, and ping access maintained

**✅ Lab Network Isolation:**

- Lab network (`192.168.200.0/24`) is completely blocked from ALL internal networks
- No access to production, NAS, or any other internal segments
- Cannot manage the router from lab network

**✅ Internet-Only Access for Lab:**

- Lab VMs get internet access for updates/downloads
- Blocked from all private IP ranges (RFC1918: 192.168.x.x, 172.16.x.x, 10.x.x.x)
- Perfect for downloading vulnerable apps, pentest tools, etc.

**✅ Security:**

- All blocked traffic is logged for monitoring
- Zero chance of lab contaminating production
- Physical network switching required for different environments

This setup gives you a true **air-gapped cyber range** that only touches the internet, while keeping your production network management intact. The lab is completely contained!