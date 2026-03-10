# ── build stage ───────────────────────────────────────────────
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Cache dependency downloads separately from source
COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o serp-search .

# ── runtime stage ─────────────────────────────────────────────
FROM scratch

LABEL maintainer="kube-refresh"
LABEL description="Generic SerpAPI search runner (Go)"

# scratch has no shell; copy the static binary + TLS CA certs
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/serp-search /serp-search

# ── environment variables ──────────────────────────────────────
# SERPAPI_KEY   – required, pass at runtime with -e
# SEARCH_QUERY  – default query (overridden by CMD args)
# SEARCH_ENGINE – defaults to google
# NUM_RESULTS   – how many results to show (default 5)
# DEBUG         – set to 1 to dump raw JSON response

ENV SEARCH_QUERY="latest Kubernetes releases" \
    SEARCH_ENGINE="google" \
    NUM_RESULTS="5" \
    DEBUG="0"

ENTRYPOINT ["/serp-search"]
# Default: uses SEARCH_QUERY env var
# Override by passing args after the image name:
#   docker run ... serp-search-go "latest S3-compatible storage"
CMD []
