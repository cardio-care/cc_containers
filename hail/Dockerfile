FROM python:3.11-slim-bullseye

LABEL version="0.2.139"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk g++ python3-pip ps  && \
    python3.11 -m pip install hail==0.2.139 && \
    useradd app

USER app
