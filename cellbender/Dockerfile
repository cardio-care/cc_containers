# Stage 1: build CellBender and all Python dependencies
FROM python:3.12-slim-bookworm AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         gcc g++ make \
         git curl gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    git+https://github.com/broadinstitute/CellBender@c5f5d9f41a2926a0b46515ccc4a3383d52a9ffa9

# Stage 2: minimal runtime image
FROM python:3.12-slim-bookworm

LABEL version="1.0.1" \
      org.opencontainers.image.title="CellBender" \
      org.opencontainers.image.description="Remove technical artifacts from single-cell RNA-seq data" \
      org.opencontainers.image.source="https://github.com/broadinstitute/CellBender"

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         libcurl4t64 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home app

USER app
WORKDIR /data
ENTRYPOINT ["cellbender"]

