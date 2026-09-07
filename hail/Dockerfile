FROM python:3.13-slim-bullseye

LABEL version="0.2.139"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk g++ python3-pip procps  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    python3.13 -m pip install --no-cache-dir hail==0.2.139 && \
    groupadd -r bio --gid 1001 && \
    useradd -r -g bio -m --uid 1001 bio

USER bio
