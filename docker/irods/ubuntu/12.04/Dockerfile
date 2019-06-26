FROM wsinpg/ub-12.04-base:latest

ENV IRODS_VERSION=4.1.12

WORKDIR /opt/docker/irods

COPY ./ubuntu/12.04/pkg ./pkg
COPY ./scripts/*.sh ./scripts/
COPY ./config/* ./config/

RUN echo "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    lsb-core \
    sudo \
    postgresql unixodbc odbc-postgresql super \
    libjson-perl libfuse2 python-psutil python-requests lsof \
    jq && \
    dpkg -i ./pkg/*.deb && \
    rm -rf ./pkg && \
    apt-get install -q -y -f && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y

RUN /opt/docker/irods/scripts/create_database.sh && \
    /opt/docker/irods/scripts/configure_irods.sh

EXPOSE 1247

ENTRYPOINT []
CMD ["/opt/docker/irods/scripts/start_irods.sh"]
