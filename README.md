# NftablesStrongDevSecOps 

Configuração de firewall usando **nftables** para ambientes Linux focados em segurança, DevOps e virtualização.

##  Objetivo
Este projeto fornece um conjunto de regras de firewall robustas para:
- Proteger o host contra acessos não autorizados.  
- Permitir apenas serviços essenciais (SSH, HTTP/HTTPS, DNS, DHCP, ICMP).  
- Garantir comunicação controlada entre **máquina virtual (virbr0)** e o host.  
- Registrar tentativas de acesso negadas para auditoria.  

##  Estrutura
Arquivo principal:
- `/etc/nftables.conf`

Principais cadeias:
- **input** → controla tráfego de entrada.  
- **forward** → controla tráfego roteado (ex.: VM ↔ host).  
- **output** → controla tráfego de saída (default: accept).  

##  Regras implementadas
- **Loopback**: aceita todo tráfego interno (`lo`).  
- **Conexões estabelecidas**: mantém sessões já abertas.  
- **SSH**: porta 22 liberada.  
- **Web**: portas 80 (HTTP) e 443 (HTTPS) liberadas.  
- **DNS**: portas 53 TCP/UDP liberadas.  
- **DHCP**: portas 67/68 liberadas para atribuição de IP.  
- **ICMP**: ping IPv4 e IPv6 permitidos.  
- **VM ↔ Host**: tráfego via `virbr0` (SSH e ICMP).  
- **Log**: tentativas bloqueadas são registradas com prefixo `NFTables-DROP`.  

##  Instalação
1. Instale o `nftables`:
   ```bash
   sudo apt install nftables   # Debian/Ubuntu
   sudo dnf install nftables   # Fedora/RHEL
   ```
2. Copie o arquivo para `/etc/nftables.conf`:
   ```bash
   sudo nano /etc/nftables.conf
   ```
   (cole o conteúdo do arquivo)  

3. Reinicie o serviço:
   ```bash
   sudo systemctl restart nftables 
   sudo systemctl enable nftables
   ```

##  Testes
Verificar regras ativas:
```bash
sudo nft list ruleset
```

Testar acesso SSH:
```bash
ssh user@host
```

Testar ping:
```bash
ping 8.8.8.8
```

##  Logs
Tentativas bloqueadas são registradas no syslog:
```bash
journalctl -k | grep NFTables-DROP
```

##  Observações
- Política padrão: **DROP** para `input` e `forward`.  
- Política padrão: **ACCEPT** para `output`.  
- Ajuste portas conforme necessidade do seu ambiente.  

---

Autor: **Gabriel Santana**  
Projeto: **NftablesStrongDevSecOps**
```
