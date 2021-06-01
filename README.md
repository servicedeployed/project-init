# Service Deployed Project Downloader

Project & YAML Cluster Initialization Retriever

This repo contains our project retriever Docker Image. The purpose of this image is to fetch initialization files from various sources. The following sources are supported:

- Direct YAML URL
- GitHub Public Repository via HTTPS
- GitHub Private Repository via HTTPS
- GitLab.com Public Repository via HTTPS
- GitLab.com Private Repository via HTTPS

## Docker Hub

[Direct Link to Docker Hub](https://hub.docker.com/r/innovoedge/project-init)

## Overview

This image takes up to 2 ENV Variables, `URL` & `OAUTH_TOKEN`. `OAUTH_TOKEN` is only needed for private GitHub or GitLab.com repositories. The YAML or Git repo will be initialized to `/project` for future use on other initialization steps.

## Examples

- `docker run -e URL="https://github.com/servicedeployed/super-secret-repo.git" -e OAUTH_TOKEN="$GITHUB_TOKEN" innovoedge/project-init`
  - Use a private GitHub Repository
- `docker run -e URL="https://github.com/servicedeployed/public-repo.git" innovoedge/project-init`
  - Use a public GitHub Repository
- `docker run -e URL="https://github.com/jetstack/cert-manager/releases/download/v1.3.0/cert-manager.yaml" innovoedge/project-init`
  - Initialize with Cert-Manager's Installation YAML URL

## Response

This image will either exit with `1` for a successful download, or `0` for an invalid URL or download error.