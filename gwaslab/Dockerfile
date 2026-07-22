FROM python:3.12-slim

LABEL version="1.0.0"

# Create non-root user
RUN groupadd -r appuser \
    && useradd --create-home -r -g appuser appuser

RUN pip install --no-cache-dir numpy==2.5.0 pandas==3.0.4 gwaslab==4.0.2

WORKDIR /app

# Set ownership and switch to non-root user
RUN chown -R appuser:appuser /app
USER appuser
