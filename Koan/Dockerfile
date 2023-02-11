
FROM mitmproxy/mitmproxy:latest

COPY Scripts /Scripts

RUN apt update && \
    apt install nmap curl iptables iptables-persistent iproute2 tcpdump dsniff netcat-traditional traceroute -y && \
    apt install proxychains tor obfs4proxy ettercap-text-only -y && \
    apt install postgresql-client libxml2-utils -y && \
    apt install nano cron -y && \
    ## Gives scripts execute permission
    chmod -R +x /Scripts && \
    ## Fixes windows encoding 
    sed -i -e 's/\r$//' /Scripts/*.sh && \
    # printf "/Scripts/startup.sh" | tee -a /etc/profile 
    # /Scripts/iptables.sh
    # proxychains4-daemon
    # cat /Config/bash.conf | tee -a /etc/bash.bashrc && \ 
    # cat /Config/torrc.conf | | tee -a /etc/tor/torrc && \
    printf "echo 'Checking docker network integrity' ; \
            /Scripts/Routing.sh ; \
            /Scripts/post-compose-check.sh" | tee -a /etc/bash.bashrc && \ 
    python3 -m pip install nyx

COPY Config/proxychains.conf /etc/proxychains.conf
COPY Config/crontab /etc/crontab


