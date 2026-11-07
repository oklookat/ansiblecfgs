#!/bin/bash
set -e

INTERFACE="${WIREGUARD_INTERFACE:-wg0}"
CONFIG="/etc/wireguard/${INTERFACE}.conf"

if [[ ! -f "$CONFIG" ]]; then
  echo "Error: $CONFIG not found"
  exit 1
fi

# Cleanup on exit
term_handler() {
  echo "Stopping WireGuard interface ${INTERFACE}..."
  wg-quick down "$INTERFACE" || true
  exit 0
}
trap term_handler SIGTERM SIGINT

echo "Starting WireGuard interface ${INTERFACE}..."
wg-quick up "$INTERFACE"

# Keep container running
while true; do
  sleep 3600 &
  wait $!
done
