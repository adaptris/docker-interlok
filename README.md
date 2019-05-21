# docker-adapter [![Docker Build Status](https://img.shields.io/docker/build/adaptris/interlok.svg)](https://hub.docker.com/r/adaptris/interlok/) [![Docker Pulls](https://img.shields.io/docker/pulls/adaptris/interlok.svg)](https://hub.docker.com/r/adaptris/interlok/)

Basic Docker image of the adapter that uses `amazoncorretto:8` as its base image.

* Exposes ports 8080 + 5555
* Installed to /opt/interlok
* Volumes : /opt/interlok/config /opt/interlok/logs /opt/interlok/ui-resources

You could use this as your base layer if you want to use the AWS JDK build.