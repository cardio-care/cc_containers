# Base image
FROM rocker/r-ver:4.6.1

LABEL version="1.0.0"

# Set the working directory
WORKDIR /app

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install dependencies
RUN  install2.r --error pak \
    && Rscript -e "\
    pak::pkg_install(c( \
        'seqminer@9.9', \
        'survival@3.8-12', \
        'dplyr@1.2.1', \
        'data.table@1.18.6.1', \
        'readr@2.2.0', \
        'stringr@1.6.0', \
        'tidyr@1.3.2', \
        'tibble@3.3.1', \
        'purrr@1.2.2', \
        'nanonext@1.7.2', \
        'mirai@2.5.3', \
        'future@1.69.0', \
        'future.apply@1.11.2', \
        'future.mirai@0.10.1', \
        'listenv@0.10.0', \
        'optparse@1.7.5', \
        'RhpcBLASctl@0.23-42' \
    )); \
    pak::cache_delete()" \
    && rm -rf /tmp/downloaded_packages

LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

# Switch to non-root user
USER bio
