
FROM bioconductor/bioconductor_docker:3.21-R-4.5.1

ENV R_LIBS_SITE=/usr/local/lib/R/site-library

LABEL version="1.0.0"

RUN R_LIBS_SITE=/usr/local/lib/R/site-library

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        curl libcurl4-openssl-dev ca-certificates libssl-dev \
        texlive-latex-base \
    && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error pak

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Site library setup
RUN mkdir -p /usr/local/lib/R/site-library \
    && echo '.Library.site <- "/usr/local/lib/R/site-library"' >> /usr/lib/R/etc/Rprofile.site \
    && echo '.libPaths(c(.Library.site, .libPaths()))' >> /usr/lib/R/etc/Rprofile.site

# Install R dependencies
RUN Rscript -e "\
    pak::pkg_install(c( \
        'optparse@1.7.5', \
        'roxygen2@7.3.2', \
        'data.table@1.17.8', \
        'rmarkdown@2.29', \
        'spelling@2.3.1', \
        'testthat@3.2.3', \
        'assertthat@0.2.1', \
        'dplyr@1.1.4', \
        'knitr@1.50', \
        'purrr@1.1.0', \
        'rlang@1.1.6', \
        'stringr@1.5.1', \
        'tibble@3.3.0', \
        'tidyr@1.3.1', \
        'tidyselect@1.2.1', \
        'usethis@3.1.0', \
        'BiocManager@1.30.26', \
        'readr@2.1.5', \
        'bioc::SeqArray', \
        'bioc::S4Vectors', \
        'bioc::IRanges', \
        'bioc::GenomicRanges', \
        'bioc::GenomicFeatures', \
        'bioc::GenomeInfoDb', \
        'bioc::TxDb.Hsapiens.UCSC.hg38.knownGene' \
    )); \
    pak::cache_delete()" 

# Copy and install taro (placed last so earlier layers stay cached when source changes)
COPY . /opt/taro

WORKDIR /tmp
RUN PKG_VERSION=$(sed -n 's/^Version: *//p' /opt/taro/DESCRIPTION) \
    && R CMD build /opt/taro \
    && Rscript -e "install.packages(paste0('taro_', '$PKG_VERSION', '.tar.gz'), repos = NULL, type = 'source', lib='/usr/local/lib/R/site-library')" \
    && rm -f /tmp/taro_*.tar.gz

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER bio
WORKDIR /home/bio

# No default CMD
