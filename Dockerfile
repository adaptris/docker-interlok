FROM openjdk:8-jdk

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555

WORKDIR /tmp/interlok/

COPY install.ini /tmp/interlok/install.ini

RUN wget -q https://development.adaptris.net/installers/Interlok/3.6.0/interlok-install-3.6.0-RELEASE.bin && \
    sh ./interlok-install-3.6.0-RELEASE.bin -f install.ini && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/UninstallerData && \
    rm -rf /tmp/interlok

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

WORKDIR /opt/interlok

ENTRYPOINT ["/opt/interlok/bin/adapter"]
