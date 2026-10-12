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
Last updated: 2026-10-12 (UTC)

- [Kubernetes Vulnerability Scanning: Best Practices and Tools](https://www.sentinelone.com/cybersecurity-101/cloud-security/kubernetes-vulnerability-scanning/) — In just 5 years, from 2018 to 2023, the number of vulnerabilities in Kubernetes has increased by 440%.
- [Kubernetes security advisory (AV25-161) - Update 1](https://www.cyber.gc.ca/en/alerts-advisories/kubernetes-security-advisory-av25-161) — On March 24, 2025, Kubernetes published a security advisory to address critical vulnerabilities in the following product: Kubernetes ingress ...
- [Kubernetes IngressNightmare Vulnerabilities](https://www.crowdstrike.com/en-us/blog/kubernetes-ingressnightmare-vulnerabilities-key-details/) — On March 24, 2025, security researchers1 disclosed several new vulnerabilities in ingress-nginx, a highly popular Kubernetes ingress controller ...
- [An Unfixed Kubernetes Man-in-the-Middle Vulnerability ...](https://unit42.paloaltonetworks.com/cve-2020-8554/) — CVE-2020-8554 is a design flaw that allows Kubernetes Services to intercept cluster traffic to any IP address. Users who can manage services can ...
- [Official CVE Feed](https://v1-32.docs.kubernetes.io/docs/reference/issues-security/official-cve-feed/) — CVE-2019-11254, kube-apiserver Denial of Service vulnerability from malicious YAML payloads, #89535 ; CVE-2020-8552, apiserver DoS (oom), #89378 ; CVE-2020-8551
- [Critical Arbitrary Code Execution Vulnerability Found in ...](https://snyk.io/blog/critical-arbitrary-code-execution-vulnerability-found-in-kubernetes/) — Kubernetes vulnerability identified as CVE-2018-1002105, We suggest the following patched releases: v1.10.11, v1.11.5, v1.12.3, and v1.13.0-rc. ...
- [Kubernetes CVEs and Security Vulnerabilities - OpenCVE](https://app.opencve.io/cve/?page=7&vendor=kubernetes) — Explore the latest vulnerabilities and security issues of Kubernetes in the CVE database. v3.1 CVE-2018-1002104 1 Kubernetes. Low Improper validation of URL ...
- [Top 5 Kubernetes Security Challenges and Best Practices](https://www.mirantis.com/blog/top-5-kubernetes-security-challenges-and-best-practices/)
- [Identifying Security Vulnerabilities in Kubernetes ...](https://www.sans.org/white-papers/identifying-security-vulnerabilities-kubernetes-environments) — This research aims to develop a practical methodology for identifying security misconfigurations in Kubernetes environments, ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
