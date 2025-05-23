
ARG BASE_IMAGE=python:3.10-slim
FROM $BASE_IMAGE as builder

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    libsqlite3-dev \
    unattended-upgrades && \
    unattended-upgrade -v

WORKDIR /app

COPY ./scripts/*.sh /app/docker/scripts/

COPY ./logging.json /app/docker/logging.json

ARG PORCH_VERSION=2.0.0

# The last 2 lines are a workaround for porch's pip install not copying the scripts
RUN python -m venv /app && \
    . /app/bin/activate && \
    pip install --no-cache-dir --upgrade pip && \
    git clone --branch "v${PORCH_VERSION}" --single-branch https://github.com/wtsi-npg/npg_porch.git /tmp/npg_porch && \
    cd /tmp/npg_porch && \
    pip install --no-cache-dir . && \
    mkdir /app/scripts && \
    cp ./scripts/*.py /app/scripts/ 

FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -q -y --no-install-recommends \
    curl \
    libsqlite3-0 \
    postgresql \
    sudo \
    tini \
    locales && \
    locale-gen en_GB en_GB.UTF-8 && \
    localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

RUN apt-get install -q -y --no-install-recommends \
    unattended-upgrades && \
    unattended-upgrade -v && \
    apt-get remove -q -y unattended-upgrades && \
    apt-get autoremove -q -y && \
    apt-get clean -q -y && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB \
    LC_ALL=en_GB.UTF-8 \
    TZ="Etc/UTC"

ARG APP_USER=appuser
ARG APP_UID=1000
ARG APP_GID=$APP_UID

WORKDIR /app

RUN groupadd --gid $APP_GID $APP_USER && \
    useradd --uid $APP_UID --gid $APP_GID --shell /bin/bash --create-home $APP_USER

COPY --from=builder --chown=$APP_USER:$APP_GID /app /app

ARG DB_HOST=localhost
ARG DB_PORT=5432
ARG DB_SCHEMA=porch_dev
ARG DB_NAME=porch_dev_db
ARG DB_USER=porch_admin
ARG DB_PASS=porch
ARG URL_SLUG="$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME"

ENV DB_HOST=$DB_HOST \
    DB_PORT=$DB_PORT \
    DB_SCHEMA=$DB_SCHEMA \
    DB_NAME=$DB_NAME \
    DB_USER=$DB_USER \
    DB_PASS=$DB_PASS \
    DB_URL="postgresql+psycopg2://$URL_SLUG"

RUN service postgresql start && \
    /app/docker/scripts/create_database.sh && \
    /app/docker/scripts/configure_database_service.sh && \
    . /app/bin/activate && \
    /app/scripts/deploy_schema.py && \
    /app/docker/scripts/insert_admin_token.sh && \
    service postgresql stop

USER $APP_USER

ARG PORT=8081

ENV DB_URL="postgresql+asyncpg://$URL_SLUG" \
    PORT=${PORT}

EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD curl -f http://localhost:${PORT} || exit 1

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/app/docker/scripts/entrypoint.sh"]
