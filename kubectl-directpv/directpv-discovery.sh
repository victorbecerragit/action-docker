#!/bin/bash

export TERM=dumb
export NO_COLOR=1

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Configuration from environment variables
DANGEROUS_MODE="${DANGEROUS_MODE:-false}"
WAIT_TIME="${WAIT_TIME:-5m}"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting DirectPV setup for all nodes"

# Discover drives
log "Discovering drives on all nodes"
if kubectl directpv discover --timeout=$WAIT_TIME --output-file drives-discovery-all-nodes.yaml; then
    log "Drive discovery completed"
else
    log "ERROR: Drive discovery failed"
    exit 1
fi

# Initialize drives if dangerous mode is enabled
if [ "$DANGEROUS_MODE" = "true" ]; then
    log "Initializing drives (dangerous mode enabled)"
    if kubectl directpv --quiet init "drives-discovery-all-nodes.yaml" --dangerous; then
        log "Drive initialization completed successfully"
    else
        log "ERROR: Drive initialization failed"
        exit 1
    fi
else
    log "Skipping drive initialization (dangerous mode disabled)"
fi

log "DirectPV setup completed for all nodes"

