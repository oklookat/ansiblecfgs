FROM alpine:3.24.1

ARG SING_BOX_VERSION=1.14.0-rc.5
ARG TARGETARCH=arm64-musl   # или amd64, amd64-musl, arm64-glibc и т.д.

# Установка утилит (кешируется)
RUN apk add --no-cache --upgrade ca-certificates curl tar

# Скачивание и распаковка (перестраивается при каждом запуске)
ARG CACHE_BUST
ARG DOWNLOAD_LINK="https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-${TARGETARCH}.tar.gz"

RUN set -eux; \
    echo "Cache bust: ${CACHE_BUST}"; \
    curl -fsSL "${DOWNLOAD_LINK}" -o /tmp/sing-box.tar.gz; \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp; \
    mv "/tmp/sing-box-${SING_BOX_VERSION}-linux-${TARGETARCH}/sing-box" /usr/local/bin/sing-box; \
    chmod +x /usr/local/bin/sing-box; \
    rm -rf /tmp/sing-box*

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["cp /usr/local/bin/sing-box /out/sing-box && chmod 0755 /out/sing-box"]
