
FROM mitmproxy/mitmproxy:latest

COPY Scripts /Scripts

RUN apt update && \
    apt install nmap curl iptables iptables-persistent iproute2 tcpdump dsniff netcat-traditional -y && \
    apt install proxychains tor obfs4proxy ettercap-text-only -y && \
    apt install postgresql-client libxml2-utils -y && \
    apt install nano cron -y && \
    chmod -R +x /Scripts && \
    # printf "/Scripts/startup.sh" | tee -a /etc/profile 
    # /Scripts/iptables.sh
    # proxychains4-daemon
    # cat /Config/bash.conf | tee -a /etc/bash.bashrc && \ 
    # cat /Config/torrc.conf | | tee -a /etc/tor/torrc && \
    printf "echo 'Checking docker network integrity' ; \
            /Scripts/post-compose-check.sh ; \
            /Scripts/whatmyip.sh && \n source torsocks on && \n \
            /Scripts/whatmyip.sh && \n echo ''" | tee -a /etc/bash.bashrc && \ 
    printf "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword ${TOR_CRED_HASH} \n \
            ControlPort 9051" | tee -a /etc/tor/torrc && \
    python3 -m pip install nyx

COPY Config/proxychains.conf /etc/proxychains.conf
COPY Config/crontab /etc/crontab


