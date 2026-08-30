FROM alpine:3.24.1

ARG SING_BOX_VERSION=1.14.0-rc.5
ARG TARGETARCH=amd64-musl

ARG DOWNLOAD_LINK="https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-${TARGETARCH}.tar.gz"

RUN set -eux; \
    apk add --no-cache --upgrade \
    ca-certificates \
    curl \
    tar \
    tzdata; \
    curl -fsSL "${DOWNLOAD_LINK}" -o /tmp/sing-box.tar.gz; \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp; \
    mv "/tmp/sing-box-${SING_BOX_VERSION}-linux-${TARGETARCH}/sing-box" \
    /usr/local/bin/sing-box; \
    chmod +x /usr/local/bin/sing-box; \
    rm -rf /tmp/sing-box*

RUN sing-box version

ENTRYPOINT ["sing-box"]

CMD ["-D", "/var/lib/sing-box", "-c", "/etc/sing-box/config.json", "run"]
