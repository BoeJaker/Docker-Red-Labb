
FROM mitmproxy/mitmproxy:latest
# RUN export http_proxy="http://localhost:8080/" &&\
RUN apt update && \
    apt install nmap curl proxychains4 tor iptables iptables-persistent tcpdump -y 
    # proxychains4-daemon
# EXPOSE 8080
COPY iptables.sh /Scripts/ip6tables.sh
USER root
CMD /bin/bash 
# /Scripts/iptables.sh &