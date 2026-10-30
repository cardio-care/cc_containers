FROM hailgenetics/hail:0.2.138-py3.13

LABEL version="0.2.138"

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential g++ make \
    && pip install --no-cache-dir gnomad==0.9.1 igraph==1.0.0 loguru==0.7.3 onnx==1.23.2 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd app

USER app
