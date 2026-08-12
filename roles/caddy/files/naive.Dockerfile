FROM alpine:3.24.1

ARG CADDY_VERSION=2.11.2-naive
ARG CADDY_ARCHIVE_NAME="caddy-forwardproxy-naive.tar.xz"
ARG CADDY_URL="https://github.com/klzgrad/forwardproxy/releases/download/v${CADDY_VERSION}/${CADDY_ARCHIVE_NAME}"

RUN apk add --no-cache \
    ca-certificates \
    curl \
    xz

RUN set -eux; \
    cd /tmp; \
    curl -fsSL -o "${CADDY_ARCHIVE_NAME}" "${CADDY_URL}"; \
    tar -xJf "${CADDY_ARCHIVE_NAME}" "caddy-forwardproxy-naive/caddy"; \
    install -m 0755 "caddy-forwardproxy-naive/caddy" /usr/bin/caddy; \
    rm -rf "${CADDY_ARCHIVE_NAME}" caddy-forwardproxy-naive

# To change caddy dir, to have a predictable mount point for certificate and account data.
ENV XDG_DATA_HOME=/data

EXPOSE 443 80

ENTRYPOINT ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
