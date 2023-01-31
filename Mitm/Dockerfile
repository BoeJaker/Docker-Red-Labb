
FROM mitmproxy/mitmproxy:latest
COPY iptables.sh /Scripts/iptables.sh
COPY startup.sh /etc/init.d/startup.sh
RUN ln -s /etc/init.d/startup.sh /etc/rc.d/ && \
    export http_proxy=${mitm_http_proxy} && \
    apt update && \
    apt install nmap curl iptables iptables-persistent tcpdump -y && \
    apt install proxychains4 tor -y && \
    chmod -R +x /Scripts 
    # /Scripts/iptables.sh
    # proxychains4-daemon
# EXPOSE 8083
USER root

