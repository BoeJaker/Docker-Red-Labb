FROM postgres:latest

COPY Scripts /Scripts

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
# Use the official PostgreSQL image as base
# FROM postgres:latest

# Copy the SQL file into the Docker image
# COPY your_sql_file.sql /docker-entrypoint-initdb.d/

# Grant permissions to the SQL file
# RUN chmod a+r /docker-entrypoint-initdb.d/your_sql_file.sql
USER postgres
RUN /Scripts/init.sh
# RUN psql -f /Scripts/docker_postgres_init.sql
