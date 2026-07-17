FROM python:3.12-slim

LABEL version="1.0.0"

RUN apt-get update \
    && apt-get install -y --no-install-recommends git curl gnupg \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove \
    && apt-get clean \
    && useradd app

USER app
WORKDIR /home/app
ENV PATH=".local/bin:$PATH"
RUN python3.12 -m pip install --no-cache-dir git+https://github.com/broadinstitute/CellBender@c5f5d9f41a2926a0b46515ccc4a3383d52a9ffa9
