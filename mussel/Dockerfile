
FROM rocker/r-ver:4.6.1
 
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev=1.9.4+ds-1 \
    libssh2-1-dev \
    ca-certificates \
    git \
    libicu-dev \
    tzdata \
    locales \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    perl \
    uuid-dev \
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

ENV MUSSEL_HOME=/opt/MUSSEL
RUN git clone --depth 1 https://github.com/Jin93/MUSSEL.git ${MUSSEL_HOME} \
    && chmod +x ${MUSSEL_HOME}/R/*.R
 
WORKDIR ${MUSSEL_HOME} 

# Switch to non-root user
USER bio

# No default CMD

