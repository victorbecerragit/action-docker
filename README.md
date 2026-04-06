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
Last updated: 2026-04-06 (UTC)

- [Official CVE Feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/) — FEATURE STATE: Kubernetes v1.27 \[beta\] This is a community maintained list of official CVEs announced by the Kubernetes Security Response Committee.
- [\[4-1\] CVE details on Kubernetes](https://www.cvedetails.com/vulnerability-list/vendor_id-15867/product_id-34016/Kubernetes-Kubernetes.html) — No information is available for this page.
- [Kubernetes Security in 2026: Risks, Rewards & Resilience ...](https://n2ws.com/blog/kubernetes-security) — Vulnerabilities in ingress controllers, storage solutions, or monitoring tools can be exploited to gain unauthorized access or disrupt ...
- [Kubernetes CVEs and Security Vulnerabilities - OpenCVE](https://app.opencve.io/cve/?vendor=kubernetes) — Explore the latest vulnerabilities and security issues of Kubernetes in the CVE database.
- [Kubernetes Security Vulnerabilities: A Comprehensive Guide](https://kubegrade.com/kubernetes-security-vulnerabilities/) — Understand common Kubernetes security vulnerabilities, how to identify them, and best practices for mitigation to protect your cluster.
- [Top 10 Kubernetes Security Issues](https://www.sentinelone.com/cybersecurity-101/cloud-security/kubernetes-security-issues/) — Some notable Kubernetes vulnerabilities that have been discovered in recent years include: CVE-2018-1002105: A critical flaw in the Kubernetes ...
- [CVE Kubernetes Vulnerability Database - ARMO](https://www.armosec.io/cve-vulnerability-database/) — 3 new NGINX ingress controller vulnerabilities. CVE-2023-5043, CVE-2023-5044 and CVE-2022-4886. Oct 27, 2023 - Three security issues were reported by the ...
- [The Top 5 Kubernetes CVEs of 2024: Have You Patched ...](https://www.fairwinds.com/blog/the-top-5-high-critical-kubernetes-cves-of-2024-have-you-patched-them-yet) — First disclosed on March 29, 2024, CVE-2024-3094 was last modified on November 21, 2024 and reported by Red Hat, Inc. The base score for this ...
- [K10-vulnerable-components.md](https://github.com/OWASP/www-project-kubernetes-top-ten/blob/main/2022/en/src/K10-vulnerable-components.md) — ArgoCD has had a few CVEs over the years including CVE-2022-24348 which allows malicious actors to load a malicious Kubernetes Helm Chart (YAML). ArgoCD runs ..
- [Security bulletins | Google Kubernetes Engine (GKE)](https://docs.cloud.google.com/kubernetes-engine/security-bulletins) — The Kubernetes project recently announced a new security vulnerability, CVE-2021-25735, that could allow node updates to bypass a Validating Admission ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
