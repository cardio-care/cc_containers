FROM python:3.12-slim

LABEL version="4.1.6-1"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        procps=2:4.0.4-9 && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r appuser \
    && useradd --create-home -r -g appuser appuser

RUN pip install --no-cache-dir gwaslab==4.1.6

WORKDIR /app

LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

# Set ownership and switch to non-root user
RUN chown -R appuser:appuser /app
USER appuser

