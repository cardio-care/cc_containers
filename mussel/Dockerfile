
FROM rocker/r-ver:4.6.1
 
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential=12.12  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends gfortran=4:15.2.0-5  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   libopenblas-dev=0.3.33+ds-3  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   liblapack-dev=3.12.1-7  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   libcurl4-openssl-dev=8.21.0~rc3-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   libssl-dev=3.6.3-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   libxml2-dev=2.15.3+dfsg-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends   libgit2-dev=1.9.4+ds-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  libssh2-1-dev=1.11.1-4  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  ca-certificates=20260601  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  git=1:2.53.0-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  libicu-dev=78.3-2  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  tzdata=2026b-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  locales=2.42-17  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  zlib1g-dev=1:1.3.dfsg+really1.3.2-3  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  libbz2-dev=1.0.8-6  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  liblzma-dev=5.8.3-1  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  perl=5.40.1-8  \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y --no-install-recommends  uuid-dev=2.42.2-1 \
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

