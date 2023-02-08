FROM postgres:latest

COPY Scripts /Scripts
COPY Config /Config
RUN chmod -R +x /Scripts
RUN apt update && \ 
    apt install libxml2-utils -y
USER postgres
RUN initdb
USER root
COPY Config/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf
USER postgres