---
title: Cyber Range Environment Config
creation date: 2025.07.17—08:36:56 -04:00 — Thursday
modification date: 2025.07.17—08:36:56 -04:00 — Thursday
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

[Cyber Range Network Design](Cyber%20Range%20Network%20Design.md)

[Cyber Range Hardware](Cyber%20Range%20Hardware.md)

<br><br>

# Cyber Range Design:

## ThinkCentre #1 (Attacker Box):

- i5-9400T, 16GB RAM - Perfect for running Kali + Parrot VMs
- 256GB might be tight with two full VMs. Consider:
    - External USB 3.0/USB-C SSD for VM storage
    - Or prioritize one distro (Kali is more comprehensive)
<br>

## ThinkCentre #2 (Victim Network):

- i5-8400T, 8GB RAM - This will be your bottleneck
- 8GB RAM severely limits how many Windows VMs you can run simultaneously
- Windows 10/11 VMs need 4-8GB each
- **Critical:** Upgrade this to at least 16GB, ideally 32GB
<br>

## Sentinel (Monitoring):

- Raspberry Pi 4 
<br>

## Defensive Tools

- Security Onion on Dell OptiPlex
<br><br>

# To Do

1. **Immediate:** Upgrade ThinkCentre #2 RAM to 16GB minimum
2. **Storage:** Add external SSDs for VM storage on both ThinkCentres
3. **VM Allocation:** With 8GB current RAM, you can maybe run one Windows VM at a time
<br><br>

# Prod Security Onion

## Security Onion on NUC (Production):

- i5-8259U with 16GB RAM and 1TB SSD is adequate for standalone deployment
- The 1TB storage is excellent for log retention
- 32GB RAM allows for better performance with larger log volumes

<br><br>

# Soundtrack

## Shit Robot - Warm Up for LCD Soundsystem @ Brooklyn Steel - Saturday December 11th

https://soundcloud.com/dfa-records/shit-robot-warm-up-for-lcd-soundsystem-brooklyn-steel-saturday-december-11th

![](Pasted%20image%2020250718093959.png)


