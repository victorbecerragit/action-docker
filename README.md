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
Last updated: 2026-11-09 (UTC)

- [Comprehensive Guide To Kubernetes Security](https://accuknox.com/blog/kubernetes-vulnerabilities)
- [Official CVE Feed](https://v1-32.docs.kubernetes.io/docs/reference/issues-security/official-cve-feed/) — CVE-2019-11253, Kubernetes API Server JSON/YAML parsing vulnerable to resource exhaustion attack, #83253 ; CVE-2019-11250, Bearer tokens are revealed in logs (
- [kubernetes-1.30 - Vulnerability](https://security.snyk.io/package/linux/chainguard%3Alatest/kubernetes-1.30) — Direct Vulnerabilities. Known vulnerabilities in the kubernetes-1.30 package. This does not include vulnerabilities belonging to this package's dependencies.
- [7 Critical Kubernetes Security Issues Resolved by ...](https://www.stackrox.io/blog/critical-kubernetes-security-issues-resolved-in-latest-kubernetes-versions/) — In 2018, we learned about several Kubernetes security vulnerabilities, with the latest Kubernetes security flaw being the most severe.
- [Identifying Security Vulnerabilities in Kubernetes ...](https://www.sans.org/white-papers/identifying-security-vulnerabilities-kubernetes-environments) — This research aims to develop a practical methodology for identifying security misconfigurations in Kubernetes environments, ...
- [Kubernetes security vulnerability reveals fractured market](https://www.techtarget.com/news/Kubernetes-security-vulnerability-reveals-fractured-market/867209/) — A critical Kubernetes security vulnerability that was patched this week affects a wide swath of container orchestration users. CVE-2018-1002105 ...
- [Known Exploited Vulnerabilities Catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog) — Known Exploited Vulnerabilities Catalog · CVE-2026-19868 · CVE-2024-27834 · CVE-2026-119977 · CVE-2026-111357 · CVE-2026-118527 · CVE-2026-76418.
- [Top 5 Kubernetes Security Challenges and Best Practices](https://www.mirantis.com/blog/top-5-kubernetes-security-challenges-and-best-practices/)
- [Kubescape is an open-source Kubernetes security platform ...](https://github.com/kubescape/kubescape) — Kubescape is an open-source Kubernetes security platform for your IDE, CI/CD pipelines, and clusters. It includes risk analysis, security, compliance, ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
