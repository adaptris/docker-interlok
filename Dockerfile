FROM adaptris/interlok:3.6.1

EXPOSE 8080
EXPOSE 5555

RUN apt-get update && \
    apt-get -y install ant && \
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant
ADD docker-entrypoint.sh /

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

RUN cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    chmod +x /docker-entyrpoint.sh && \
    rm -rf /root/.ivy2/cache/com.adaptris.ui

ENTRYPOINT ["/docker-entrypoint.sh"]
