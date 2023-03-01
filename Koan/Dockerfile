
FROM mitmproxy/mitmproxy:latest

COPY Scripts /Scripts

RUN apt update && \
    # Setup locals and windows to unix line-end conversion
    apt install locales dos2unix -y && locale-gen en_US.UTF-8 && \
    export LC_CTYPE=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    find /Scripts -type f -print0 | xargs -0 dos2unix && \
    \
    # Networking utils
    apt install iputils-ping nmap curl iptables iptables-persistent \
    iproute2 tcpdump dsniff netcat-traditional traceroute -y && \
    # Proxy packages
    apt install proxychains tor obfs4proxy ettercap-text-only -y && \
    ## Postgres & XML utils 
    apt install postgresql-client libxml2-utils -y && \
    ## System utilities (optional)
    apt install nano cron -y && \
    ## Python packages
    apt install python3 python3-pip python-dev -y && \
    ## LUA Packages
    apt install libpq-dev -y && \ 
    # lua5.3 luarocks -y && \
    ## VPN & CA Packages
    apt install openvpn easy-rsa openssh-client openssh-server -y && \
    apt install sudo -y && \
    ## Gives scripts execute permission
    chmod -R +x /Scripts && \
    \
    # proxychains4-daemon
    \
    /Scripts/Server_KeyGen.sh && \
    /Scripts/Init/Routing.sh && \
    printf "echo 'Checking docker network integrity' ; \
            \
            /Scripts/Init/post-compose-check.sh" | tee -a /etc/bash.bashrc && \ 
    \
    ## Tor monitor
    python3 -m pip install nyx && \
    ## Postgres connector
    python3 -m pip install psycopg2 && \
    ## Nmap 
    python3 -m pip install python-nmap && \
    ## Packet sniffing
    python3 -m pip install scapy

# RUN luarocks --lua-version=5.3 install luapgsql PQ_INCDIR=/usr/include/postgresql PQ_LIBDIR=/usr/lib/x86_64-linux-gnu

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

COPY Config/proxychains.conf /etc/proxychains.conf
COPY Config/crontab /etc/crontab

RUN useradd -ms /bin/bash Koan
USER Koan
