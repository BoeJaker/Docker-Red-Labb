FROM kalilinux/kali-rolling:latest
ARG KALI_METAPACKAGE=full
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
    #
    apt install python3.11-venv && \
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

# Setup postgres request forwarding
RUN apt-get install socat -y
RUN socat TCP-LISTEN:5432,fork TCP:workbench_postgres-log_1:5432 &

# Set up VNC server
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd secret ~/.vnc/passwd

# Maltego & Metasploit
RUN apt-get install metasploit-framework  -y
RUN apt-get install maltego -y
RUN git clone https://github.com/shizzz477/msploitego.git

# Copy metaploit database configuration
COPY ./client/kali/database.yml /usr/share/metasploit-framework/config/database.yml

# # Configure SSH server
RUN apt-get install -y openssh-server 
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "X11Forwarding yes" >> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

# Install essential security tools and update them
RUN apt-get install -y \
    nmap \
    openssh-client \
    iptables \
    lynis \
    && apt-get clean

# # Configure Lynis security auditing tool
# RUN sed -i 's/^# CRONFILE=.*/CRONFILE="no"/' /etc/lynis/lynis.conf

# # Remove unnecessary services and packages
RUN apt-get purge -y \
    rpcbind \
    telnet \
    && apt-get autoremove -y && apt-get clean

# # Remove unnecessary setuid and setgid files
RUN find / -perm /6000 -type f -exec chmod a-s {} \; || true
RUN find / -perm /4000 -type f -exec chmod a-s {} \; || true

# # Disable core dumps
RUN echo "* hard core 0" > /etc/security/limits.d/10-kali-disable-core-dumps.conf

# Set a secure umask value
RUN echo "umask 027" >> /etc/bash.bashrc
RUN systemctl disable syslog

## Install noVNC & VNC servers      
RUN apt-get -y install kali-linux-${KALI_METAPACKAGE}
RUN apt-get -y install kali-desktop-${KALI_DESKTOP}
RUN apt-get -y install tightvncserver dbus dbus-x11 novnc net-tools

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

# RUN useradd -ms /bin/bash Houston
# USER Houston