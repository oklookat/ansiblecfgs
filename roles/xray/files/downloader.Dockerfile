# builder
FROM alpine:3.24.1 AS builder

ARG XRAY_VERSION=26.3.27
ARG XRAY_ARCH=linux-arm64-v8a

# cached
RUN apk add --no-cache ca-certificates curl unzip

# not cache
ARG CACHE_BUST
RUN set -eux; \
    echo "Cache bust: ${CACHE_BUST}"; \
    url="https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-${XRAY_ARCH}.zip"; \
    echo "Downloading ${url}"; \
    curl -fsSL --retry 3 "${url}" -o /tmp/xray.zip; \
    mkdir -p /dist; \
    unzip -j /tmp/xray.zip xray geoip.dat geosite.dat -d /dist; \
    chmod 0755 /dist/xray

# final
FROM alpine:3.24.1

ENV XRAY_LOCATION_ASSET=/usr/local/share/xray

COPY --from=builder /dist/xray /usr/local/bin/xray
COPY --from=builder /dist/geoip.dat /dist/geosite.dat /usr/local/share/xray/

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["install -m 0755 /usr/local/bin/xray /out/xray && install -m 0644 /usr/local/share/xray/geoip.dat /out/geoip.dat && install -m 0644 /usr/local/share/xray/geosite.dat /out/geosite.dat"]
