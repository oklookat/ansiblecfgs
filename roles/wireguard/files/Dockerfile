FROM alpine:3.24.1

RUN apk add --no-cache \
    wireguard-tools \
    iptables \
    ip6tables \
    openresolv \
    bash \
    && rm -rf /var/cache/apk/*

# Simple entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
