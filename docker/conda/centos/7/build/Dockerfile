ARG DOCKER_TAG_PREFIX=wsinpg

FROM $DOCKER_TAG_PREFIX/centos-7-conda:latest

COPY . /opt/docker/conda

ENV CONDA_BUILD_VERSION=3.21.7

RUN /opt/docker/conda/scripts/install_conda_build.sh

ENTRYPOINT ["/opt/docker/conda/scripts/docker-entrypoint.sh"]

CMD ["/bin/bash"]