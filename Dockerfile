FROM adaptris/interlok:3.7.3-hpcc

EXPOSE 8080
EXPOSE 5555
EXPOSE 7100

ARG ant_opts
ENV ANT_OPTS=$ant_opts

WORKDIR /opt/interlok/
ADD ant /opt/interlok/ant

RUN yum -y install ant && \
    yum -y clean all && \
    rm -f /opt/interlok/lib/adp-*.jar && \
    cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.ivy2/cache/com.adaptris.ui

ENV ANT_OPTS=""

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]
