FROM python:3.13-slim-trixie

LABEL version="0.2.139"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl g++ python3-pip procps && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public -o /etc/apt/keyrings/adoptium.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb trixie main" > /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends temurin-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    python3.13 -m pip install --no-cache-dir hail==0.2.139 && \
    groupadd -r bio --gid 1001 && \
    useradd -r -g bio -m --uid 1001 bio

USER bio
