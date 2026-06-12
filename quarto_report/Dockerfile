FROM rocker/tidyverse:4.6.0

LABEL version="1.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    && apt-get clean
RUN install2.r --error pak

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R dependencies
RUN Rscript -e "\
    pak::pkg_install(c( \
        'rjson@0.2.23', \
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
        'adhikari-statgen-lab/fastman' \
    )); \
    pak::cache_delete()" 

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER bio

# No default CMD