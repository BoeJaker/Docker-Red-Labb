FROM ubuntu:kinetic
# Copy in our tools
COPY Scripts /Scripts
RUN apt update && \ 
    # Install packages
    apt install -y git python3 python3-pip tor obfs4proxy proxychains -y && \
    apt install iproute2 curl netcat systemctl nmap -y && \
    apt install -y nano cron -y && \
    # Set file permissions 
    chmod -R +x /Scripts && \
    printf "SocksPort 0.0.0.0:9050 \n \
            ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword 16:30CFA39CDFB93D1F6060DF7954611B8952C3774F46C092E11B7359A304\n \
            ControlPort 9051" | tee -a /etc/torrc && \
    printf "echo 'Building Proxy Network' \n \
            tor > /dev/tty & \nsleep 10\nss -nlt && \n \
            /Scripts/whatmyip.sh && \nsource torsocks on && \n \
            /Scripts/whatmyip.sh && \n echo ''" | tee -a /etc/bash.bashrc && \
    printf "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword ${TOR_CRED_HASH} \n \
            ControlPort 9051" | tee -a /etc/tor/torrc && \
    # Install python packages
    python3 -m pip install nyx

# Upload config files
COPY Config/proxychains.conf /etc/proxychains.conf
COPY Config/torrc.conf /etc/tor/torrc
# COPY Config/torsocks.conf /etc/tor/torsocks.conf
COPY Config/crontab /etc/crontab

# Setup Connections & Shell
# EXPOSE 9050
USER root
CMD /usr/bin/bash

