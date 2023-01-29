
FROM mitmproxy/mitmproxy:latest
# RUN export http_proxy="http://localhost:8080/" &&\
RUN apt update && \
    apt install nmap curl iptables iptables-persistent -y
    # iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080 && \
    # iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080 && \
    # iptables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 47162 -j REDIRECT --to-port 8080 && \
    # ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080 && \
    # ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
    # ip6tables-legacy -t nat -A PREROUTING -i eth0 -p tcp --dport 47162 -j REDIRECT --to-port 8080 && \
    # iptables-save > /etc/iptables/rules.v4 && \
    # ip6tables-save > /etc/iptables/rules.v6
# EXPOSE 8080
USER root
CMD /bin/bash