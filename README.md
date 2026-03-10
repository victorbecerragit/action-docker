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
5. **Builds and pushes 6 Docker images** to Docker Hub:
   - `dind` - Docker-in-Docker environment with additional commands
   - `authn-webhook` - Kubernetes authentication webhook service
   - `authz-webhook` - Kubernetes authorization webhook service
   - `directpv-discover` - DirectPV discovery tool
   - `serp-api-python` - Python SERP API service image
   - `serp-api-go` - Go SERP API service image

### Project Components

- **authn-webhook**: A simple HTTP server implementing Kubernetes token-based authentication webhook for the kube-apiserver
- **authz-webhook**: A simple HTTP server implementing Kubernetes authorization webhook for the kube-apiserver
- **dind**: Docker-in-Docker container with extended functionality
- **kubectl-directpv**: DirectPV discovery service for Kubernetes persistent volumes
- **serp-api**: Python-based SERP API service
- **serp-api/go-serp**: Go-based SERP API service

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
Last updated: 2026-03-10 (UTC)

- [Official CVE Feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/) — CVE-2019-11254, kube-apiserver Denial of Service vulnerability from malicious YAML payloads, #89535 ; CVE-2020-8552, apiserver DoS (oom), #89378 ; CVE-2020-8551
- [Kubernetes CVEs and Security Vulnerabilities - OpenCVE](https://app.opencve.io/cve/?vendor=kubernetes) — Explore the latest vulnerabilities and security issues of Kubernetes in the CVE database.
- [Security bulletins | Google Kubernetes Engine (GKE)](https://docs.cloud.google.com/kubernetes-engine/security-bulletins) — The Kubernetes project recently announced a new security vulnerability, CVE-2021-25735, that could allow node updates to bypass a Validating Admission ...
- [OWASP Kubernetes Top Ten](https://owasp.org/www-project-kubernetes-top-ten/) — Draft Top 10 Kubernetes Risks - 2025 · K01: Insecure Workload Configurations · K02: Overly Permissive Authorization Configurations · K03: Secrets Management
- [Top 10 Kubernetes Security Issues](https://www.sentinelone.com/cybersecurity-101/cloud-security/kubernetes-security-issues/) — Some notable Kubernetes vulnerabilities that have been discovered in recent years include: CVE-2018-1002105: A critical flaw in the Kubernetes ...
- [Kubernetes and AI Workloads Under Attack By VoidLink ...](https://cyberpress.org/voidlink-malware-targets-kubernetes/) — In December 2025, Check Point Research disclosed a troubling new threat: VoidLink, a sophisticated malware framework designed to target cloud ...
- [Latest Kubernetes Vulnerabilities](https://feedly.com/cve/vendors/kubernetes) — Track the latest Kubernetes vulnerabilities and their associated exploits, patches, CVSS and EPSS scores, proof of concept, links to malware, threat actors, ...
- [CVE Kubernetes Vulnerability Database - ARMO](https://www.armosec.io/cve-vulnerability-database/) — 3 new NGINX ingress controller vulnerabilities. CVE-2023-5043, CVE-2023-5044 and CVE-2022-4886. Oct 27, 2023 - Three security issues were reported by the ...
- [Kubernetes Ingress-NGINX Controller vulnerabilities](https://www.runzero.com/blog/k8s-ingress-nginx-controller/) — Three of the vulnerabilities relate to validation and sanitation of user-controlled fields (CVE-2026-24512, CVE-2026-24513, and ...
<!-- KUBE_CVEs_END -->

## Learning Context

These components are based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows.
