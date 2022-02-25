FROM centos:7 as installer

ENV GOSU_VERSION=1.14

COPY ./scripts /opt/docker/base/scripts

RUN yum -y update && \
    yum -y install curl

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/docker-entrypoint.sh

FROM centos:7

# CentOS 7 does not support applying only security updates to packages,
# so we do a global package update instead
RUN yum -y update

COPY --from=installer /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=installer /opt/docker/base/scripts/docker-entrypoint.sh \
    /opt/docker/base/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/docker-entrypoint.sh"]
