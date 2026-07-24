# Stage 1: build scanpy and all Python dependencies
FROM python:3.12-slim-bookworm AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         gcc g++ make \
         git \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
WORKDIR /app
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install scanpy
RUN pip install --no-cache-dir 'scanpy[leiden]==1.12.2' scvi-tools==1.5.0 typer==0.27.0 loguru==0.7.3 

# Stage 2: minimal runtime image
FROM python:3.12-slim-bookworm

LABEL version="1.0.0"

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

# Set cache directories for Numba & Matplotlib
ENV TMPDIR=/tmp
ENV NUMBA_CACHE_DIR=/tmp
ENV MPLCONFIGDIR=/tmp
