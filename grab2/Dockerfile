FROM ubuntu:noble-20260610

LABEL version="2.0.0a6"

# Install system dependencies and create non-root user
RUN apt-get update && apt-get upgrade -y \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget --progress=dot:giga https://github.com/GeneticAnalysisinBiobanks/GRAB/releases/download/v2.0.0a6/grab2-2.0.0a6-linux-x86_64.tar.gz -O /tmp/grab2-2.0.0a6-linux-x86_64.tar.gz \
    && tar -xvzf /tmp/grab2-2.0.0a6-linux-x86_64.tar.gz \
    && mv /tmp/grab2-2.0.0a6-linux-x86_64/grab2 /usr/local/bin/grab2 \
    && rm -rf /tmp/grab2-2.0.0a6-linux-x86_64.tar.gz /tmp/grab2-2.0.0a6-linux-x86_64

# Create non-root user
RUN touch /etc/passwd /etc/group \
    && groupadd -r bio --gid 1001 \
    && useradd -r -g bio -m --uid 1001 bio

# Switch to non-root user
USER bio

# No default CMD