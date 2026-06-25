
FROM rocker/r-ver:4.6.1
 
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential=12.12 \
    gfortran=4:15.2.0-5 \
    libopenblas-dev=0.3.33+ds-3 \
    liblapack-dev=3.12.1-7 \
    libcurl4-openssl-dev=8.21.0~rc3-1 \
    libssl-dev=3.6.3-1 \
    libxml2-dev=2.15.3+dfsg-1 \
    libgit2-dev=1.9.4+ds-1 \
    libssh2-1-dev=1.11.1-4 \
    ca-certificates=20260601 \
    git=1:2.53.0-1 \
    libicu-dev=78.3-2 \
    tzdata=2026b-1 \
    locales=2.42-17 \
    zlib1g-dev=1:1.3.dfsg+really1.3.2-3 \
    libbz2-dev=1.0.8-6 \
    liblzma-dev=5.8.3-1 \
    perl=5.40.1-8 \
    uuid-dev=2.42.2-1 \
    && rm -rf /var/lib/apt/lists/*
 RUN install2.r --error pak


# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Install R dependencies
RUN Rscript -e "\
    pak::pkg_install(c( \
        'bigmemory@4.6.6', \
        'bigparallelr@0.3.2', \
        'bigreadr@0.2.5', \
        'bigsnpr@1.12.21', \
        'caret@7.0-1', \
        'corpcor@1.6.10', \
        'data.table@1.18.4', \
        'DescTools@0.99.60', \
        'devtools@2.5.2', \
        'doMC@1.3.8', \
        'doParallel@1.0.17', \
        'dplyr@1.2.1', \
        'foreach@1.5.2', \
        'gdata@3.0.1', \
        'genio@1.1.2', \
        'inline@0.3.21', \
        'lavaan@0.6-21', \
        'MASS@7.3-65', \
        'Matrix@1.7-5', \
        'mvnfast@0.2.8', \
        'optparse@1.8.2', \
        'parallel@3.6.2', \
        'pROC@1.19.0.1', \
        'pryr@0.1.6', \
        'Rcpp@1.1.1-1.1', \
        'RcppArmadillo@15.4.0-1', \
        'RcppTN@0.2-2', \
        'readr@2.2.0', \
        'reshape@0.8.10', \
        'RISCA@1.0.7', \
        'R.utils@2.13.0', \
        'stringr@1.6.0', \
        'SuperLearner@2.0-40', \
        'xtable@1.8-8' \
    )); \
    pak::cache_delete()" 

# Switch to non-root user
USER bio

# No default CMD

