FROM docker.io/bitnami/minideb:bullseye-amd64 as installer

ENV DEBIAN_FRONTEND=noninteractive \
    GOSU_VERSION=1.16

COPY ./scripts /opt/docker/base/scripts

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    bzip2 \
    ca-certificates \
    curl \
    dirmngr \
    gpg \
    gpg-agent \
    unattended-upgrades && \
    unattended-upgrade -d -v 

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/docker-entrypoint.sh

FROM docker.io/bitnami/minideb:bullseye-amd64

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    unattended-upgrades && \
    unattended-upgrade -d -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=installer /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=installer /opt/docker/base/scripts/docker-entrypoint.sh \
    /opt/docker/base/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/docker-entrypoint.sh"]
