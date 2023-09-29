ARG BASE_IMAGE=ub-22.04-base
FROM $BASE_IMAGE

ARG IRODS_VERSION="nightly"

WORKDIR /opt/docker/irods

COPY ./scripts/*.sh ./scripts/
COPY ./config/* ./config/
COPY ./patches/* ./patches/

RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    gpg \
    gpg-agent \
    lsb-release \
    jq \
    netcat \
    patch \
    postgresql \
    rsyslog \
    unattended-upgrades \
    locales && \
    locale-gen en_GB en_GB.UTF-8 && \
    localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

# Required to get the externals packages
RUN curl -sSL https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update

ENV NIGHTLY_URL_BASE=https://github.com/wtsi-npg/irods_development_environment/releases/download/nightly/

RUN curl -sSL \
    -O ${NIGHTLY_URL_BASE}irods-database-plugin-postgres_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-dev_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-runtime_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-server_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-icommands_4.3.0-1.jammy_amd64.deb

RUN ls -l && apt-get install -y ./*.deb

RUN /opt/docker/irods/scripts/create_database.sh && \
    /opt/docker/irods/scripts/configure_irods.sh

EXPOSE 1247

HEALTHCHECK --interval=10s --timeout=30s --start-period=5s --retries=3 CMD [ "nc", "-v", "-z", "localhost", "1247" ]

ENTRYPOINT []
CMD ["/opt/docker/irods/scripts/start_irods.sh"]
