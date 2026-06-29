FROM rocker/tidyverse:4.6.0

LABEL version="1.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    && apt-get clean \
    && apt-get install -y \
	cmake=3.28.3-1build7 \
	openjdk-11-jdk=11.0.31+11-1ubuntu1~24.04.2 \
	liblzma-dev=5.6.1+really5.4.5-1ubuntu0.3 \
	libbz2-dev=1.0.8-5.1build0.1 \
	--no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Switch to non-root user
USER bio

# No default CMD
