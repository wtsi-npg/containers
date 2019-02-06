FROM ubuntu:12.04

ENV GOSU_VERSION 1.11

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    bzip2 \
    ca-certificates \
    curl \
    dialog \
    locales

COPY . /opt/docker/base
RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/docker-entrypoint.sh"]
