FROM openjdk:8-jdk
 
MAINTAINER Adaptris
 
EXPOSE 8080
EXPOSE 5555
 
WORKDIR /tmp/interlok/
 
COPY install.ini /tmp/interlok/install.ini
 
RUN wget -q https://development.adaptris.net/installers/Interlok/3.3.0/install.bin && \
    sh ./install.bin -f install.ini && \
    rm -rf /tmp/interlok
 
COPY log4j2.xml /opt/interlok/config/log4j2.xml

VOLUME /opt/interlok/config
VOLUME /opt/interlok/logs

WORKDIR /opt/interlok

ENTRYPOINT ["/opt/interlok/bin/adapter"]
