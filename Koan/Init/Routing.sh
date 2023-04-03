#!/bin/bash

WANIF='eth1'
LANIF='eth0'

update-alternatives --remove iptables /usr/sbin/iptables-nft

# enable ip forwarding in the kernel
echo 'Enabling Kernel IP forwarding...'
/bin/echo 1 > /proc/sys/net/ipv4/ip_forward

# flush rules and delete chains
echo 'Flushing rules and deleting existing chains...'
iptables -F
iptables -X

# enable ettercap
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -I POSTROUTING -s 173.16.0.0/24 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 172.16.0.0/24 -j MASQUERADE

# enable masquerading to allow LAN internet access
echo 'Enabling IP Masquerading and other rules...'
iptables -t nat -A POSTROUTING -o $LANIF -j MASQUERADE
iptables -A FORWARD -i $LANIF -o $WANIF -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $WANIF -o $LANIF -j ACCEPT

iptables -t nat -A POSTROUTING -o $WANIF -j MASQUERADE
iptables -A FORWARD -i $WANIF -o $LANIF -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $LANIF -o $WANIF -j ACCEPT

# MITM Transparent mode
iptables -t nat -A PREROUTING -i $LANIF -p tcp --dport 80 -j REDIRECT --to-port 8080 
iptables -t nat -A PREROUTING -i $LANIF -p tcp --dport 443 -j REDIRECT --to-port 8080 
iptables -t nat -A PREROUTING -i $LANIF -p tcp --dport 47162 -j REDIRECT --to-port 8080
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080 
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 47162 -j REDIRECT --to-port 8080
# /sbin/iptables-save > /etc/iptables-legacy/rules.v4

## Flush all existing iptables rules
# iptables -F

# Block incoming Nmap scan packets
iptables -A INPUT -p tcp --tcp-flags ALL Nmap -j DROP

# # Allow all incoming traffic from established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# # Allow all incoming traffic from the loopback interface
iptables -A INPUT -i lo -j ACCEPT

# # Drop all incoming traffic that does not match any of the above rules
iptables -A INPUT -j DROP

## TOR Forwarding Rules
# # ignored location
# IGN="192.168.1.0/24 192.168.0.0/24"
# # Enter your tor UID
# UID="XXX"
# # Tor's Port. default is 9050 but if you changed it in torrc change next line
# PORT="9050"

# # iptables -F
# # iptables -t nat -F
# iptables -t nat -A OUTPUT -m owner --uid-owner $UID -j RETURN
# # Change if you select another port for Tor DNS in torrc. I select 9053. Also DNS default  port is 53
# iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 9053
# for NET in $IGN 127.0.0.0/9 127.128.0.0/10; do
#  iptables -t nat -A OUTPUT -d $NET -j RETURN
# done
# iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $PORT
# iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# for NET in $IGN 127.0.0.0/8; do
#  iptables -A OUTPUT -d $NET -j ACCEPT
# done
# iptables -A OUTPUT -m owner --uid-owner $UID -j ACCEPT
# iptables -A OUTPUT -j REJECT

echo 'IP table config done.'