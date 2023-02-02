
FROM mitmproxy/mitmproxy:latest
COPY iptables.sh /Scripts/iptables.sh
COPY startup.sh /Scripts/startup.sh

RUN apt update && \
    apt install nmap curl iptables iptables-persistent tcpdump ettercap-text-only arpspoof -y && \
    apt install proxychains4 tor -y && \
    chmod -R +x /Scripts && \
    printf "/Scripts/startup.sh" | tee -a /etc/profile 
    # /Scripts/iptables.sh
    # proxychains4-daemon
COPY proxychains4.conf /etc/proxychains4.conf
# EXPOSE 8083
USER root

