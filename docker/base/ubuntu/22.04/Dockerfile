FROM ubuntu:22.04 as installer

COPY ./scripts /opt/docker/base/scripts

RUN /opt/docker/base/scripts/manage_ca_certs.sh

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    bzip2 \
    curl \
    gpg \
    unattended-upgrades && \
    unattended-upgrade -d -v

ENV GOSU_VERSION=1.16

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/entrypoint.sh

FROM ubuntu:22.04

COPY ./scripts/manage_ca_certs.sh /opt/docker/base/scripts/manage_ca_certs.sh

RUN /opt/docker/base/scripts/manage_ca_certs.sh

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    lsb-release \
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
