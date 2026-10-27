FROM rocker/r-ver:4.6.1

LABEL version="2.0.0"

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R dependencies
RUN install2.r --error pak \
    && Rscript -e "\
    pak::pkg_install(c( \
        'dplyr@1.2.1', \
        'data.table@1.18.6.1', \
        'readr@2.2.0', \
        'stringr@1.6.0', \
        'tidyr@1.3.2', \
        'tibble@3.3.1', \
        'purrr@1.2.2', \
        'fastmatch@1.1-8', \
        'optparse@1.8.2' \
    )); \
    pak::cache_delete()"

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

# Switch to non-root user
USER bio

# No default CMD
