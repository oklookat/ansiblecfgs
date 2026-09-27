FROM alpine:3.24.1

ARG XRAY_VERSION=26.3.27
ARG TARGETARCH=arm64-v8a

# caching
RUN apk add --no-cache --upgrade ca-certificates curl unzip

# dont caching
ARG CACHE_BUST
ARG DOWNLOAD_LINK="https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-${TARGETARCH}.zip"

ENV XRAY_LOCATION_ASSET=/usr/local/share/xray

RUN set -eux; \
    echo "Cache bust: ${CACHE_BUST}"; \
    mkdir -p /usr/local/share/xray /tmp/xray; \
    curl -fsSL "${DOWNLOAD_LINK}" -o /tmp/xray.zip; \
    unzip -j /tmp/xray.zip \
    "xray" \
    "geoip.dat" \
    "geosite.dat" \
    -d /tmp/xray; \
    install -m 0755 /tmp/xray/xray /usr/local/bin/xray; \
    install -m 0644 /tmp/xray/geoip.dat /usr/local/share/xray/geoip.dat; \
    install -m 0644 /tmp/xray/geosite.dat /usr/local/share/xray/geosite.dat; \
    rm -rf /tmp/xray /tmp/xray.zip

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["cp /usr/local/bin/xray /out/xray && cp /usr/local/share/xray/geoip.dat /out/geoip.dat && cp /usr/local/share/xray/geosite.dat /out/geosite.dat && chmod 0755 /out/xray"]
