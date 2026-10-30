FROM hailgenetics/hail:0.2.138-py3.13

LABEL version="0.2.138"

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential g++ make \
    && pip install --no-cache-dir gnomad igraph loguru onnx \
    && rm -rf /var/lib/apt/lists/* \
    && useradd app

USER app
