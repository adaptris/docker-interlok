FROM adaptris/interlok:latest-alpine

EXPOSE 8080
EXPOSE 5555

RUN apk add --no-cache --update apache-ant

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant
ARG java_tool_opts
ENV JAVA_TOOL_OPTIONS=$java_tool_opts

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

# Remove the legacy adp-*.jar from the distribution first
RUN rm -f /opt/interlok/lib/adp-*.jar && \
    cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.ivy2/cache

ENV JAVA_TOOL_OPTIONS=""

ENTRYPOINT ["/docker-entrypoint.sh"]
