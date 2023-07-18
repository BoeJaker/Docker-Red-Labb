FROM kalilinux/kali-rolling:latest AS base

RUN apt update
RUN apt install sudo apt-utils -y
RUN apt install git python3 python3-pip -y
RUN apt install iproute2 nmap netcat-traditional webscarab libpcap-dev sqlmap iputils-ping curl wget -y
RUN apt install postgresql-client -y
RUN apt install nano -y
RUN apt install python3.11-venv -y

RUN apt-get -y install kali-linux-everything
RUN apt-get -y install kali-desktop-xfce
RUN apt-get -y install novnc python3-websockify python3-numpy
RUN apt-get install x11vnc -y
RUN apt-get install xvfb -y
RUN apt-get install xfce4-terminal -y
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd secret ~/.vnc/passwd

FROM base AS ssh

# # Configure SSH server
RUN apt install openvpn easy-rsa openssh-client openssh-server -y
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "X11Forwarding yes" >> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

FROM ssh AS postgres

# Setup postgres request forwarding
RUN apt-get install socat -y
RUN socat TCP-LISTEN:${MSFDB_PORT},fork TCP:${LOCALHOST}:${MSFDB_PORT} &
# Copy database configuration
COPY database.yml /usr/share/metasploit-framework/config/database.yml

FROM postgres as packages

# Dorking
RUN git clone https://github.com/opsdisk/pagodo.git /pagodo
RUN python3 -m venv /pagodo/venv
RUN source /env/bin/activate
RUN python3 -m pip install yagooglesearch
RUN python3 -m pip install --upgrade certifi
RUN python3 /pagodo/ghdb_scraper.py # update pagodo database

# Maltego & Metasploit
RUN apt-get install metasploit-framework  -y
RUN apt-get install maltego -y
RUN git clone https://github.com/shizzz477/msploitego.git

# Backdoors
# TODO - movepackage setup to its own shell script 

FROM packages as hardened

# Remove unnecessary services and packages
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

FROM hardened as initialse

# Copy scripts and add execution permissions
COPY Scripts/pyenv_init.sh /pyenv_init.sh
RUN chmod +x /pyenv_init.sh
# Ensure line endings are correct
RUN sed -i -e 's/\r$//' /pyenv_init.sh 

# COPY Scripts/change_python_version.sh /root/change_python_version.sh
# RUN chmod +x /root/change_python_version.sh
# # Ensure line endings are correct
# RUN sed -i -e 's/\r$//' /change_python_version.sh 

COPY Scripts /Scripts
RUN chmod -R +x /Scripts
RUN apt-get install dbus-tests
CMD [ "/bin/bash", "/pyenv_init.sh"  ]