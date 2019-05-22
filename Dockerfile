FROM adaptris/interlok:latest-hpcc

EXPOSE 8080
EXPOSE 5555
EXPOSE 7100

ARG java_tool_opts
ENV JAVA_TOOL_OPTIONS=$java_tool_opts
ENV JAVA_HOME=/usr/lib/jvm/java

WORKDIR /opt/interlok
COPY builder /root/builder

RUN cd /root/builder && \
    chmod +x /root/builder/gradlew && \
    ./gradlew --no-daemon installDist && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.gradle && \
    rm -rf /root/builder

ENV JAVA_TOOL_OPTIONS=""

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]
