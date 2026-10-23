FROM rocker/r-ver:4.6.1

LABEL version="2.0.0"

# Install system dependencies and create non-root user
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error pak

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install quarto
RUN wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.10.19/quarto-1.10.19-linux-amd64.tar.gz \
    && tar -C /opt -xzf quarto-1.10.19-linux-amd64.tar.gz \
    && ln -s /opt/quarto-1.10.19/bin/quarto /usr/local/bin/quarto \
    && rm quarto-1.10.19-linux-amd64.tar.gz

# Install R dependencies
RUN Rscript -e "\
    pak::pkg_install(c( \
        'dplyr@1.2.1', \
        'data.table@1.18.6.1', \
        'readr@2.2.0', \
        'stringr@1.6.0', \
        'tidyr@1.3.2', \
        'tibble@3.3.1', \
        'purrr@1.2.2', \
        'rjson@0.2.23', \
        'ggplot2@4.0.3', \
        'DT@0.33', \
        'fastmatch@1.1-8', \
        'fastqq@0.1.3', \
        'kableExtra@1.4.0', \
        'QCEWAS@1.2-3', \
        'plyr@1.8.9', \
        'katex@1.5.0', \
        'calibrate@1.7.7', \
        'flextable@0.9.9', \
        'ontologyIndex@2.12', \
        'cran/manhattanly@0.3.0', \
        'bioc::snpStats', \
        'bioc::SeqArray', \
        'bioc::SNPRelate', \
        'adhikari-statgen-lab/fastman', \
        'seqminer@9.9', \
        'DescTools@0.99.60', \
        'optparse@1.8.2' \
    )); \
    pak::cache_delete()" 

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

# Switch to non-root user
USER bio

# No default CMD