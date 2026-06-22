FROM rocker/tidyverse:4.5.1

LABEL version="1.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y cmake=4.2.3 --no-install-recommends  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pak and renv R packages
RUN install2.r --error pak renv

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Initialize application project directory
WORKDIR /project
RUN mkdir -p renv

# Copy renv infrastructure
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# Restore R project library
RUN R -s -e "renv::restore()"

RUN apt-get purge -y linux-libc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER bio

# No default CMD
