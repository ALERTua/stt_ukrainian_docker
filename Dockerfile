ARG \
    PYTHON_VERSION=3.13 \
    APP_DIR=/usr/src/app \
    SOURCE_DIR_NAME=source \
    DATA_DIR=/data \
    PORT=7861 \
    GRADIO_SERVER_NAME=0.0.0.0

# -----------------------------------------------------------------
FROM ghcr.io/astral-sh/uv:python${PYTHON_VERSION}-trixie-slim AS builder

ARG \
    APP_DIR \
    SOURCE_DIR_NAME \
    DATA_DIR

ENV \
    # uv
    UV_PYTHON_DOWNLOADS=0 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_FROZEN=1 \
    UV_NO_PROGRESS=true \
    # pip
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    # Python
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONIOENCODING=utf-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    # ARG
    APP_DIR=$APP_DIR \
    SOURCE_DIR_NAME=$SOURCE_DIR_NAME \
    DATA_DIR=$DATA_DIR

ENV \
    # ARG-based ENV Vars
    XDG_CACHE_HOME=$DATA_DIR/.cache \
    UV_PROJECT_ENVIRONMENT=$DATA_DIR/venv \
    UV_CACHE_DIR=$DATA_DIR/uv_cache


WORKDIR $APP_DIR


# -----------------------------------------------------------------
FROM builder AS staging

ARG \
    PORT \
    GRADIO_SERVER_NAME

ENV \
    # App
    PORT=$PORT \
    GRADIO_SERVER_NAME=$GRADIO_SERVER_NAME \
    GRADIO_ANALYTICS_ENABLED=False

COPY $SOURCE_DIR_NAME/ .
COPY entrypoint.sh .
COPY entrypoint.py .

EXPOSE $PORT

VOLUME $DATA_DIR

ENTRYPOINT []
CMD /bin/bash


# -----------------------------------------------------------------
FROM staging AS dev

RUN apt-get update \
    && apt-get install --no-install-recommends -y git curl htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT []
CMD /bin/bash


# -----------------------------------------------------------------
FROM staging AS production

LABEL maintainer="ALERT <alexey.rubasheff@gmail.com>"

HEALTHCHECK --interval=15s --timeout=5s --start-period=600s --retries=5 \
    CMD python -c "import sys, http.client; c=http.client.HTTPConnection('localhost', $PORT, timeout=5); c.request('HEAD', '/'); r=c.getresponse(); sys.exit(0 if r.status==200 else 1)"

ENTRYPOINT []
# CMD ["sleep", "infinity"]
CMD ./entrypoint.sh
