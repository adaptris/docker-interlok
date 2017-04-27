FROM adaptris/interlok:latest-alpine

EXPOSE 8080
EXPOSE 5555

RUN apk add --no-cache --update apache-ant

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

RUN cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant

ENTRYPOINT ["/opt/interlok/bin/adapter"]
