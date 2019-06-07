FROM ubuntu:16.04 as installer

ENV GOSU_VERSION=1.11

COPY ./scripts /opt/docker/base/scripts

RUN apt-get update && \
    apt-get install -q -y \
    apt-utils \
    bzip2 \
    ca-certificates \
    curl

RUN GOSU_VERSION=$GOSU_VERSION /opt/docker/base/scripts/install_gosu.sh && \
    chmod +x /opt/docker/base/scripts/docker-entrypoint.sh

FROM ubuntu:16.04

COPY --from=installer /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=installer /opt/docker/base/scripts/docker-entrypoint.sh \
    /opt/docker/base/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/base/scripts/docker-entrypoint.sh"]
