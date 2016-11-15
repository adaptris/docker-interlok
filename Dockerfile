FROM openjdk:8-jdk

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555

WORKDIR /tmp/interlok/

COPY install.ini /tmp/interlok/install.ini

RUN wget -q https://development.adaptris.net/installers/Interlok/3.4.1/install.bin && \
    sh ./install.bin -f install.ini && \
    wget -q -O /opt/interlok/lib/commons-lang3.jar http://central.maven.org/maven2/org/apache/commons/commons-lang3/3.5/commons-lang3-3.5.jar && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/UninstallerData && \
    rm -rf /tmp/interlok

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" ]

WORKDIR /opt/interlok

ENTRYPOINT ["/opt/interlok/bin/adapter"]
