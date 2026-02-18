---

# Nftables Strong DevSecOps

A robust **firewall configuration using nftables** for Linux environments focused on **security, DevOps, and virtualization**.  
This project provides a hardened ruleset to protect hosts, control VM communication, and log unauthorized access attempts.

---

## Features
- **Host protection** against unauthorized access.  
- Allow only **essential services**:
  - SSH (22)  
  - HTTP (80) / HTTPS (443)  
  - DNS (53 TCP/UDP)  
  - DHCP (67/68)  
  - ICMP (ping IPv4/IPv6)  
- **Controlled communication** between host ↔ VM via `virbr0` (SSH and ICMP).  
- **Logging** of denied attempts with prefix `NFTables-DROP`.  
- Default policies:
  - `DROP` → input & forward  
  - `ACCEPT` → output  

---

## Project Structure
```
NftablesStrongDevSecOps/
│── nftables.bash        # Firewall ruleset
│── LICENSE              # MIT License
└── README.md            # Documentation
```

---

## Installation
### Prerequisites
- Linux system with **nftables** available.

### Steps
1. Install nftables:
   ```bash
   sudo apt install nftables   # Debian/Ubuntu
   sudo dnf install nftables   # Fedora/RHEL
   ```
2. Copy ruleset to configuration:
   ```bash
   sudo nano /etc/nftables.conf
   ```
   *(Paste the contents of `nftables.bash`)*  
3. Restart and enable service:
   ```bash
   sudo systemctl restart nftables
   sudo systemctl enable nftables
   ```

---

## Testing
- List active rules:
  ```bash
  sudo nft list ruleset
  ```
- Test SSH access:
  ```bash
  ssh user@host
  ```
- Test ping:
  ```bash
  ping 8.8.8.8
  ```

---

## 📜 Logs
Blocked attempts are recorded in **syslog**:
```bash
journalctl -k | grep NFTables-DROP
```

---

## Purpose
The goal of this project is to:
- Provide a **secure baseline firewall** for Linux hosts.  
- Support **DevSecOps practices** with controlled VM networking.  
- Enable **auditing and monitoring** of denied traffic.  

---

## License
This project is licensed under the **MIT License**.  
See the `LICENSE` file for details.  

---

## Author
Developed by **Gabriel Santana**  
Contact: GabrielSantana1996sp on GitHub (github.com) 
---
