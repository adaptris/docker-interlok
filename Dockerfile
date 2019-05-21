FROM adaptris/interlok:latest-hpcc

EXPOSE 8080
EXPOSE 5555
EXPOSE 7100

ARG java_tool_opts
ENV JAVA_TOOL_OPTIONS=$java_tool_opts

WORKDIR /opt/interlok/
ADD ant /opt/interlok/ant

RUN yum -y install ant && \
    yum -y clean all && \
    rm -f /opt/interlok/lib/adp-*.jar && \
    cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.ivy2/cache

ENV JAVA_TOOL_OPTIONS=""

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]
