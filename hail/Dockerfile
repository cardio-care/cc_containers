FROM python:3.11-slim-bullseye

LABEL version="0.2.139"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk g++ python3-pip ps  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    python3.11 -m pip install --no-cache-dir hail==0.2.139 && \
    groupadd -r bio --gid 1001 && \
    useradd -r -g bio -m --uid 1001 bio

USER bio
