FROM alpine:3.24.1

ARG TELETRACK_CONFIG=/app/config.json
ENV TELETRACK_CONFIG="${TELETRACK_CONFIG}"
ENV TELETRACK_DATA="/var/lib/teletrack"
ARG TELETRACK_VERSION=0.1.3
ARG DOWNLOAD_LINK="https://github.com/oklookat/teletrack/releases/download/v${TELETRACK_VERSION}/teletrack_linux_amd64"

RUN apk add --no-cache ca-certificates curl tzdata \
    && mkdir -p /app /usr/local/bin \
    && curl -fsSL "${DOWNLOAD_LINK}" -o /usr/local/bin/teletrack \
    && chmod +x /usr/local/bin/teletrack \
    && apk del curl

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c", "exec /usr/local/bin/teletrack -c \"$TELETRACK_CONFIG\""]
