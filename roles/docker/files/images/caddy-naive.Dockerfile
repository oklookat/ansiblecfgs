FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl

ARG CADDY_VERSION=2.11.4
ARG CADDY_BIN_NAME="caddy-linux-amd64"
ARG CADDY_SHA_NAME="caddy-linux-amd64.sha256"

ARG CADDY_BIN="https://github.com/oklookat/caddy-forwardproxy-naive/releases/download/v${CADDY_VERSION}/${CADDY_BIN_NAME}"
ARG CADDY_SHA_FILE="https://github.com/oklookat/caddy-forwardproxy-naive/releases/download/v${CADDY_VERSION}/${CADDY_SHA_NAME}"

RUN set -eux; \
    cd /tmp; \
    curl -fsSL -o "${CADDY_BIN_NAME}" \
    "${CADDY_BIN}"; \
    curl -fsSL -o "${CADDY_SHA_NAME}" \
    "${CADDY_SHA_FILE}"; \
    sha256sum -c "${CADDY_SHA_NAME}"; \
    install -m 0755 "${CADDY_BIN_NAME}" /usr/bin/caddy; \
    rm "${CADDY_BIN_NAME}" "${CADDY_SHA_NAME}"

ENV XDG_DATA_HOME=/data

EXPOSE 443 80

ENTRYPOINT ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
