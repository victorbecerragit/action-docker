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
Last updated: 2026-10-05 (UTC)

- [Kubernetes](https://kubernetes.io/) — Kubernetes, also known as K8s, is an open source system for automating deployment, scaling, and management of containerized applications.
- [Kubernetes](https://en.wikipedia.org/wiki/Kubernetes) — Kubernetes also known as K8s, is an open-source container orchestration system for automating software deployment, scaling, and management.
- [I still don't understand what Kubernetes is : r/devops](https://www.reddit.com/r/devops/comments/rs6cim/i_still_dont_understand_what_kubernetes_is/) — K8s is a way to keep your docker containers up. If the containers become unhealthy, k8s can take them out behind the barn and shoot them, ...
- [Kubernetes (K8s)](https://github.com/kubernetes/kubernetes) — Advanced SecurityFind and fix vulnerabilities Code securitySecure your code as you build Secret protectionStop leaks before they start. Kubernetes, also known .
- [What is Kubernetes?](https://www.redhat.com/en/topics/containers/what-is-kubernetes) — A Kubernetes deployment should be: Secure. It should follow the latest security best-practices. User-friendly. It should be operable using a few ...
- [Docker Compose vs Kubernetes setup for Spark](https://forums.developer.nvidia.com/t/docker-compose-vs-kubernetes-setup-for-spark/372636) — Most people are using spark-vllm-docker and sparkrun. Kubernetes is overkill unless you have a bigger ecosystem you are integrating with.
- [Solved: Dynatrace Distributed Tracing on Kubernetes](https://community.dynatrace.com/t5/Container-platforms/Dynatrace-Distributed-Tracing-on-Kubernetes/m-p/245841) — Solved: Hey! I have deployed the Dynatrace operator on Kubernetes (cloud native approach), and I am able to see my Kubernetes cluster on my dashboard.
- [Kubernetes Tutorial: From Zero to Deployed (100% FREE)](https://www.youtube.com/watch?v=IluVqhoCChw&xstg=CAMSBhUD_LL2Hw%3D%3D) — Kubernetes seems scary? Not anymore. I'll take you from ZERO to deploying your first app - completely FREE. No credit card.
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
