# action-docker

This repository demonstrates automated Docker image building and publishing to Docker Hub using GitHub Actions.

## Overview

The project contains multiple containerized services related to Kubernetes authentication and authorization, with automated CI/CD pipelines that build and push Docker images on every push to the `main` branch.

## What This Project Does

### GitHub Actions Automation

A GitHub Actions workflow (`.github/workflows/docker-image.yml`) automatically:

1. **Triggers on code push** to the `main` branch
2. **Sets up Docker Buildx** for multi-platform builds
3. **Authenticates with Docker Hub** using encrypted credentials
4. **Caches Docker layers** to optimize build times
5. **Builds and pushes 7 Docker images** to Docker Hub:
   - `dind` - Docker-in-Docker environment with additional commands
   - `authn-webhook` - Kubernetes authentication webhook service
   - `authz-webhook` - Kubernetes authorization webhook service
   - `directpv-discover` - DirectPV discovery tool
   - `serp-api-python` - Python SERP API service image
   - `serp-api-go` - Go SERP API service image
   - `mcp-scraper` - MCP scraper service image

### Project Components

- **authn-webhook**: A simple HTTP server implementing Kubernetes token-based authentication webhook for the kube-apiserver
- **authz-webhook**: A simple HTTP server implementing Kubernetes authorization webhook for the kube-apiserver
- **dind**: Docker-in-Docker container with extended functionality
- **kubectl-directpv**: DirectPV discovery service for Kubernetes persistent volumes
- **serp-api**: Python-based SERP API service
- **serp-api/go-serp**: Go-based SERP API service
- **mcp-scraper**: MCP scraper service

## How It Works

When you push to `main`:
1. GitHub Actions automatically triggers the workflow
2. Docker images are built using the Dockerfile in each service directory
3. Images are tagged with either fixed versions or `latest`, depending on the service
4. All images are pushed to Docker Hub at `victorbecerra/[service-name]`
5. Build layers are cached to speed up subsequent builds

## Weekly Kube CVE Trends

This section is updated weekly by a GitHub Actions workflow that pulls the latest Kubernetes vulnerability results and writes a short report into the README.

<!-- KUBE_CVEs_START -->
Last updated: 2026-06-29 (UTC)

- [Official CVE Feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/) — Kubernetes API Server JSON/YAML parsing vulnerable to resource exhaustion attack, #83253 · CVE-2019-11250, Bearer tokens are revealed in logs (audit finding TO
- [Kubernetes Security Vulnerabilities | Top Risks](https://www.aikido.dev/blog/kubernetes-security-vulnerabilities) — Learn the most critical Kubernetes security vulnerabilities, common misconfigurations, and why clusters are often exposed by default.
- [Top 10 Kubernetes Security Issues](https://www.sentinelone.com/cybersecurity-101/cloud-security/kubernetes-security-issues/) — Some notable Kubernetes vulnerabilities that have been discovered in recent years include: CVE-2018-1002105: A critical flaw in the Kubernetes ...
- [Vulnerability](https://www.cve.org/CVERecord/SearchResults?query=kubernetes) — Common vulnerabilities and Exposures (CVE). We're sorry but the CVE Website doesn't work properly without JavaScript enabled. Please enable it to continue.
- [Understanding Current Threats to Kubernetes Environments](https://unit42.paloaltonetworks.com/modern-kubernetes-threats/) — In the recent exploitation of React2Shell (CVE-2025-55182), threat actors gained code execution inside containers, including Kubernetes, through ...
- [CVE Kubernetes Vulnerability Database - ARMO](https://www.armosec.io/cve-vulnerability-database/) — 3 new NGINX ingress controller vulnerabilities. CVE-2023-5043, CVE-2023-5044 and CVE-2022-4886. Oct 27, 2023 - Three security issues were reported by the ...
- [The Top 5 Kubernetes CVEs of 2024: Have You Patched ...](https://www.fairwinds.com/blog/the-top-5-high-critical-kubernetes-cves-of-2024-have-you-patched-them-yet) — First disclosed on March 29, 2024, CVE-2024-3094 was last modified on November 21, 2024 and reported by Red Hat, Inc. The base score for this ...
- [Kubernetes CVEs and Security Vulnerabilities - OpenCVE](https://app.opencve.io/cve/?vendor=kubernetes) — Explore the latest vulnerabilities and security issues of Kubernetes in the CVE database.
- [Unpatchable Vulnerabilities of Kubernetes: CVE-2020-8554](https://securitylabs.datadoghq.com/articles/unpatchable-kubernetes-vulnerabilities-cve-2020-8554/) — The first of our unpatchable four vulnerabilities is CVE-2020-8554, which was originally discovered by Etienne Champetier. This vulnerability ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
