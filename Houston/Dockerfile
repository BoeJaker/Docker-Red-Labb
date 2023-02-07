FROM kalilinux/kali-rolling:latest
COPY Scripts /Scripts
RUN apt update && \
    apt install git python3 python3-pip iproute2 nmap netcat-traditional webscarab libpcap-dev sqlmap -y && \
    apt install postgresql-client -y && \
    apt install iputils-ping curl wget && \
    # Clone git repos
    git clone https://github.com/opsdisk/pagodo.git /pagodo && \
    # Install python packages
    python3 -m pip install yagooglesearch
    # python3 -m pip install --upgrade certifi
    # python3 /pagodo/ghdb_scraper.py # update pagodo database
USER root
CMD /usr/bin/bash