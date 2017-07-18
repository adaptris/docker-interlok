FROM openjdk:8-jdk-alpine

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555

ADD docker-entrypoint.sh /
RUN mkdir -p /opt/interlok/logs
WORKDIR /opt/interlok/

RUN apk add --no-cache --update ca-certificates openssl bash wget unzip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.3/base-filesystem.zip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.3/runtime-libraries.zip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.6.3/javadocs.zip && \
    unzip -q -o javadocs.zip && \
    unzip -q -o runtime-libraries.zip && \
    unzip -q -o  base-filesystem.zip && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/docs/javadocs/optional && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf *.zip

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

WORKDIR /opt/interlok

ENTRYPOINT ["/docker-entrypoint.sh"]
