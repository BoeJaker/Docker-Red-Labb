FROM kalilinux/kali-rolling:latest
ARG KALI_METAPACKAGE=core
ARG KALI_DESKTOP=xfce

COPY Scripts /Scripts
RUN apt update && \
    apt install sudo -y && \
    #
    apt install git python3 python3-pip iproute2 nmap netcat-traditional webscarab libpcap-dev sqlmap -y && \
    # Exploitation frameworks, exploit databases & their dependancies
    apt install apt-utils exploitdb metasploit-framework -y && \
    # searchsploit -u && \
    #
    apt install postgresql-client -y && \
    #
    apt install iputils-ping curl wget -y && \
    #
    apt install nano -y && \
    #
    apt install openvpn easy-rsa openssh-client openssh-server -y && \
    ## Clone git repos
    git clone https://github.com/opsdisk/pagodo.git /pagodo && \
    ## Install python packages
    python3 -m venv /pagodo/venv && \
    source env/bin/activate && \
    python3 -m pip install yagooglesearch && \
    # python3 -m pip install --upgrade certifi
    # python3 /pagodo/ghdb_scraper.py # update pagodo database
    chmod -R +x /Scripts && \
    msfdb init && \
    /Scripts/init.sh

## Install noVNC & VNC servers      
# RUN apt-get -y install kali-linux-${KALI_METAPACKAGE}
# RUN apt-get -y install kali-desktop-${KALI_DESKTOP}
# RUN apt-get -y install tightvncserver dbus dbus-x11 novnc net-tools
ENV VNCEXPOSE 0
ENV VNCPORT 5900
ENV VNCPWD changeme
ENV VNCDISPLAY 1920x1080
ENV VNCDEPTH 16
ENV NOVNCPORT 8888
EXPOSE 5900
EXPOSE 8888
USER root
CMD /usr/bin/bash
RUN useradd -ms /bin/bash Houston
USER Houston