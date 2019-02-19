FROM wsinpg/ubuntu-12.04-base:latest as installer

ENV CONDA_GROUP_ID=32001 \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

COPY . /opt/docker/conda

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    locales && \
    localedef -i en_GB -c -f UTF-8 \
    -A /usr/share/locale/locale.alias en_GB.UTF-8 && \
    /opt/docker/conda/scripts/install_conda.sh && \
    cp /root/.condarc /opt/conda/etc/condarc && \
    chmod +x /opt/docker/conda/scripts/docker-entrypoint.sh && \
    groupadd -g $CONDA_GROUP_ID conda && \
    chgrp -R conda /opt/conda && \
    chmod -R g=u /opt/conda

FROM wsinpg/ubuntu-12.04-base:latest

ENV CONDA_GROUP_ID=32001 \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    locales \
    git \
    patch \
    rsync \
    vim && \
    localedef -i en_GB -c -f UTF-8 \
    -A /usr/share/locale/locale.alias en_GB.UTF-8 && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g $CONDA_GROUP_ID conda

COPY --from=installer --chown=0:conda /opt/conda /opt/conda
COPY --from=installer /opt/docker/conda/scripts/docker-entrypoint.sh \
    /opt/docker/conda/scripts/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker/conda/scripts/docker-entrypoint.sh"]

CMD ["/bin/bash"]
