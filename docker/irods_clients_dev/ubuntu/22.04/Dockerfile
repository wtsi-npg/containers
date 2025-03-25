ARG BASE_IMAGE=ubuntu:22.04
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive

COPY . /opt/docker/irods_clients_dev

RUN apt-get update && \
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
    LC_ALL=en_GB.UTF-8 \
    TZ=/Etc/UTC

# The latest usable version
ARG IRODS_VERSION="4.3.1"
# The Debian package revision number
ARG IRODS_REVISION="0"

RUN curl -sSL https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" |\
    tee /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    irods-dev="${IRODS_VERSION}-${IRODS_REVISION}~$(lsb_release -sc)" \
    irods-runtime="${IRODS_VERSION}-${IRODS_REVISION}~$(lsb_release -sc)" \
    irods-icommands="${IRODS_VERSION}-${IRODS_REVISION}~$(lsb_release -sc)"

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
