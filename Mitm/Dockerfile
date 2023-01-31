
FROM mitmproxy/mitmproxy:latest
COPY iptables.sh /Scripts/iptables.sh
COPY startup.sh /etc/init.d/startup.sh
RUN export http_proxy=${mitm_http_proxy} &&\
    apt update && \
    apt install nmap curl iptables iptables-persistent tcpdump -y && \
    apt install proxychains4 tor && \
    chmod -R +x /Scripts 
    # /Scripts/iptables.sh
    # proxychains4-daemon
# EXPOSE 8083
USER root
CMD ["/bin/bash","tcpdump"]
