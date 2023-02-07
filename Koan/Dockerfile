
FROM mitmproxy/mitmproxy:latest
COPY Scripts /Scripts
RUN apt update && \
    apt install nmap curl iptables iptables-persistent tcpdump dsniff netcat-traditional -y && \
    apt install proxychains tor obfs4proxy ettercap-text-only -y && \
    apt install postgresql-client -y && \
    apt install nano cron -y && \
    chmod -R +x /Scripts && \
    # printf "/Scripts/startup.sh" | tee -a /etc/profile 
    # /Scripts/iptables.sh
    # proxychains4-daemon
    printf "echo 'Building Proxy Network' \n \
            tor > /dev/tty & \nsleep 10\nss -nlt && \n \
            /Scripts/whatmyip.sh && \nsource torsocks on && \n \
            /Scripts/whatmyip.sh && \n echo ''" | tee -a /etc/bash.bashrc && \
    printf "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword ${TOR_CRED_HASH} \n \
            ControlPort 9051" | tee -a /etc/tor/torrc && \
    python3 -m pip install nyx
COPY Config/proxychains.conf /etc/proxychains.conf
# COPY Config/torrc.conf /etc/tor/torrc
# COPY Config/torsocks.conf /etc/tor/torsocks.conf
COPY Config/crontab /etc/crontab
# USER Boejaker

