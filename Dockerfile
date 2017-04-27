FROM openjdk:8-jdk-alpine

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555

WORKDIR /tmp/interlok/

COPY install.ini /tmp/interlok/install.ini

RUN apk add --no-cache --update ca-certificates openssl bash wget && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.1/install.bin && \
    sh ./install.bin -f install.ini && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/UninstallerData && \
    rm -rf /tmp/interlok

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

WORKDIR /opt/interlok

ENTRYPOINT ["/opt/interlok/bin/adapter"]
