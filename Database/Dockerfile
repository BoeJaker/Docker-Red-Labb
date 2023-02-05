FROM postgres:latest
COPY Scripts /Scripts
RUN chmod -R +x /Scripts
USER postgres
RUN initdb
