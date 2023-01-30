#Transparent mode
iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080 && \
iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080 && \
iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 47162 -j REDIRECT --to-port 8080 && \
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080 && \
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080 && \
# ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 47162 -j REDIRECT --to-port 8080 && \
