ARG INTERLOK_BASE_IMAGE=4
FROM adaptris/interlok-base:${INTERLOK_BASE_IMAGE}-msopenjdk

COPY builder /root/builder

RUN \
    cd /root/builder && \
    chmod +x /root/builder/gradlew && \
    ./gradlew --no-daemon -PinterlokDistDirectory=/opt/interlok installDist -PinterlokVersion=${INTERLOK_VERSION} && \
    rm -rf /root/.gradle && \
    rm -rf /root/builder

EXPOSE 8080 5555
VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]
