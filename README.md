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
Last updated: 2026-09-28 (UTC)

- [Weekly: Show off your new tools and projects thread](https://www.reddit.com/r/kubernetes/comments/1whswpp/weekly_show_off_your_new_tools_and_projects_thread/) — I am working on a feature now to filter between vulnerabilities in OS/base layer images and the application layer of the image. I belive this ...
- [CVE-2025-5187: Kubernetes Privilege Escalation ...](https://www.sentinelone.com/vulnerability-database/cve-2025-5187/) — CVE-2025-5187 is a privilege escalation vulnerability in Kubernetes. Learn about its impact, affected versions, and mitigation methods.
- [Known Vulnerabilities | Kubernetes Documentation](https://teuto.net/k8s/docs/managed-kubernetes/known-vulnerabilities/) — Description: CVE-2026-43284 and CVE-2026-43500, collectively referred to as “Dirty Frag”, affect Linux kernel networking-related components, including IPsec
- [Vulnerability scans on Kubernetes with Pipeline](https://outshift.cisco.com/blog/in-depth-tech/container-vulnerability-scans) — Over 80% of the latest versions of official images publicly available on Docker Hub contained at least one high severity vulnerability! How ...
- [Kubernetes gatekeeper platform at risk from new flaws](https://www.sdxcentral.com/news/kubernetes-gatekeeper-platform-at-risk-from-new-flaws/) — Vulnerabilities have been discovered in the Ingress-Nginx Kubernetes gatekeeper platform ahead of its planned obsolescence.
- [\[Security Advisory\] CVE-2025-4563: Nodes can bypass ...](https://groups.google.com/g/kubernetes-security-announce/c/Zv84LMRuvMQ) — A vulnerability exists in the NodeRestriction admission controller where nodes can bypass dynamic resource allocation authorization checks. When ...
- [Vulnerable Azure Kubernetes Service should be updated ...](https://learn.microsoft.com/en-us/answers/questions/5982526/vulnerable-azure-kubernetes-service-should-be-upda) — Azure Defender for Cloud reports: "Vulnerable Azure Kubernetes Service should be updated to resolve vulnerability findings".
- [aquasecurity/vuln-list-k8s: k8s vulnerability advisory](https://github.com/aquasecurity/vuln-list-k8s) — k8s vulnerability advisory. Contribute to aquasecurity/vuln-list-k8s development by creating an account on GitHub.
- [A container image that passed our vulnerability scan ...](https://www.reddit.com/r/kubernetes/comments/1vqla0g/a_container_image_that_passed_our_vulnerability/) — We scan images in CI and gate on criticals like everyone. An image passed clean, we shipped it. About 3 weeks later that same image, ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
