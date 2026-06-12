FROM python:3.11-slim-bullseye

LABEL version="1.1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-11-jdk=11.0.31+11-1~deb11u1 \
        g++=4:10.2.1-1 \
        python3-pip=20.3.4-4+deb11u2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && python3.11 -m pip install --no-cache-dir hail==0.2.138

RUN useradd app
USER app
