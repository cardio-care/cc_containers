FROM python:3.11-slim-bookworm

LABEL version="1.1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-11-jdk \
        g++ \
        python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \

RUN python3.11 -m pip install --no-cache-dir hail==0.2.138

RUN groupadd -r app --gid 1001 \
    && useradd -r -g app -m --uid 1001 app

USER app
