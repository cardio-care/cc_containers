# Stage 1: build CellBender and all Python dependencies
FROM python:3.12-slim-bookworm AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         gcc g++ make \
         git curl gnupg \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
WORKDIR /app
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Cellbender
RUN pip install --no-cache-dir \
    git+https://github.com/broadinstitute/CellBender@c5f5d9f41a2926a0b46515ccc4a3383d52a9ffa9

# Stage 2: minimal runtime image
FROM python:3.12-slim-bookworm

LABEL version="1.0.1"

# Create non-root user
RUN groupadd -r appuser \
    && useradd --create-home -r -g appuser appuser

# Copy virtual environment from builder
COPY --from=builder /venv /venv
ENV PATH="/venv/bin:$PATH"

WORKDIR /app

# Set ownership and switch to non-root user
RUN chown -R appuser:appuser /app
USER appuser
ENV PATH="/venv/bin:$PATH"
