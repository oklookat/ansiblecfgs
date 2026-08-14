#!/bin/sh
set -e

cd /data

if [ ! -f wgcf-account.toml ]; then
    echo ">>> Registering new Cloudflare WARP account..."
    wgcf register --accept-tos
else
    echo ">>> Account already exists, skipping registration"
fi

if [ -n "$LICENSE_KEY" ]; then
    echo ">>> Setting Warp+ license key..."
    wgcf update --license-key "$LICENSE_KEY"
fi

if [ ! -f wgcf-profile.conf ]; then
    echo ">>> Generating WireGuard profile..."
    wgcf generate
else
    echo ">>> Profile already exists, skipping generation"
fi

echo "Done!"
