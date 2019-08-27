FROM openjdk:8-jdk-alpine

MAINTAINER Adaptris

EXPOSE 8080 5555

ARG INTERLOK_VERSION=3.9.1
ARG BASE_URL=https://development.adaptris.net/installers/Interlok/${INTERLOK_VERSION}/

RUN \
    apk add --no-cache --update ca-certificates openssl bash curl unzip

ADD docker-entrypoint.sh /
RUN mkdir -p /opt/interlok/logs
WORKDIR /opt/interlok/

RUN  \
    curl -fsSL -o base-filesystem.zip -q ${BASE_URL}/base-filesystem.zip && \
    curl -fsSL -o runtime-libraries.zip ${BASE_URL}/runtime-libraries.zip && \
    curl -fsSL -o javadocs.zip ${BASE_URL}/javadocs.zip && \
    unzip -q -o javadocs.zip && \
    unzip -q -o runtime-libraries.zip && \
    unzip -q -o  base-filesystem.zip && \
    rm -rf /opt/interlok/optional && \
    rm -rf /opt/interlok/docs/javadocs/optional && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf *.zip

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
