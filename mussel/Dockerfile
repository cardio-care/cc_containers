
FROM rocker/r-ver:4.6.1
 
LABEL version="1.0.0"
 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential=12.10ubuntu1 \
    libcurl4-openssl-dev=8.5.0-2ubuntu10.9 \
    libssl-dev=3.0.13-0ubuntu3.11 \
    libxml2-dev=2.9.14+dfsg-1.3ubuntu3.8 \
    libgit2-dev=1.7.2+ds-1ubuntu3 \
    libssh2-1-dev=1.11.0-4.1ubuntu0.24.04.1 \
    git=1:2.43.0-1ubuntu7.3 \
    libicu-dev=74.2-1ubuntu3.1 \
    zlib1g-dev=1:1.3.dfsg-3.1ubuntu2.1 \
    libbz2-dev=1.0.8-5.1build0.1 \
    liblzma-dev=5.6.1+really5.4.5-1ubuntu0.3 \
    uuid-dev=2.39.3-9ubuntu6.5 \
    && rm -rf /var/lib/apt/lists/* \
    &&  install2.r --error pak


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
        'Rcpp@1.1.1-1.1', \
        'RcppArmadillo@15.4.0-1', \
        'RcppTN@0.2-2', \
        'readr@2.2.0', \
        'remotes@2.5.0', \
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
    && chmod +x ${MUSSEL_HOME}/R/*.R \
    && sed -i 's/pryr/rlang/g' ${MUSSEL_HOME}/R/*.R
 
WORKDIR ${MUSSEL_HOME} 
RUN rm /usr/local/lib/R/site-library/openssl/doc/keys.html

# Switch to non-root user
USER bio

# No default CMD

