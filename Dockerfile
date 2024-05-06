# First stage: download and extract the busybox binary
FROM alpine as builder
RUN apk add --no-cache wget
RUN wget -O busybox https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64 && \
    chmod +x busybox

# Second stage: create the minimal image
FROM scratch
COPY --from=builder /busybox /busybox

# Run the sleep command indefinitely
CMD ["/busybox", "sleep", "infinity"]
