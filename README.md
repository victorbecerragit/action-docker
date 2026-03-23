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
Last updated: 2026-03-23 (UTC)

- [Official CVE Feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/) — FEATURE STATE: Kubernetes v1.27 \[beta\] This is a community maintained list of official CVEs announced by the Kubernetes Security Response Committee.
- [Kubernetes Kubernetes security vulnerabilities, ...](https://www.cvedetails.com/product/34016/Kubernetes-Kubernetes.html?vendor_id=15867) — This page lists vulnerability statistics for all versions of Kubernetes » Kubernetes. Vulnerability statistics provide a quick overview for security ...
- [Kubernetes CVEs and Security Vulnerabilities - OpenCVE](https://app.opencve.io/cve/?vendor=kubernetes) — Explore the latest vulnerabilities and security issues of Kubernetes in the CVE database.
- [kubernetes vulnerabilities](https://security.snyk.io/package/linux/debian%3A11/kubernetes) — Fix vulnerabilities automatically ; H · CVE-2022-3294. <1.20.5+really1.20.2-1 ; M · Directory Traversal. <1.20.5+really1.20.2-1 ; H · Server-Side Request For
- [Security bulletins | Google Kubernetes Engine (GKE)](https://docs.cloud.google.com/kubernetes-engine/security-bulletins) — The Kubernetes project recently announced a new security vulnerability, CVE-2021-25735, that could allow node updates to bypass a Validating Admission ...
- [Top 10 Kubernetes Security Issues](https://www.sentinelone.com/cybersecurity-101/cloud-security/kubernetes-security-issues/) — Some notable Kubernetes vulnerabilities that have been discovered in recent years include: CVE-2018-1002105: A critical flaw in the Kubernetes ...
- [Latest Kubernetes Vulnerabilities](https://feedly.com/cve/vendors/kubernetes) — Track the latest Kubernetes vulnerabilities and their associated exploits, patches, CVSS and EPSS scores, proof of concept, links to malware, threat actors, ...
- [Hidden Vulnerabilities In Kubernetes Clusters](https://accuknox.com/blog/kubernetes-clusters-hidden-vulnerabilities) — TL;DR. CNAPPs miss Kubernetes-specific risks like RBAC misconfigurations, weak network policies, and insecure secrets.
- [2022 Kubernetes Vulnerabilities – Main Takeaways - ARMO](https://www.armosec.io/blog/kubernetes-vulnerabilities-2022/) — All the main K8s vulnerabilities from 2022 consolidated into one article. Put together by Ben Hirschberg, CTO & co-founder of ARMO, the makers of Kubescape.
- [Security bulletins for Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/security-bulletins/overview) — The bulletin provides an update regarding the recent vulnerabilities (CVE-2025-31133, CVE-2025-52565, CVE-2025-52881) disclosed from runc.
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
