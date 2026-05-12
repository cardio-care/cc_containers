# Docker Containers

This repository contains Docker containers for various bioinformatics and data science applications.

## CI/CD Rules

-   Only one Dockerfile can be changed per pull request
-   Containers must be structured as `container_name/Dockerfile`
-   The version of the Dockerfile needs to be specified in the Dockerfile with `LABEL version="1.0.0"`
-   The CI workflow automatically builds and publishes Docker images to GHCR
-   Images are tagged with both a timestamped version (for development/working versions) and `latest` (for the most recent release)
-   The base version (without timestamp) represents official releases
