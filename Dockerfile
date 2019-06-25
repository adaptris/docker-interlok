FROM centos:7

MAINTAINER Adaptris

EXPOSE 8080 5555 7100

# Since python34-libs requires epel-release we have to do at least 2 yum install steps; this does make me sad.
# This list is also probably too many packages; but the hpcc documentation doesn't tell use the precise dependencies.
# First line was sufficient (-epel-release) for client-tools 6.4.46; the line starting m4 required by 7.2.12
RUN yum -y update && \
    yum -y install epel-release apr apr-util boost-regex expect atlas tbb curl unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum -y install m4 libtool gcc-c++ openssh-server openssh-clients rsync psmisc zip libarchive libmemcached numactl-libs python34-libs && \
    yum -y install https://edgecastcdn.net/00423A/releases/CE-Candidate-7.2.16/bin/clienttools/hpccsystems-clienttools-community_7.2.16-1.el7.x86_64.rpm && \
    yum -y clean all

ARG INTERLOK_VERSION=3.9.0
ARG BASE_URL=https://development.adaptris.net/installers/Interlok/${INTERLOK_VERSION}/

ADD docker-entrypoint.sh /
ADD interlok-entrypoint.sh /
RUN mkdir -p /opt/interlok/logs
WORKDIR /opt/interlok/

RUN \
    curl -fsSL -o base-filesystem.zip -q ${BASE_URL}/base-filesystem.zip && \
    curl -fsSL -o runtime-libraries.zip ${BASE_URL}/runtime-libraries.zip && \
    unzip -o -q  runtime-libraries.zip && \
    unzip -o -q  base-filesystem.zip && \
    cp /opt/interlok/optional/hpcc/interlok-hpcc.jar /opt/interlok/lib/interlok-hpcc.jar && \
    rm -rf /opt/interlok/optional && \
    chmod +x /docker-entrypoint.sh && \
    chmod +x /interlok-entrypoint.sh && \
    rm -rf *.zip && \
    curl -fsSL -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
    chmod +x /usr/local/bin/dumb-init

VOLUME [ "/opt/interlok/config", "/opt/interlok/logs" , "/opt/interlok/ui-resources" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
