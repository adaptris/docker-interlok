FROM centos:7

MAINTAINER Adaptris

EXPOSE 8080
EXPOSE 5555
EXPOSE 7100

RUN yum -y update && \
    yum -y install apr apr-util boost-regex expect atlas tbb wget unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum -y install http://cdn.hpccsystems.com/releases/CE-Candidate-6.4.6/bin/clienttools/hpccsystems-clienttools-community_6.4.6-1.el7.x86_64.rpm && \
    yum -y clean all

ADD docker-entrypoint.sh /
ADD interlok-entrypoint.sh /
RUN mkdir -p /opt/interlok/logs
WORKDIR /opt/interlok/

RUN wget -q https://development.adaptris.net/installers/Interlok/3.7.3/base-filesystem.zip && \
    wget -q https://development.adaptris.net/installers/Interlok/3.7.3/runtime-libraries.zip && \
    unzip -o -q  runtime-libraries.zip && \
    unzip -o -q  base-filesystem.zip && \
    cp /opt/interlok/optional/hpcc/interlok-hpcc.jar /opt/interlok/lib/interlok-hpcc.jar && \
    rm -rf /opt/interlok/optional && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf *.zip && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
    chmod +x /usr/local/bin/dumb-init

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
