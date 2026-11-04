[![Docker build](https://github.com/cardio-care/cc_containers/actions/workflows/build-containers.yml/badge.svg)](https://github.com/cardio-care/cc_containers/actions/workflows/build-containers.yml)

# Docker Containers

This repository contains Docker containers for various bioinformatics and data science applications.

## CI/CD Rules

-   Only one Dockerfile can be changed per pull request
-   Containers must be structured as `container_name/Dockerfile`
-   The version of the Dockerfile needs to be specified in the Dockerfile with `LABEL version="1.0.0"`
-   The CI workflow automatically builds and publishes Docker images to GHCR
-   Images are tagged with both a timestamped version (for development/working versions) and `latest` (for the most recent release)
-   The base version (without timestamp) represents official releases

## License Rules

The images in this repo are aggregates of components with different licenses. 

For an example with full license documentation see `grab/`

### Files and folders to include for each image
1. `LICENSE` 
   - Each folder contains a license which covers the Dockerfile and any custom scripts
   - Dockerfiles are recipes and do not need to cover the software in the container image so can be MIT
   - Custom scripts written by you can also be MIT
   - If you have modified code from an external source in `patches/` then use this to describe the license of the different parts of the repo instead
2. `patches/` 
   - Scripts modified from a GPL or similar free software license 
   - Include the original copyright lines that were in the script, a description of the changes, and a new copyright line at the top of the script (keep the same license type and mention Cardio-CARE + year)
   - Include all licenses used in `licenses/`. In `LICENSE` write a description of which license applies to what parts of the repo 
3. `THIRD_PARTY_LICENSES.md` 
   - A general license notice and a table of primary software components that will be installed in the container image with a link to their website and their license
   - Include the base image, primary software (R, Python), and packages or software that are important to the analysis. 
4. `licenses/` 
   - Software with a license type that is not already stored in the base image license list
   - Copy the license files into the image in `/usr/share/common-licenses/`
5. `Dockerfile` 
   - Include a license for the released image and description
   - Because the base image contains GPL and other copyleft software, the relevant license will generally be `GPL-2.0-or-later`
   ```bash
   LABEL org.opencontainers.image.description="Contains third-party software under multiple licenses; for full software license info see the SBOM attached to the release of the same tag and /usr/share/licenses/" \
    org.opencontainers.image.licenses="GPL-2.0-or-later"
   ```

### Other steps to take
1. **Verify license of base image**
    - Use a popular well established base image
    - Ensure that the image has a free license
    - Check that licenses and docs have not been removed from the base image
   ```bash
    ls /usr/share/common-licenses/ | head
    ls /usr/share/doc | head
   ```
    - You can directly check the licenses of software in the base image, but this is not necessary
   ```bash
   grep -h '^License:' /usr/share/doc/*/copyright | sort -i | uniq -ic 
   Rscript -e 'ip <- installed.packages(fields="License"); write.table(ip[,c("Package","Version","License")], sep="\t", quote=FALSE, row.names=FALSE)' | awk '{$1=$2=""; print $0}' |sort |uniq
   ```
2. **Manually installed software** 
    - Anything done with `wget`, `git clone`, `COPY`, etc
    - Add its license text or notice to `licenses/` if it's not already there
    - Include in the table in `THIRD_PARTY_LICENSES.md`.
3.  **Check license combinations** 
   - Look for GPL-2-only and GPL-3-only code together in the same script
   - Split into separate processes if possible
4.  **SBOM**
   - The GitHub CI attaches an SBOM JSON wich describes in detail all software components
   - This is an automatic step which does not capture manually installed software
