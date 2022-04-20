ARG DOCKER_TAG_PREFIX=wsinpg

FROM $DOCKER_TAG_PREFIX/ub-18.04-base:latest

ARG IRODS_VERSION=4.2.11-1~bionic
ARG IRODS_PACKAGES_URL=https://packages.irods.org
ARG UBUNTU_RELEASE=bionic

WORKDIR /opt/docker/irods

COPY ./scripts/*.sh ./scripts/
COPY ./config/* ./config/
COPY ./patches/* ./patches/

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gpg \
    gpg-agent \
    curl && \
    curl -sSL $IRODS_PACKAGES_URL/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] $IRODS_PACKAGES_URL/apt $UBUNTU_RELEASE main" | \
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    postgresql \
    jq \
    patch \
    irods-server="$IRODS_VERSION" \
    irods-runtime="$IRODS_VERSION" \
    irods-database-plugin-postgres="$IRODS_VERSION" \
    irods-icommands="$IRODS_VERSION" \
    irods-dev="$IRODS_VERSION" && \
    apt-get install -q -y -f && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y && \
    rm -rf /var/lib/apt/lists/*

RUN /opt/docker/irods/scripts/create_database.sh && \
    /opt/docker/irods/scripts/configure_irods.sh

EXPOSE 1247

ENTRYPOINT []
CMD ["/opt/docker/irods/scripts/start_irods.sh"]
