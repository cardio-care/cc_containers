FROM python:3.11-slim-bookworm

LABEL version="1.1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-11-jdk=11.0.31+11-1~deb11u1 \
        g++=4:12.2.0-3 \
        python3-pip=23.0.1+dfsg-1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN python3.11 -m pip install --no-cache-dir hail==0.2.138

RUN groupadd -r app --gid 1001 \
    && useradd -r -g app -m --uid 1001 app

USER app
