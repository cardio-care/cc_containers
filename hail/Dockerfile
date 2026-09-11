FROM python:3.13-slim-bullseye

LABEL version="1.0.0"

RUN apt-get update && apt-get install -y --no-install-recommends openjdk-11-jdk g++ python3-pip
RUN python3.11 -m pip install hail==0.2.138

RUN useradd app
USER app
