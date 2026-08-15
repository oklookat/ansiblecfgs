FROM golang:1.26.6-alpine AS builder

ARG TELETRACK_VERSION=main
ARG TELETRACK_REPO=https://github.com/oklookat/teletrack.git

WORKDIR /app

RUN apk add --no-cache git

# Download source
RUN git clone --depth 1 --branch "${TELETRACK_VERSION}" \
    "${TELETRACK_REPO}" .

# Dependencies
RUN go mod download

# Build
RUN CGO_ENABLED=0 GOOS=linux \
    go build \
    -trimpath \
    -ldflags="-s -w" \
    -o /teletrack \
    .


FROM alpine:3.24.1

RUN apk add --no-cache ca-certificates

ARG TELETRACK_CONFIG=/app/config.json
ENV TELETRACK_CONFIG="${TELETRACK_CONFIG}"

WORKDIR /app

COPY --from=builder /teletrack /usr/local/bin/teletrack

ENTRYPOINT ["/bin/sh", "-c", "exec /usr/local/bin/teletrack -c \"$TELETRACK_CONFIG\""]
