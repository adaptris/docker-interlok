FROM adaptris/interlok:latest-zulu-alpine

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555


ARG java_tool_opts
ENV JAVA_TOOL_OPTIONS=$java_tool_opts

WORKDIR /opt/interlok
COPY builder /root/builder

RUN cd /root/builder && \
    chmod +x /root/builder/gradlew && \
    ./gradlew --no-daemon installDist && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /root/.gradle && \
    rm -f /opt/interlok/lib/javax.el-api.jar && \
    rm -rf /root/builder

ENV JAVA_TOOL_OPTIONS=""

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]
