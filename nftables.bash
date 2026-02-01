#bash
sudo nano /etc/nftables.conf

# NftablesStrongDevSecOps
table inet filter {
    chain input {
        type filter hook input priority filter; policy drop;

        # loopback
        iif "lo" accept

        # conexões já estabelecidas
        ct state established,related accept

        # SSH
        tcp dport 22 ct state new accept

        # HTTP/HTTPS (WEB)
        tcp dport {80,443} ct state new accept

        # DNS
        udp dport 53 ct state new accept
        tcp dport 53 ct state new accept

        # DHCP
        udp sport 67 udp dport 68 accept        
        udp sport 68 udp dport 67 accept

        # ICMP
        ip protocol icmp accept
        ip6 nexthdr icmpv6 accept

        # Permitir tráfego da VM para o host (exemplo: SSH e ping)
        iifname "virbr0" tcp dport 22 accept
        iifname "virbr0" ip protocol icmp accept

        # LOGAR
        limit rate 5/minute burst 5 packets log prefix "NFTables-DROP: " level info
    }

    chain forward {
        type filter hook forward priority filter; policy drop;

        # Permitir tráfego iniciado pela VM e suas respostas
        ct state established,related accept

        # Permitir que a VM acesse web e DNS
        iifname "virbr0" tcp dport {80,443} accept
        iifname "virbr0" udp dport 53 accept
        iifname "virbr0" tcp dport 53 accept
    }

    chain output {
        type filter hook output priority filter; policy accept;
    }
}

sudo systemctl restart nftables
