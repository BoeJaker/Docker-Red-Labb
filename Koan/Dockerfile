FROM ubuntu:latest
# Copy in our tools
COPY Scripts /Scripts
# RUN export http_proxy="http://173.16.0.2:8080/" && \
RUN apt update && \ 
    # apt upgrade -y && \
    # Install packages
    apt install -y git python3 python3-pip tor obfs4proxy proxychains4 -y && \
    apt install iproute2 curl netcat systemctl nmap -y && \
    apt install -y nano cron -y && \
    rm -r /var/cache/apt/* && \
    # Clone git repos
    git clone https://github.com/opsdisk/pagodo.git /pagodo && \
    # Set file permissions 
    chmod +x /Scripts/newroute.sh && \
    chmod +x /Scripts/whatmyip.sh && \
    chmod +x /Scripts/randomise_mac.sh && \
    printf "SocksPort 0.0.0.0:9050 \nClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\nHashedControlPassword 16:30CFA39CDFB93D1F6060DF7954611B8952C3774F46C092E11B7359A304\nControlPort 9051" | tee -a /etc/torrc && \
    # Install pagodo python dependancies
    python3 -m pip install yagooglesearch && \
    # Scrape dorks database
    printf "echo 'Building Proxy Network' \ntor > /dev/tty & \nsleep 10\nss -nlt && \n/Scripts/whatmyip.sh && \nsource torsocks on && \n/Scripts/whatmyip.sh && \n echo ''" | tee -a /etc/bash.bashrc
    # python3 -m pip install --upgrade certifi
    # python3 /pagodo/ghdb_scraper.py
    # Modify Bashrc
# Upload config files
COPY Config/proxychains4.conf /etc/proxychains4.conf
# COPY Config/torrc /etc/tor/torrc
# COPY Config/torsocks.conf /etc/tor/torsocks.conf
COPY Config/crontab /etc/crontab
# Setup Connections & Shell
# EXPOSE 9050
USER root
CMD /usr/bin/bash

