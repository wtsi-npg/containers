ARG BASE_IMAGE=ub-18.04-base
FROM $BASE_IMAGE

ARG IRODS_VERSION="4.3.0"

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

RUN curl -sSL https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    irods-server="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-runtime="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-database-plugin-postgres="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-icommands="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-dev="${IRODS_VERSION}-1~$(lsb_release -sc)" && \
    apt-get install -q -y -f && \
    unattended-upgrade -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y && \
    rm -rf /var/lib/apt/lists/*

RUN /opt/docker/irods/scripts/create_database.sh && \
    /opt/docker/irods/scripts/configure_irods.sh

EXPOSE 1247

HEALTHCHECK --interval=10s --timeout=30s --start-period=5s --retries=3 CMD [ "nc", "-v", "-z", "localhost", "1247" ]

ENTRYPOINT []
CMD ["/opt/docker/irods/scripts/start_irods.sh"]
