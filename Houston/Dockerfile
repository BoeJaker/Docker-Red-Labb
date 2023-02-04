FROM kalilinux/kali-rolling:latest
COPY Scripts /Scripts
RUN apt update && \
    apt install git python3 python3-pip iproute2 nmap webscarab libpcap-dev sqlmap -y && \
    # Clone git repos
    git clone https://github.com/opsdisk/pagodo.git /pagodo && \
    # Install python packages
    python3 -m pip install yagooglesearch
    # python3 -m pip install --upgrade certifi
    # python3 /pagodo/ghdb_scraper.py # update pagodo database
USER root
CMD /usr/bin/bash