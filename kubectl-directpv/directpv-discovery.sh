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
if kubectl directpv discover --timeout="$WAIT_TIME" --output-file drives-discovery-all-nodes.yaml; then
    if [ ! -s drives-discovery-all-nodes.yaml ]; then
        log "No drives discovered (discovery file is empty), continuing without error"
    else
        log "Drive discovery completed"
    fi
else
    log "ERROR: Drive discovery command failed"
    # Do not exit, allow handling downstream
fi

# Initialize drives if dangerous mode is enabled and discovery file is not empty
if [ "$DANGEROUS_MODE" = "true" ]; then
    if [ -s drives-discovery-all-nodes.yaml ]; then
        log "Initializing drives (dangerous mode enabled)"
        if kubectl directpv --quiet init "drives-discovery-all-nodes.yaml" --dangerous; then
            log "Drive initialization completed successfully"
        else
            log "ERROR: Drive initialization failed, check the drives-discovery-all-nodes.yaml file"
            # Do not exit, can handle failure later or log for alerting
        fi
    else
        log "Skipping drive initialization since no drives were discovered"
    fi
else
    log "Skipping drive initialization (dangerous mode disabled)"
fi

log "DirectPV setup completed for all nodes"

