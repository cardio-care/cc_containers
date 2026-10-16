FROM rocker/r-ver:4.6.1

LABEL version="2.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error pak

WORKDIR /tmp
RUN wget --progress=dot:giga  --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/120 Safari/537.36" \
        https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.95.4-linux-x86_64.zip -O /tmp/gcta.zip \
    && unzip -q /tmp/gcta.zip -d /tmp/gcta_extracted \
    && cp /tmp/gcta_extracted/gcta-1.95.4-linux-x86_64/gcta64 /tmp/gcta.AppImage \
    && chmod +x /tmp/gcta.AppImage \
    && /tmp/gcta.AppImage --appimage-extract \
    && mv /tmp/squashfs-root /opt/gcta \
    && ln -s /opt/gcta/AppRun /usr/local/bin/gcta64 \
    && rm -rf /tmp/gcta.zip /tmp/gcta_extracted /tmp/gcta.AppImage
WORKDIR /

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R packages
RUN Rscript -e "\
    pak::pkg_install(c( \
        'dplyr@1.2.1', \
        'DBI@1.3.0', \
        'RSQLite@3.53.3', \
        'mvtnorm@1.4-1', \
        'lme4@2.0-1', \
        'ordinal@2025.12-29', \
        'RcppParallel@5.1.11-2', \
        'igraph@2.3.3', \
        'R.utils@2.13.0', \
        'SKAT@2.2.5', \
        'pkgload@1.5.3', \
        'dbplyr@2.5.2', \
        'GRAB@0.2.5', \
        'optparse@1.8.2' \
    )); \
    pak::cache_delete()" 

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/grab
COPY bin/cct_allow_na.R /opt/grab/
COPY bin/LICENSE-Intel-ISSL /usr/share/common-licenses/

LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
      org.opencontainers.image.licenses="GPL-2.0-or-later AND LGPL-2.1-or-later AND AGPL-3.0-only AND MIT AND LicenseRef-Intel-ISSL"

# Switch to non-root user
USER bio

# No default CMD
