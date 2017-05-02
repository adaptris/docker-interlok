FROM adaptris/interlok:3.6.1-alpine

EXPOSE 8080
EXPOSE 5555

RUN apk add --no-cache --update apache-ant

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant
ADD docker-entrypoint.sh /

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

RUN cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    rm -rf /root/.ivy2/cache/com.adaptris.ui

ENTRYPOINT ["/docker-entrypoint.sh"]
