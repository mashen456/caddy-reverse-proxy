#!/bin/sh

set -euo pipefail

# for backwards compatibility, separates host and port from url
export FRONTEND_DOMAIN=${FRONTEND_DOMAIN:-${FRONTEND_HOST%:*}}
export FRONTEND_PORT=${FRONTEND_PORT:-${FRONTEND_HOST##*:}}

export BACKEND_DOMAIN=${BACKEND_DOMAIN:-${BACKEND_HOST%:*}}
export BACKEND_PORT=${BACKEND_PORT:-${BACKEND_HOST##*:}}

# strip https:// or http:// from domain if necessary
FRONTEND_DOMAIN=${FRONTEND_DOMAIN##*://}
BACKEND_DOMAIN=${BACKEND_DOMAIN##*://}

echo using frontend: ${FRONTEND_DOMAIN} with port: ${FRONTEND_PORT}
echo using backend: ${BACKEND_DOMAIN} with port: ${BACKEND_PORT}
echo using guest-frontend: ${GUEST_FRONTEND_DOMAIN:-not set} with port: ${GUEST_FRONTEND_PORT:-not set}
echo using guest-backend: ${GUEST_BACKEND_DOMAIN:-not set} with port: ${GUEST_BACKEND_PORT:-not set}

exec caddy run --config Caddyfile --adapter caddyfile 2>&1
