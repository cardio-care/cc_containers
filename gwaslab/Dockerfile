FROM python:3.12-slim

LABEL version="4.1.6"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        procps=2:4.0.4-9 && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r appuser \
    && useradd --create-home -r -g appuser appuser

RUN pip install --no-cache-dir gwaslab==4.1.6

WORKDIR /app

# Set ownership and switch to non-root user
RUN chown -R appuser:appuser /app
USER appuser
