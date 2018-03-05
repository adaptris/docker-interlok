FROM adaptris/interlok:3.7.0-hpcc

EXPOSE 8080
EXPOSE 5555
EXPOSE 7100

WORKDIR /opt/interlok/
ADD ant /opt/interlok/ant

RUN yum -y install ant && \
    yum -y clean all && \
    cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.ivy2/cache/com.adaptris.ui

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]