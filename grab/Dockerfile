FROM rocker/tidyverse:4.6.0

LABEL version="1.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error pak

RUN wget --progress=dot:giga https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.95.2-linux-x86_64.zip -O /tmp/gcta.zip \
    && unzip -q /tmp/gcta.zip -d /tmp/gcta_extracted \
    && find /tmp/gcta_extracted -maxdepth 3 \
    && cp /tmp/gcta_extracted/gcta /usr/local/bin/gcta64 \
    && chmod +x /usr/local/bin/gcta64 \
    && rm -rf /tmp/gcta.zip /tmp/gcta_extracted

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R packages
RUN Rscript -e "\
    pak::pkg_install(c( \
        'GRAB@0.2.5', \
        'mvtnorm@1.4-1', \
        'lme4@2.0-1', \
        'ordinal@2025.12-29', \
        'RcppParallel@5.1.11-2', \
        'igraph@2.3.3', \
        'R.utils@2.13.0' \
    )); \
    pak::cache_delete()" 

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER bio

# No default CMD
