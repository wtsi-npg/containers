ARG BASE_IMAGE=ubuntu:22.04
FROM $BASE_IMAGE

ARG IRODS_VERSION="4.3-nightly"

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
    apt-get update

ENV NIGHTLY_URL_BASE=https://github.com/wtsi-npg/irods_development_environment/releases/download/nightly/

RUN curl -sSL \
    -O ${NIGHTLY_URL_BASE}irods-dev_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-runtime_4.3.0-1.jammy_amd64.deb \
    -O ${NIGHTLY_URL_BASE}irods-icommands_4.3.0-1.jammy_amd64.deb

RUN ls -l && apt-get install -y ./*.deb

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    check \
    cmake \
    gdb \
    git \
    jq \
    lcov \
    less \
    libjansson-dev \
    libtool \
    netcat \
    pkg-config \
    python3-sphinx \
    ssh \
    valgrind \
    unattended-upgrades && \
    unattended-upgrade -v

ENV CPPFLAGS="-I/usr/include/irods" \
    CK_DEFAULT_TIMEOUT=20

CMD ["/bin/bash"]
