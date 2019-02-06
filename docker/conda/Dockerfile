FROM ubuntu-12.04-base:v1

ENV CONDA_GROUP_ID 32001

RUN apt-get install -q -y \
    git

RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB
ENV LC_ALL en_GB.UTF-8

COPY . /opt/docker/conda
RUN /opt/docker/conda/scripts/install_conda.sh && \
    chmod +x /opt/docker/conda/scripts/docker-entrypoint.sh

RUN groupadd -g $CONDA_GROUP_ID conda && \
    chgrp -R conda /opt/conda && \
    chmod -R g=u /opt/conda

ENTRYPOINT ["/opt/docker/conda/scripts/docker-entrypoint.sh"]

CMD ["/bin/bash"]
