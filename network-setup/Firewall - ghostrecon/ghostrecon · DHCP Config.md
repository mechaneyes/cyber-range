---
title: Cyber Range DHCP Config
creation date: 2025.07.16—15:48:15 -04:00 — Wednesday
modification date: 2025.07.16—15:48:15 -04:00 — Wednesday
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
  - dhcp
aliases:
---

### Related

[⚜️ ghostrecon - firewall rules for complete isolation](⚜️%20ghostrecon%20-%20firewall%20rules%20for%20complete%20isolation.md)

[ghostrecon-firewall-rules-ip222-20250715.0.rsc](ghostrecon-firewall-rules-ip222-20250715.0.rsc.md)

<br><br>

## Check DHCP configuration:

```
/ip dhcp-server print
```

```
/ip dhcp-server network print
```

```
/ip pool print
```

<br><br>

# Setup DHCP server

The complete sequence would be:

1. **Create the pool:**

```
/ip pool add name=range-pool ranges=192.168.200.10-192.168.200.100
```

1. **Create the DHCP network:**

```
/ip dhcp-server network add address=192.168.200.0/24 gateway=192.168.200.1 dns-server=8.8.8.8,8.8.4.4
```

2. **Create the DHCP server:**

```
/ip dhcp-server add name=lab-dhcp interface=bridge address-pool=range-pool disabled=no
```

3. **Ensure bridge has the gateway IP:**

```
/ip address add address=192.168.200.1/24 interface=bridge
```


Now Proxmox should get an IP automatically when connected to the lab network!

<br><br>

# Check via `print`


```
/ip dhcp-server print
/ip dhcp-server network print
/ip pool print
```




![[Pasted image 20250716155714.png]]

<br><br>
## Current Status ✅

### DHCP Server:

- `defconf` server is running on `bridge` interface
- Using `default-dhcp` pool
- Status: **Enabled and running**

### DHCP Networks:

- `192.168.88.0/24` - existing network
- `192.168.100.0/24` - existing network
- **`192.168.200.0/24`** - **YOUR LAB NETWORK** ✅
    - Gateway: `192.168.200.1`
    - DNS: `8.8.8.8, 8.8.4.4`

### IP Pools:

- `default-dhcp`: `192.168.88.10-192.168.88.254`
- **`range-pool`**: **`192.168.200.10-192.168.200.100`** ✅

<br><br>

## To do now:

1. **Update the DHCP server to use your lab pool:**

```
/ip dhcp-server set defconf address-pool=range-pool
```

2. **Verify the bridge has the gateway IP:**   

```
/ip address print
```    

(Look for `192.168.200.1/24` on bridge interface)

Now when you connect Proxmox to the lab network, it should automatically get an IP between `192.168.200.10-192.168.200.100`!

Your lab network DHCP is basically ready to go. 🎯