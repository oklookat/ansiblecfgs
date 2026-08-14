FROM alpine:3.24.1

ARG WGCF_VERSION=2.2.32
ARG TARGETARCH=amd64

ARG DOWNLOAD_LINK="https://github.com/ViRb3/wgcf/releases/download/v${WGCF_VERSION}/wgcf_${WGCF_VERSION}_linux_${TARGETARCH}"

RUN apk add --no-cache ca-certificates curl && \
    curl -fsSL "${DOWNLOAD_LINK}" -o /usr/local/bin/wgcf && \
    chmod +x /usr/local/bin/wgcf && \
    apk del curl

WORKDIR /data
VOLUME ["/data"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
