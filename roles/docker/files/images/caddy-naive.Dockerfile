# Shared, reusable across any stack that needs a naiveproxy-capable Caddy.
# No stack-specific config is baked in here — that's mounted at runtime.

FROM golang:1.25.12-alpine AS builder

RUN apk add --no-cache git

WORKDIR /build

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Build Caddy with the naive fork of forwardproxy (adds the padding layer)
RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

COPY --from=builder /build/caddy /usr/bin/caddy

ENV XDG_DATA_HOME=/data

EXPOSE 443 80

ENTRYPOINT ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
