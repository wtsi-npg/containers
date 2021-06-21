FROM centos:7 as installer

ENV GOSU_VERSION=1.11

COPY ./scripts /opt/docker/base/scripts

RUN yum -y update && \
    yum -y install curl

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/docker-entrypoint.sh

FROM centos:7

COPY --from=installer /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=installer /opt/docker/base/scripts/docker-entrypoint.sh \
    /opt/docker/base/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/docker-entrypoint.sh"]
