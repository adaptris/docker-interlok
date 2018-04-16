FROM adaptris/interlok:3.7.1-alpine

EXPOSE 8080
EXPOSE 5555

RUN apk add --no-cache --update apache-ant

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant
ADD docker-entrypoint.sh /
ARG ant_opts
ENV ANT_OPTS=$ant_opts

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

RUN cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.ivy2/cache/com.adaptris.ui

ENV ANT_OPTS=""

ENTRYPOINT ["/docker-entrypoint.sh"]
