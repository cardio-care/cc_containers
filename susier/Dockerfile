FROM rocker/r-ver:4.6.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    procps \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error pak

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R dependencies
RUN Rscript -e "\
    pak::pkg_install(c( \
        'argparse@2.3.1', \
        'dplyr@1.2.1', \
        'data.table@1.18.4', \
        'susieR@0.16.0' \
    )); \
    pak::cache_delete()" 

# Switch to non-root user
USER bio

# No default CMD
