FROM ubuntu:22.04 as installer

ENV GOSU_VERSION=1.16

COPY ./scripts /opt/docker/base/scripts

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    bzip2 \
    ca-certificates \
    curl \
    gpg \
    unattended-upgrades && \
    unattended-upgrade -d -v

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/entrypoint.sh

FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    unattended-upgrades && \
    unattended-upgrade -d -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=installer /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=installer /opt/docker/base/scripts/entrypoint.sh \
    /opt/docker/base/scripts/entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/entrypoint.sh"]
