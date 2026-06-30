FROM rocker/tidyverse:4.6.0

LABEL version="1.0.0"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    && apt-get clean \
    && apt-get install -y \
	cmake \
	openjdk-11-jdk \
	liblzma-dev \
	libbz2-dev \
	--no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Switch to non-root user
USER bio

# No default CMD
