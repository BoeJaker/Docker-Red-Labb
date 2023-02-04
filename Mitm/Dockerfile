
FROM mitmproxy/mitmproxy:latest
COPY Scripts /Scripts
RUN apt update && \
    apt install nmap curl iptables iptables-persistent tcpdump ettercap-text-only dsniff -y && \
    apt install proxychains tor -y && \
    chmod -R +x /Scripts
    # printf "/Scripts/startup.sh" | tee -a /etc/profile 
    # /Scripts/iptables.sh
    # proxychains4-daemon
COPY Config/proxychains.conf /etc/proxychains.conf
# COPY Config/torrc.conf /etc/tor/torrc
# EXPOSE 8083
USER root

