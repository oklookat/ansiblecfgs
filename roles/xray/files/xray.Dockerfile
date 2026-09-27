FROM alpine:3.24.1

ARG XRAY_VERSION=26.3.27
ARG TARGETARCH=linux-64
ARG DOWNLOAD_LINK="https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-${TARGETARCH}.zip"

ENV XRAY_LOCATION_CONFIG=/etc/xray \
    XRAY_LOCATION_ASSET=/usr/local/share/xray

RUN set -eux; \
    apk add --no-cache --upgrade \
    ca-certificates \
    curl \
    unzip \
    tzdata \
    wireguard-tools; \
    mkdir -p /etc/xray /usr/local/share/xray /tmp/xray; \
    curl -fsSL "${DOWNLOAD_LINK}" -o /tmp/xray.zip; \
    unzip -j /tmp/xray.zip \
    "xray" \
    "geoip.dat" \
    "geosite.dat" \
    -d /tmp/xray; \
    install -m 0755 /tmp/xray/xray /usr/local/bin/xray; \
    install -m 0644 /tmp/xray/geoip.dat /usr/local/share/xray/geoip.dat; \
    install -m 0644 /tmp/xray/geosite.dat /usr/local/share/xray/geosite.dat; \
    rm -rf /tmp/xray /tmp/xray.zip; \
    xray version; \
    wg --version

ENTRYPOINT ["xray"]
CMD ["run"]
