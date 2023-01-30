
FROM mitmproxy/mitmproxy:latest
# RUN export http_proxy="http://localhost:8080/" &&\
RUN apt update && \
    apt install nmap curl iptables iptables-persistent -y
# EXPOSE 8080
COPY iptables.sh /Scripts
USER root
CMD /bin/bash 
# /Scripts/iptables.sh &