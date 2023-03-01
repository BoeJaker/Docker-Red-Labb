FROM postgres:latest

COPY Scripts /Scripts
COPY Config /Config
RUN chmod -R +x /Scripts
RUN apt update && \ 
    ##
    apt install libxml2-utils nano -y && \
    ##
    apt install postgresql-contrib -y && \
    ##
    apt install openvpn easy-rsa openssh-client openssh-server -y
    # apt install ecryptfs-utils -y && \
    # chown postgres -R /var/lib/postgresql
    # mount -t ecryptfs /var/lib/postgresql/data/ /var/lib/postgresql/data/
USER postgres
RUN initdb
USER root
COPY Config/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf
USER postgres