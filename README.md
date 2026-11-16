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
Last updated: 2026-11-16 (UTC)

- [Kubernetes Security, K8s Vulnerability ...](https://www.youtube.com/watch?v=SphkLePChSU) — This Kubernetes Security webinar is designed for security professionals, network administrators, CIOs, CTOs, and CISOs.
- [Kubernetes NodeRestriction Flaw Lets Nodes Bypass ...](https://gbhackers.com/kubernetes-noderestriction-flaw/) — A critical security vulnerability (CVE-2025-4563) in Kubernetes allows nodes to bypass authorization checks for dynamic resource allocation.
- [Common Kubernetes security vulnerabilities](https://www.facebook.com/groups/itsaboutcloud/posts/1693463584329141/) — There are numerous ways to exploit poorly configured Kubernetes clusters. Malicious users might run crypto miners there and steal cloud ...
- [CVEs in kubernetes kubernetes](https://www.threatfusionai.com/vulnerabilities/kubernetes/kubernetes/cves/) — Kubernetes version 1.5.0-1.5.4 is vulnerable to a privilege escalation in the PodSecurityPolicy admission plugin. CVE-2026-13019 Missing Authentication. CVE- ..
- [Kubernetes Release Notes and CVE Monitoring](https://pagecrawl.io/blog/kubernetes-release-notes-cve-monitoring) — Track Kubernetes releases, CHANGELOGs, and the official CVE feed so upstream patches, EOL dates, and security advisories reach your team the ...
- [Echo: k8s.io/kubernetes: security update to 1.3.0](https://www.tenable.com/plugins/cloud-security/465544) — A security issue was discovered in Kubernetes where a malicious or compromised pod could bypass network restrictions enforced by network ...
- [All versions of Kubernetes found to be at risk of attack](https://www.techradar.com/news/all-versions-of-kubernetes-found-to-be-at-risk-of-attack) — An unpatched man-in-the-middle (MiTM) vulnerability has been discovered which affects all versions of Kubernetes and can be exploited remotely ...
- [National Vulnerability Database - NVD - Search and Statistics](https://nvd.nist.gov/vuln/search?resultType=records&cpeFilterMode=cpe&cpeName=cpe:2.3:a:kubernetes:kubernetes:1.6.0:alpha0:*:*:*:*:*:*) — CVE-2023-3955 Oct 31, 2023 Kubernetes A security issue was discovered in Kubernetes where a user that can create pods on Windows nodes may be able to escalate .
- [Kubernetes Flaws Let Hackers Jump From Containers to ...](https://gbhackers.com/kubernetes-flaws/) — Kubernetes Flaws Let Hackers Jump From Containers to Cloud Accounts · Stolen Tokens in a Crypto Exchange · React2Shell (CVE‑2025‑55182) · Common ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
