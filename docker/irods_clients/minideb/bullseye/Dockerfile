
ARG DOCKER_TAG_PREFIX=wsinpg

FROM $DOCKER_TAG_PREFIX/md-bullseye-conda:latest as installer

ADD . /opt/docker/irods_clients

RUN /opt/docker/irods_clients/scripts/install_irods_icommands.sh && \
    /opt/docker/irods_clients/scripts/install_baton.sh && \
    /opt/docker/irods_clients/scripts/install_samtools.sh

FROM $DOCKER_TAG_PREFIX/md-bullseye-base:latest

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    locales && \
    locale-gen en_GB en_GB.UTF-8 && \
    localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

RUN apt-get install -q -y --no-install-recommends \
    unattended-upgrades && \
    unattended-upgrade -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the bare Conda environment to reduce image size. The resulting image
# no longer has Conda in it, so don't expect to be able to use this image
# for any operations requiring it.
COPY --from=installer /opt/conda/envs/irods /opt/conda/envs/irods
COPY --from=installer /opt/docker/irods_clients/scripts/* /opt/docker/irods_clients/scripts/

ENTRYPOINT ["/opt/docker/irods_clients/scripts/docker-entrypoint.sh"]
