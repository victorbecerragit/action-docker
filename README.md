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
Last updated: 2026-11-02 (UTC)

- [Latest](https://max.codes/latest/) — Latest is a free and open source app for macOS that checks if all your apps are up to date. Get a quick overview of which apps changed and what changed
- [Latest](https://www.amnesty.org/en/latest/) — EVERYTHING YOU NEED TO KNOW ABOUT HUMAN RIGHTS. Explore our extensive library of news, blogs, films and reports, updated daily. Content Types. Campaigns
- [LATEST | English meaning - Cambridge Dictionary](https://dictionary.cambridge.org/dictionary/english/latest) — LATEST definition: 1. newest or most recent or modern: 2. the most recent news or technical development: This latest statement from the White ...
- [Sixth Assessment Report](https://www.google.com/goto?url=CAESZQHrOzAVnBbgg18TXEAJQEjUvRI9C8D2qcbLkQWIH_vW2bPs2JhufLyfamEIgs0sVjTVjZt33A2acuSuKM3BwNa4tJCwZmReaNg6S8tWAIFwJ9dqI6GW1e_US2YEm_2r5_B0Rm3w) — The Working Group II contribution, Climate Change 2022: Impacts, Adaptation and Vulnerability was released on 28 February 2022.
- [Biographical Sketch Common Form | Grants & Funding](https://www.google.com/goto?url=CAESogEB6zswFSmINAIorIqt9uuWpZtYuYf_G0eb8Zt4jDt61l4D9Xofn709z_XhBLTGKwqtohBZLflMBZrSbT4xc5wN6QwHPxqaCOSzNlpZEslBpkpznaKPePX2F5nqE6Pza4LwyLEZm-zxo1bANRwhd8hHGQXKPsSX-XwjLaq6a_N-VJRUw77Beug2UaVPF6WRptnzXEbis6CQQSrVUEbqdI1-uQs) — The Biographical Sketch Common Form is a standardized document used to summarize the qualifications, experience, and relevant contributions of key personnel
- [Latest updates: BepiColombo's arrival at Mercury](https://www.google.com/goto?url=CAESrAEB6zswFYXNKNqMn_4CoEJxeVkkOYZ4EOHLSTEG0CBg_IK624fpmfjPIigL4FcHwItVWRZy4Blc-kHutPrKgrn6acS5uCzTNEeMwmV82wdBc8SepXErDgS7RZAhrNs0M4B-jWk-6mMiXgskCACK8C1P1WAogI6YebdwRLe2SK4Yj-SIk3q7CO2F1AByx8-TIB-aj227aSQFC3fd5JEMVULSkBUiqr4ZxkiyQcTn) — This page will show the latest updates throughout the mission's arrival. BepiColombo is a world-class science mission led by the European Space Agency (ESA) in
- [Not a Blog | George R.R. Martin](https://www.google.com/goto?url=CAESXwHrOzAVPPEnzEMOCx6T-3mj9Cjxy2Oxnoe2SpYy_mhZptLG7SDFf6mLCkGW3kFcbGAts-p__CEcQXJtNaFIk-Hlk7dtm966oKzYheH_Jg9bCb227KOTOvM8N8HfjCZr) — This blog is the only place for official communication from George R.R. Martin. For press inquiries, please contact David Moench Latest Month ...
- [ChatGPT - App Store - Apple](https://www.google.com/goto?url=CAESbQHrOzAVLMn3Syzc6vBHvc_nUoJor9MfDZUZLDC6yId92RQF79VQUYAq14zZUuqARPmk_b2zX-hxK9SUDxEc9nhkTer7XuTJctMe12L9zKcGcRxfmctHjF4eisvEZsMQ_vaXU_s9q94t_fnBxxg) — Introducing ChatGPT for iOS: OpenAI's latest advancements at your fingertips. This official app is free, syncs your history across devices, and brings you ...
- [The choices we make about AI now are critical | Bill Gates](https://www.google.com/goto?url=CAEShQEB6zswFSv9ii-VEGexq1p8MkwDIbJPDCjklDxluDPXrfu5wCPZAQuT9g0e-vjJyOHYgJ3Nj287VQHm6jvs7fIB4lH8OBP7OXtsr4Mddcd_oGgEOQzcrJahch9PzRr493Z6aLjbvjnUxUfsZC50laZV7-DuHGp_JBKVJYJIHvJ6IA0yR11F) — How will we protect the people who are most vulnerable to the harms caused by artificial intelligence, including those who lose their ...
<!-- KUBE_CVEs_END -->

## Learning Context

Original components were based on exercises from "Programming with Kubernetes" (educative.io) and demonstrate webhook implementations for Kubernetes API server authentication and authorization flows, extended for additional OSS tools that I worked with/or experimented.
