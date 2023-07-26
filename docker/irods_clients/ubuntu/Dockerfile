# syntax=docker/dockerfile:1

ARG BASE_IMAGE=ubuntu:bionic
FROM $BASE_IMAGE as installer

# Other iRODS versions available on bionic are 4.3.0
ARG IRODS_VERSION="4.2.11"
ARG BATON_VERSION="4.1.0"
ARG HTSLIB_VERSION="1.18"
ARG SAMTOOLS_VERSION="1.18"
ARG BCFTOOLS_VERSION="1.18"
ARG HTSLIB_PLUGINS_VERSION="201712"

COPY . /opt/docker/irods_clients

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    dirmngr \
    gpg \
    gpg-agent \
    lsb-release \
    locales && \
    locale-gen en_GB en_GB.UTF-8 && \
    localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

RUN curl -sSL https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" |\
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    irods-dev="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-runtime="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-icommands="${IRODS_VERSION}-1~$(lsb_release -sc)"

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "E1DD270288B4E6030699E45FA1715D88E1DF1F24" && \
    echo "deb https://ppa.launchpadcontent.net/git-core/ppa/ubuntu $(lsb_release -sc) main" |\
    tee /etc/apt/sources.list.d/git-core.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    git

# libdeflate-dev is not available on Ubuntu 18.04
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    less \
    libtool \
    pkg-config \
    python3-sphinx \
    ssh \
    libjansson-dev \
    libbz2-dev \
    libcurl3-dev \
    liblzma-dev \
    zlib1g-dev

ENV CPPFLAGS="-I/usr/include/irods"

RUN cd /tmp && \
    curl -sSL -O "https://github.com/wtsi-npg/baton/releases/download/${BATON_VERSION}/baton-${BATON_VERSION}.tar.gz" && \
    tar xfz baton-${BATON_VERSION}.tar.gz && \
    cd baton-${BATON_VERSION} && \
    ./configure && \
    make install

RUN cd /tmp && \
    curl -sSL -O "https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2" && \
    tar xfj htslib-${HTSLIB_VERSION}.tar.bz2 && \
    cd htslib-${HTSLIB_VERSION} && \
    ./configure --enable-plugins --without-curses && \
    make install && \
    ldconfig

RUN cd /tmp && \
    curl -sSL -O "https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2" && \
    tar xfj samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    cd samtools-${SAMTOOLS_VERSION} && \
    ./configure --with-htslib=system --without-curses && \
    make install

RUN cd /tmp && \
    curl -sSL -O "https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2" && \
    tar xfj bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    cd bcftools-${BCFTOOLS_VERSION} && \
    ./configure --with-htslib=system --without-curses && \
    make install

RUN cd /tmp && \
    git clone --depth 1 --branch ${HTSLIB_PLUGINS_VERSION} "https://github.com/samtools/htslib-plugins.git" && \
    cd htslib-plugins && \
    make install

FROM $BASE_IMAGE 

ARG DOCKER_IMAGE
ARG DOCKER_TAG
ARG IRODS_VERSION="4.2.11"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    dirmngr \
    gpg \
    gpg-agent \
    lsb-release \
    locales && \
    locale-gen en_GB en_GB.UTF-8 && \
    localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8

RUN curl -sSL https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" |\
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \ 
    apt-get install -q -y --no-install-recommends \
    irods-icommands="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    irods-runtime="${IRODS_VERSION}-1~$(lsb_release -sc)" \
    jq \
    libjansson4 \
    libbz2-1.0 \
    libcurl3 \
    liblzma5 \
    zlib1g \
    unattended-upgrades && \
    unattended-upgrade -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y && \
    rm -rf /var/lib/apt/lists/*

# Copy the installed baton and samtools applications
COPY --from=installer /usr/local /usr/local

# Copy the singularity-wrapper scripts
COPY --from=singularity ./scripts/* /usr/local/bin/
COPY --from=installer /opt/docker/irods_clients/manifest.json /usr/local/irods_clients/etc/manifest.json
COPY --from=installer /opt/docker/irods_clients/scripts/docker-entrypoint.sh /usr/local/irods_clients/bin/docker-entrypoint.sh
COPY --from=installer /opt/docker/irods_clients/scripts/singularity-* /usr/local/bin/

# Configure the singularity-wrapper script
ENV MANIFEST_PATH="/usr/local/irods_clients/etc/manifest.json"
ENV DOCKER_IMAGE="$DOCKER_IMAGE"
ENV DOCKER_TAG="$DOCKER_TAG"

RUN ldconfig

ENTRYPOINT ["/usr/local/irods_clients/bin/docker-entrypoint.sh"]

CMD ["/bin/bash"]
