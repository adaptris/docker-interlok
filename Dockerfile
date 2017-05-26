FROM openjdk:8-jdk-alpine

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555

ADD docker-entrypoint.sh /
RUN mkdir -p /opt/interlok/logs
WORKDIR /opt/interlok/

RUN apk add --no-cache --update ca-certificates openssl bash wget && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.2/base-filesystem.zip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.2/runtime-libraries.zip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.2/javadocs.zip && \
    unzip -n -q javadocs.zip && \
    unzip -n -q  runtime-libraries.zip && \
    unzip -n -q  base-filesystem.zip && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/docs/javadocs/optional && \
    rm -rf *.zip

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

WORKDIR /opt/interlok

ENTRYPOINT ["/docker-entrypoint.sh"]
