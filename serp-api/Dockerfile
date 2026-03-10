# ── build stage ───────────────────────────────────────────────
FROM python:3.12-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ── runtime stage ─────────────────────────────────────────────
FROM python:3.12-slim

LABEL maintainer="kube-refresh"
LABEL description="Generic SerpAPI search runner"

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local
COPY search.py .

# ── environment variables ──────────────────────────────────────
# SERPAPI_KEY  – required, pass at runtime with -e
# SEARCH_QUERY – default query (overridden by CMD args)
# SEARCH_ENGINE – defaults to google
# NUM_RESULTS  – how many results to show (default 5)
# DEBUG        – set to 1 to dump raw JSON response

ENV SEARCH_QUERY="latest Kubernetes releases" \
    SEARCH_ENGINE="google" \
    NUM_RESULTS="5" \
    DEBUG="0"

ENTRYPOINT ["python", "search.py"]
# Default query – override by passing args after the image name:
#   docker run ... serp-search "latest S3-compatible storage"
CMD []
